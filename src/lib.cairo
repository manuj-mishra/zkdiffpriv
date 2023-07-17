use orion::operators::tensor::core::Tensor;
// use orion::operators::nn::core::NNTrait;
use orion::numbers::fixed_point::core::FixedType;
use orion::numbers::fixed_point::Fixed;
use orion::operators::nn::implementations::impl_nn_i32::NN_i32;
use orion::numbers::signed_integer::{integer_trait::IntegerTrait, i32::i32};

fn main() -> i32 {
    return add_i32_example();
}

// fn add_i32_example() -> i32 {
//     // We instantiate two signed integer here.
//     // a = 42
//     // b = -10
//     let a = IntegerTrait::<i32>::new(42, false);
//     let b = IntegerTrait::<i32>::new(10, true);

//     // We can add two signed integer as follows.
//     return a + b;
}

fn init_priv_param(a: i32, b:i32, q: i32, eps: FixedType) {
    let dom_size = b - a;
    let sq_res =  (fp.new(q, false) / eps) * (dom_size + fp.new(q/2, false));
    return sq_res * sq_res;
}

// fn optimal_priv_param(i: Tensor<i32>, w: Tensor<i32>, b: Tensor<i32>) -> Tensor<i32> {
//     let x = NNTrait::linear(i, w, b);
//     NNTrait::relu(@x, IntegerTrait::new(0, false))
// }

