use orion::operators::tensor::implementations::impl_tensor_u32::Tensor_u32;
use orion::operators::tensor::core::{Tensor, ExtraParams, TensorTrait};
use array::ArrayTrait;

fn all(arr: Tensor<u32>) -> bool {
    return arr.min() == 1;
}

fn sum_array(arr: Array<u64>) -> u64 {
    return sum_array_rec(arr, 0, 0);
}

fn sum_array_rec(arr: Array<u64>, idx: usize, mut sum: u64) -> u64 {
    sum += *arr.at(idx);

    if idx == arr.len() - 1 {
        return sum;
    }

    return sum_array_rec(arr, idx + 1, sum);
}

#[test]
#[available_gas(2000000)]
fn test_sum_array() {
    let mut arr = ArrayTrait::<u64>::new();
    arr.append(1);
    arr.append(2);
    arr.append(3);

    assert(sum_array(arr) == 6, 'ya');
}
