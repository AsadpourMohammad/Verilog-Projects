IVERILOG=iverilog
VVP=vvp
GTKWAVE=gtkwave
MODULE=module

all:
	$(IVERILOG) -o ${MODULE}_out $(MODULE).v ${MODULE}_tb.v

	${VVP} ${MODULE}_out

	$(GTKWAVE) $(MODULE).vcd