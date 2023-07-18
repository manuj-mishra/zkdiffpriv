mod core;
mod util;

use array::ArrayTrait;
use array::SpanTrait;
use debug::PrintTrait;

use orion::numbers::fixed_point::core::{FixedType, FixedTrait};
use orion::numbers::fixed_point::implementations::impl_8x23::{FP8x23Impl, ONE, PI, FP8x23Add, FP8x23AddEq, FP8x23Sub, FP8x23Mul, FP8x23Div, FP8x23PartialOrd, FP8x23PartialEq, FP8x23Print};
use orion::numbers::signed_integer::{integer_trait::IntegerTrait};

use util::{sum_array};
use core::{optimal_priv_param};

#[test]
#[available_gas(10000000)]
fn test_lib() {
    let mut arr = ArrayTrait::new();
    arr.append(FixedTrait::new_unscaled(1_u128, false));
    arr.append(FixedTrait::new_unscaled(5_u128, false));
    arr.append(FixedTrait::new_unscaled(2_u128, false));
    arr.append(FixedTrait::new_unscaled(8_u128, false));

    let q = get_q(arr);
    'This is true sum'.print();
    q.print();

    let p = optimal_priv_param(
        FixedTrait::new_unscaled(1_u128, false),
        FixedTrait::new_unscaled(11_u128, false),
        FixedTrait::new_unscaled(11_u128, false),
        FixedTrait::new_unscaled(1_u128, false) / FixedTrait::new_unscaled(100_u128, false));
    'This is sigma'.print();
    p.print()
}


// We use the 'sum' query as an example
fn get_q(arr: Array<FixedType>) -> FixedType {
    return sum_array(arr);
}

// fn main() -> u128 {
//     return 0;
// }