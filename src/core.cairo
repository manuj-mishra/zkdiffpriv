use orion::operators::tensor::implementations::impl_tensor_u32::Tensor_u32;
use orion::operators::tensor::core::{Tensor, ExtraParams, TensorTrait};
use orion::numbers::fixed_point::core::{FixedType, FixedTrait};

// ================== Bounded Tensor ==================

// #[derive(Copy, Drop)]
// struct BoundedTensor<T> {
//     tensor: Tensor<T>,
//     lower: T,
//     upper: T,
// }

// trait BoundedTensorTrait<T> {
//     //TDOO: add bounds checking
//     fn new(tensor: Tensor<T>, lower: T, upper: T) -> BoundedTensor<T>;

//     fn reduce_sum(&self, axis: usize, keepdims: bool) -> T {
//         return self.tensor.reduce_sum(axis, keepdims);
//     }
// }


// impl BoundedTensor_u32 of BoundedTensorTrait<u32> {
//     fn new(tensor: Tensor<u32>, lower: u32, upper: u32) -> BoundedTensor<u32> {
//         return BoundedTensor {
//             tensor: tensor,
//             lower: lower,
//             upper: upper,
//         };
//     }

//     fn reduce_sum(&self, axis: usize, keepdims: bool) -> u32 {
//         return reduce_sum(self, axis, keepdims);
//     }
// }

// ================== DiffPriv ==================


// We use the 'sum' query as an example
fn get_q(x: Tensor<u32>) -> Tensor<u32> {
    return x.reduce_sum(0, false);
}

// fn init_priv_param(a: FixedType, b:FixedType, q:FixedType, eps: FixedType) -> FixedType {
//     let sq_res =  (q / eps) * (b - a + (q / 2);
//     return sq_res * sq_res;
// }

// fn optimal_priv_param(i: Tensor<u32>, w: Tensor<u32>, b: Tensor<u32>) -> Tensor<u32> {
//     let x = NNTrait::linear(i, w, b);
//     NNTrait::relu(@x, IntegerTrait::new(0, false))
// }
