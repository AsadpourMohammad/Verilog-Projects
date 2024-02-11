# Verilog

A series of small projects for learning `Verilog` Language

## Description

This repository contains different `Verilog` projects that were created for learning purposes in `Computer Architecture` Course in `Noshirvani University of Technology`.

Each project contains a module and its test bench. Some projects contain different architectural implementations of the same module.

These projects were tested using `Icarus Verilog` on Manjaro Linux.

## Requirements

- Icarus Verilog
- GTKWave

## Guide

All modules and their test benches can be compiled and run with the Makefile

```bash
    make MODULE=module_name
```

The Makefile will run the following commands:

### Compiling

```bash
    iverilog -o module_name_out module_name.v module_name_tb.v
```

### Running

```bash
    vvp module_name_tb
```

### Viewing with GTKWave

```bash
    gtkwave module_name.vcd
```

Put the module and its test bench in the same directory and run the Makefile with the module name to see the results.

## Modules

- Adder:
  - [Half Adder](./ADDER/HA)
  - [Full Adder](./ADDER/FA)
- ALU:
  - [ALU](./ALU)
- BUS:
  - [Bus](./BUS)
- Counter:
  - [Counter](./COUNTER)
- Finite State Machine:
  - [FSM](./FSM)
- Seven Segment:
  - [SSD](./SEVEN-SEGMENT)
- Pipeline Project:
  - [Pipeline](./PIPELINE-PROJECT)
