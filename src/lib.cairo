mod core;

use array::ArrayTrait;
use array::SpanTrait;

use orion::operators::tensor::core::{Tensor, ExtraParams, TensorTrait};
use orion::numbers::fixed_point::core::FixedType;
use orion::numbers::signed_integer::{integer_trait::IntegerTrait};

use core::{BoundedTensor, BoundedTensorTrait, get_q};

fn main() -> u32 {
    let btensor = example_btensor();
    return get_q(btensor);
}

// 1D bounded tensor generator
fn example_btensor() -> BoundedTensor<u32> {
    let mut shape = ArrayTrait::new();
    shape.append(3);
		
    let mut data = ArrayTrait::new();
    data.append(1);
    data.append(1);
    data.append(3);

    let extra = Option::<ExtraParams>::None(());
    let tensor = TensorTrait::<u32>::new(shape.span(), data.span(), extra);
	let bounded_tensor = BoundedTensorTrait::<u32>::new(tensor, 0, 3);
    return bounded_tensor;
}

// fn init_priv_param(a: u32, b:u32, q: u32, eps: FixedType) {
//     let dom_size = b - a;
//     let sq_res =  (fp.new(q, false) / eps) * (dom_size + fp.new(q/2, false));
//     return sq_res * sq_res;
// }

// fn optimal_priv_param(i: Tensor<u32>, w: Tensor<u32>, b: Tensor<u32>) -> Tensor<u32> {
//     let x = NNTrait::linear(i, w, b);
//     NNTrait::relu(@x, IntegerTrait::new(0, false))
// }

