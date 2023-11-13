# Verilog

## Guide

All modules and their test benches can be compiled and run with the Makefile.

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

### View with GTKWave

```bash
    gtkwave module_name.vcd
```
