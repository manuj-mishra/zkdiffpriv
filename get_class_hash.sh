#!/bin/bash

CONTRACT_NAME=${CONTRACT_NAME:-my_contract}
starkli class-hash "./target/dev/zkdiffpriv_${CONTRACT_NAME}.sierra.json"