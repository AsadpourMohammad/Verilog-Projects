IVERILOG=iverilog
VVP=vvp
GTKWAVE=gtkwave
ADDRESS=./
MODULE=module

all:
	@echo "Compiling..."
	$(IVERILOG) -o ${MODULE}_out $(MODULE).v ${MODULE}_tb.v
	@echo "Running the testbench..."
	${VVP} ${MODULE}_out
	@echo "Opening the waveform viewer..."
	$(GTKWAVE) $(MODULE).vcd

clean:
	@echo "Cleaning up..."
	find . -type f \( -name "*.vcd" -o -name "*_out" \) -delete

.PHONY: all clean
