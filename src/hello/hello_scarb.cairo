#[starknet::interface]
trait MyContractInterface<T> {
    fn name_get(self: @T) -> felt252;
    fn name_set(ref self: T, name: felt252);
    fn jo(ref self: T, nums: Array<u64>);
}

#[starknet::contract]
mod my_contract {
    use array::ArrayTrait;
    use zkdiffpriv::utils::sum::lol;
    use orion::numbers::fixed_point::core::{FixedType, FixedTrait};
    use orion::numbers::fixed_point::implementations::impl_8x23::{
        FP8x23Impl, FP8x23Add, FP8x23AddEq, FP8x23Into, FP8x23PartialEq, FP8x23Sub,
        FP8x23SubEq, FP8x23Mul, FP8x23MulEq, FP8x23Div, FP8x23DivEq, FP8x23PartialOrd, FP8x23Neg
    };

    #[storage]
    struct Storage {
        name: felt252,
    }

    #[event]
    #[derive(Drop, starknet::Event)]
    enum Event {
        NameChanged: NameChanged,
    }

    #[derive(Drop, starknet::Event)]
    struct NameChanged {
        previous: felt252,
        current: felt252,
    }

    #[constructor]
    fn constructor(ref self: ContractState, name: felt252) {
        self.name.write(name);
    }

    #[external(v0)]
    impl MyContract of super::MyContractInterface<ContractState> {
        fn name_get(self: @ContractState) -> felt252 {
            let mut arr: Array<FixedType> = ArrayTrait::new();
            arr.append(FixedTrait::new_unscaled(1_u128, false));
            lol();
            self.name.read()
        }

        fn name_set(ref self: ContractState, name: felt252) {
            let previous = self.name.read();
            self.name.write(name);
            self.emit(NameChanged { previous, current: name });
        }

        fn jo(ref self: ContractState, nums: Array<u64>) {
        }
    }
}