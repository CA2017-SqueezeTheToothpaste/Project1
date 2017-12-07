#!/bin/bash

rm -f yes.vvp hello.vcd output.txt
iverilog -o yes.vvp *.v
echo "finish
" | vvp yes.vvp

