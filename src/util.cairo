use orion::operators::tensor::implementations::impl_tensor_u32::Tensor_u32;
use orion::operators::tensor::core::{Tensor, ExtraParams, TensorTrait};
use orion::numbers::fixed_point::core::{FixedType, FixedTrait};
use orion::numbers::fixed_point::implementations::impl_8x23::{FP8x23Impl, ONE, PI, FP8x23Add, FP8x23AddEq, FP8x23Sub, FP8x23Mul, FP8x23Div, FP8x23PartialOrd};
use array::ArrayTrait;

const TWO: u128 = 16777216;

fn all(arr: Tensor<u32>) -> bool {
    return arr.min() == 1;
}

fn sum_array(arr: Array<FixedType>) -> FixedType {
    return sum_array_rec(arr, 0, FixedTrait::new(0, false));
}

fn sum_array_rec(arr: Array<FixedType>, idx: usize, mut sum: FixedType) -> FixedType {
    sum += *arr.at(idx);

    if idx == arr.len() - 1 {
        return sum;
    }

    return sum_array_rec(arr, idx + 1, sum);
}

fn C(a: FixedType, b: FixedType, s: FixedType, sigma: FixedType) -> FixedType {
    return FixedTrait::new(ONE, false) / (phi((b - s) / sigma) - phi((a - s) / sigma));
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

fn phi(z: FixedType) -> FixedType {
    return FixedTrait::new(0, false); // TODO
}

#[test]
#[available_gas(2000000)]
fn test_sum_array() {
    let mut arr = ArrayTrait::<FixedType>::new();
    arr.append(FixedTrait::new(1, false));
    arr.append(FixedTrait::new(2, false));
    arr.append(FixedTrait::new(3, false));

    let res = sum_array(arr);
    assert(res.mag == 6, 'ya');
    assert(res.sign == false, 'ya');
}
