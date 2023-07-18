#[cfg(test)]
mod tests {
    use zkdiffpriv::utils::sum::{sum_array};
    use zkdiffpriv::dp::dynamic::{optimal_priv_param};

    use array::ArrayTrait;
    use array::SpanTrait;

    use orion::numbers::fixed_point::core::{FixedType, FixedTrait};
    use orion::numbers::fixed_point::implementations::impl_8x23::{FP8x23Impl, ONE, PI, FP8x23Add, FP8x23AddEq, FP8x23Sub, FP8x23Mul, FP8x23Div, FP8x23PartialOrd, FP8x23PartialEq};
    use orion::numbers::signed_integer::{integer_trait::IntegerTrait};

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
    }

    // We use the 'sum' query as an example
    fn get_q(arr: Array<FixedType>) -> FixedType {
        return sum_array(arr);
    }
}