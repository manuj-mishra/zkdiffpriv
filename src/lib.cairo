mod core;
mod util;

use array::ArrayTrait;
use array::SpanTrait;

use orion::operators::tensor::implementations::impl_tensor_u32::Tensor_u32;
use orion::operators::tensor::core::{Tensor, ExtraParams, TensorTrait};
// use orion::numbers::fixed_point::core::{FixedType, FixedTrait};
use orion::numbers::fixed_point::core::{FixedType};
// use orion::numbers::fixed_point::implementations::impl_8x23::{FP8x23Impl};
use orion::numbers::signed_integer::{integer_trait::IntegerTrait};

// use core::{BoundedTensor, BoundedTensorTrait, get_q};
use core::{get_q};
use util::{all};

#[test]
#[available_gas(2000000)]
fn generate_bounded_tensor() -> Tensor<u32> {
    // TODO: bounded tensors
    // let btensor = example_btensor();

    let mut singleton = ArrayTrait::new();
    singleton.append(1);

    let mut lower_bound = ArrayTrait::new();
    lower_bound.append(0);

    let mut upper_bound = ArrayTrait::new();
    upper_bound.append(3);

    let lower = TensorTrait::<u32>::new(singleton.span(), lower_bound.span(), Option::<ExtraParams>::None(()));

    let upper = TensorTrait::<u32>::new(singleton.span(), upper_bound.span(), Option::<ExtraParams>::None(()));

    let tensor = tensor_1D();

    assert(all(upper.greater_equal(@lower)), 'Upper < Lower');
    assert(all(tensor.greater_equal(@lower)), 'Lower bound is not respected');
    assert(all(tensor.less_equal(@upper)), 'Upper bound is not respected');

    return tensor;
}

// Example 1D Tensor
fn tensor_1D() -> Tensor<u32> {
    let mut shape = ArrayTrait::new();
    shape.append(3);
		
    let mut data = ArrayTrait::new();
    data.append(0);
    data.append(1);
    data.append(2);

    let extra = Option::<ExtraParams>::None(());
		
    let tensor = TensorTrait::<u32>::new(shape.span(), data.span(), extra);
		
    return tensor;
}

// // 1D bounded tensor generator
// fn example_btensor() -> BoundedTensor<u32> {
//     let mut shape = ArrayTrait::new();
//     shape.append(3);
		
//     let mut data = ArrayTrait::new();
//     data.append(1);
//     data.append(1);
//     data.append(3);

//     let extra = Option::<ExtraParams>::None(());
//     let tensor = TensorTrait::<u32>::new(shape.span(), data.span(), extra);
// 	let bounded_tensor = BoundedTensorTrait::<u32>::new(tensor, 0, 3);
//     return bounded_tensor;
// }



