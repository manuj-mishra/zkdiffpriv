#[starknet::interface]
trait MyContractInterface<T> {
    fn name_get(self: @T) -> felt252;
    fn name_set(ref self: T, name: felt252);
}

#[starknet::contract]
mod my_contract {
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
            self.name.read()
        }

        fn name_set(ref self: ContractState, name: felt252) {
            let previous = self.name.read();
            self.name.write(name);
            self.emit(NameChanged { previous, current: name });
        }
    }
}