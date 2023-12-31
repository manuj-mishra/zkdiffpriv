use orion::numbers::fixed_point::core::{FixedType, FixedTrait};
use orion::numbers::fixed_point::implementations::impl_16x16::{ONE, PI};
use orion::numbers::fixed_point::implementations::impl_16x16::{
    FP16x16Impl, FP16x16Add, FP16x16AddEq, FP16x16Into, FP16x16Print, FP16x16PartialEq, FP16x16Sub,
    FP16x16SubEq, FP16x16Mul, FP16x16MulEq, FP16x16Div, FP16x16DivEq, FP16x16PartialOrd, FP16x16Neg
};

use traits::{Into, TryInto};
use debug::PrintTrait;


const TWO: u128 = 16777216;


// CDF of a Gaussian distribution
fn normcdf(x: FixedType, mu: FixedType, std: FixedType) -> FixedType {
    let z = (x - mu) / (std * FixedTrait::new_unscaled(2_u128, false).sqrt());
    let phi = (FixedTrait::new(ONE, false) + erf(z)) / FixedTrait::new_unscaled(2_u128, false);
    return phi;
}


// Approximation of the Gauss error function
fn erf(z: FixedType) -> FixedType {
    let coef = FixedTrait::new_unscaled(2_u128, false) / FixedTrait::new(PI, false).sqrt();
    let taylor = _erf_sum(z, 5, FixedTrait::new(0, false));
    return coef * taylor;
}

// Helper function to calculate Taylor series of erf function
fn _erf_sum(z: FixedType, n: u128, acc: FixedType) -> FixedType {
    let coef = z / FixedTrait::new_unscaled((2_u128 * n) + 1_u128, false);
    let prod = _erf_prod(z, 3, FixedTrait::new(ONE, false));
    let new_acc = acc + (coef * prod);

    if (n == 0_u128) {
        return new_acc;
    }

    return _erf_sum(z, n - 1_u128, new_acc);
}

// Helper function to calculate inner product of erf function
// TODO: this always returns 0
fn _erf_prod(z: FixedType, k: u128, acc: FixedType) -> FixedType {
    let neg_z_sq = - (z * z);
    let new_acc = (acc * neg_z_sq) / FixedTrait::new_unscaled(k, false);

    if (k == 1_u128) {
        return new_acc;
    }

    return _erf_prod(z, k - 1_u128, new_acc);
}

fn C(a: FixedType, b: FixedType, s: FixedType, sigma: FixedType) -> FixedType {

    let diff = normcdf(b, s, sigma) - normcdf(a, s, sigma);
    //TODO: this should not be manual fix
    if diff == (FixedTrait::new(0, false)) {
        return FixedTrait::new_unscaled(10000_u128, false);
    }
    // return FixedTrait::new(ONE, false) / diff;
    return FixedTrait::new(ONE, false);
}

fn delta_C(a: FixedType, b: FixedType, delta_Q: FixedType, sigma: FixedType) -> FixedType {
    assert(a != b, 'a cannot equal b');
    if delta_Q <= ((b - a) / FixedTrait::new(TWO, false)) {
        return C(a, b, a, sigma) / C(a, b, a + delta_Q, sigma);
    }
    return C(a, b, a, sigma) / C(a, b, (b + a) / FixedTrait::new(TWO, false), sigma);
}

fn init_priv_param(a: FixedType, b: FixedType, delta_Q: FixedType, epsilon: FixedType) -> FixedType {
    return ((((b - a) + (delta_Q / FixedTrait::new(TWO, false))) * delta_Q) / epsilon).sqrt();
}

fn optimal_priv_param(a: FixedType, b: FixedType, delta_Q: FixedType, epsilon: FixedType) -> FixedType {
    let sigma_0 = init_priv_param(a, b, delta_Q, epsilon);
    let mut left = sigma_0 * sigma_0;
    let mut right = (((b - a) + (delta_Q / FixedTrait::new(TWO, false))) * delta_Q) / (epsilon - delta_C(a, b, delta_Q, sigma_0).ln());

    let mut intervalSize = (left + right) / FixedTrait::new(TWO, false);

    return optimal_priv_param_loop(a, b, delta_Q, epsilon, left, right, intervalSize, sigma_0);
}

fn optimal_priv_param_loop(a: FixedType, b: FixedType, delta_Q: FixedType, epsilon: FixedType, mut left: FixedType, mut right: FixedType, mut intervalSize: FixedType, mut sigma_star_sq: FixedType) -> FixedType {
    if intervalSize <= (right - left) {
        return sigma_star_sq;
    }

    intervalSize = right - left;
    sigma_star_sq = (left + right) / FixedTrait::new(TWO, false);

    let arg_cm = (((b - a) + (delta_Q / FixedTrait::new(TWO, false))) * delta_Q) / (epsilon - delta_C(a, b, delta_Q, sigma_star_sq.sqrt()).ln());

    if arg_cm >= sigma_star_sq {
        left = sigma_star_sq;
    }
    if arg_cm <= sigma_star_sq {
        right = sigma_star_sq;
    }

    return optimal_priv_param_loop(a, b, delta_Q, epsilon, left, right, intervalSize, sigma_star_sq);
}