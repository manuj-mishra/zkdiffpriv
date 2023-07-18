#!/bin/bash

CONTRACT_ADDRESS=${CONTRACT_ADDRESS:-0x0}
FN_NAME=${FN_NAME:-name_get}

starkli invoke --watch ${CONTRACT_ADDRESS} ${FN_NAME} ${ARGS}