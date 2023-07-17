use orion::operators::tensor::implementations::impl_tensor_u32::Tensor_u32;
use orion::operators::tensor::core::{Tensor, ExtraParams, TensorTrait};

fn all(arr: Tensor<u32>) -> bool {
    return arr.min() == 1;
}