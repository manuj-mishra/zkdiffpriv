
use orion::operators::tensor::core::{Tensor, ExtraParams, TensorTrait};
use orion::numbers::fixed_point::core::FixedType;

#[derive(Copy, Drop)]
struct BoundedTensor<T> {
    tensor: Tensor<T>,
    lower: T,
    upper: T,
}

trait BoundedTensorTrait<T> {
    //TDOO: add bounds checking
    fn new(tensor: Tensor<T>, lower: T, upper: T) -> BoundedTensor<T>;
}

// We use the 'sum' query as an example
fn get_q(x: BoundedTensor<u32>) -> u32 {
    return x.reduce_sum(0, false);
}