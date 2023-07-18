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
#[available_gas(1000000000)]
fn test_lib() {
    let mut arr = ArrayTrait::new();
    arr.append(FixedTrait::new_unscaled(1_u128, false));
    arr.append(FixedTrait::new_unscaled(5_u128, false));
    arr.append(FixedTrait::new_unscaled(2_u128, false));
    arr.append(FixedTrait::new_unscaled(8_u128, false));

    let q = get_q(arr);

    let a = FixedTrait::new_unscaled(1_u128, false);
    let b = FixedTrait::new_unscaled(11_u128, false);
    let del_q = b - a;
    let eps = FixedTrait::new_unscaled(1_u128, false) / FixedTrait::new_unscaled(10_u128, false);

    let p = optimal_priv_param(a, b, del_q, eps);

    'This is sigma'.print();
    p.mag.print()
}


// We use the 'sum' query as an example
fn get_q(arr: Array<FixedType>) -> FixedType {
    return sum_array(arr);
}
