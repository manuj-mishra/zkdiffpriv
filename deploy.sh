#!/bin/bash

CLASS_HASH=${CLASS_HASH:-0x044255b14d8cb36815768ae61e3b8f0af81ef98ee8a8caa8950293e52a418c32}

starkli deploy --watch ${CLASS_HASH} ${CTOR_ARGS}