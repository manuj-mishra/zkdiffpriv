use orion::operators::tensor::implementations::impl_tensor_u32::Tensor_u32;
use orion::operators::tensor::core::{Tensor, ExtraParams, TensorTrait};
use orion::numbers::fixed_point::core::{FixedType, FixedTrait};
use orion::numbers::fixed_point::implementations::impl_16x16::{FP16x16Impl, ONE, PI, FP16x16Add, FP16x16AddEq, FP16x16Sub, FP16x16Mul, FP16x16Div, FP16x16PartialOrd};
use array::ArrayTrait;
use debug::PrintTrait;

const TWO: u128 = 16777216;

fn all(arr: Tensor<u32>) -> bool {
    return arr.min() == 1;
}

fn sum_array(arr: Array<FixedType>) -> FixedType {
    return _sum_array_rec(arr, 0, FixedTrait::new(0, false));
}

fn _sum_array_rec(arr: Array<FixedType>, idx: usize, mut sum: FixedType) -> FixedType {
    sum += *arr.at(idx);

    if idx == arr.len() - 1 {
        return sum;
    }

    return _sum_array_rec(arr, idx + 1, sum);
}

// #[test]
// #[available_gas(2000000)]
// fn test_sum_array() {
//     let mut arr = ArrayTrait::<FixedType>::new();
//     arr.append(FixedTrait::new(1, false));
//     arr.append(FixedTrait::new(2, false));
//     arr.append(FixedTrait::new(3, false));

//     let res = sum_array(arr);
//     assert(res.mag == 6, 'Magnitude is incorrect');
//     assert(res.sign == false, 'Sign is incorrect');
// }
