use orion::numbers::fixed_point::core::{FixedType, FixedTrait};
use orion::numbers::fixed_point::implementations::impl_8x23::{ONE, PI};
use orion::numbers::fixed_point::implementations::impl_8x23::{
    FP8x23Impl, FP8x23Add, FP8x23AddEq, FP8x23Into, FP8x23Print, FP8x23PartialEq, FP8x23Sub,
    FP8x23SubEq, FP8x23Mul, FP8x23MulEq, FP8x23Div, FP8x23DivEq, FP8x23PartialOrd, FP8x23Neg
};

use traits::{Into, TryInto};


const TWO: u128 = 16777216;



// CDF of a Gaussian distribution
fn normcdf(x: FixedType, mu: FixedType, std: FixedType) -> FixedType {
    let z = (x - mu) / (std * FixedTrait::new_unscaled(2_u128, false).sqrt());
    let phi = (FixedTrait::new(ONE, false) + erf(z)) / FixedTrait::new_unscaled(2_u128, false);
    return phi;
}


// Approximation of the Gauss error function
fn erf(z: FixedType) -> FixedType {
    let two = FixedTrait::new_unscaled(2_u128, false);
    let coef = two / FixedTrait::new(PI, false).sqrt();
    let taylor = _erf_sum(z, 5, FixedTrait::new(0, false));
    return coef * taylor;
}

// Helper function to calculate Taylor series of erf function
fn _erf_sum(z: FixedType, n: u128, acc: FixedType) -> FixedType {
    let div_u128 = (2_u128 * n) + 1_u128;
    let coef = z / FixedTrait::new_unscaled(div_u128, false);
    let prod = _erf_prod(z, 3, FixedTrait::new(ONE, false));
    let new_acc = acc + (coef * prod);

    if (n == 0_u128) {
        return new_acc;
    }

    return _erf_sum(z, n - 1_u128, new_acc);
}

// Helper function to calculate inner product of erf function
fn _erf_prod(z: FixedType, k: u128, acc: FixedType) -> FixedType {
    let z_sq = z * z;
    let neg_z_sq = FixedTrait::from_felt(-1 * z_sq.into());
    let new_acc = (acc * neg_z_sq) / FixedTrait::new_unscaled(k, false);

    if (k == 0_u128) {
        return new_acc;
    }

    return _erf_prod(z, k - 1_u128, new_acc);
}

fn C(a: FixedType, b: FixedType, s: FixedType, sigma: FixedType) -> FixedType {
    return FixedTrait::new(ONE, false) / (normcdf(b, s, sigma) - normcdf(a, s, sigma));
}

fn delta_C(a: FixedType, b: FixedType, delta_Q: FixedType, sigma: FixedType) -> FixedType {
    if delta_Q <= ((b - a) / FixedTrait::new(TWO, false)) {
        return C(a, b, a, sigma) / C(a, b, a + delta_Q, sigma);
    }

    return C(a, b, a, sigma) / C(a, b, (b + a) / FixedTrait::new(TWO, false), sigma);
}

fn sigma_0(a: FixedType, b: FixedType, delta_Q: FixedType, epsilon: FixedType) -> FixedType {
    return ((((b - a) + (delta_Q / FixedTrait::new(TWO, false))) * delta_Q) / epsilon).sqrt();
}
