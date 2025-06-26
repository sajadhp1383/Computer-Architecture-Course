module Datapath(clk, rst, IRwrite, StackSrc, ALUControl, Push, Pop,
                     PCUpdate, AdrSrc, MemWrite, PCwrite, Xwrite, Ywrite, NorTop, opCode, Stackout, MemoryIn);
    input clk,rst,IRwrite,StackSrc,Push,Pop,PCUpdate,AdrSrc,MemWrite,PCwrite,Xwrite,Ywrite;
    input [1:0] ALUControl;
    output [2:0] opCode;
    output NorTop;
    output [7:0] Stackout;
    output [4:0] MemoryIn;


    wire [7:0] Memout, ALUout, Stackin, Xout, Yout, IRout, tos;
    wire [4:0] Instr_adr, PCout;
    wire cout;

    assign Instr_adr = IRout[4:0];
    assign opCode = IRout[7:5];
    assign NorTop = ~|{Stackout};

    Counter5Bit PC(.clk(clk), .rst(rst), .PI(Instr_adr), .en(PCUpdate), .ld(PCwrite), .count(PCout), .co(cout));
    
    MUX2to1_5Bit MUX1(.i0(PCout), .i1(Instr_adr), .sel(AdrSrc), .out(MemoryIn));

    Memory Instr_dataMem(.clk(clk), .we(MemWrite), .addr(MemoryIn), .din(Stackout), .dout(Memout));

    Register IR(.clk(clk), .rst(rst), .PI(Memout), .ld(IRwrite),.out(IRout));

    MUX2to1_8Bit MUX2(.i0(ALUout), .i1(Memout) , .sel(StackSrc), .out(Stackin));

    Stack stack(.clk(clk), .rst(rst), .push(Push), .pop(Pop), .tos(tos), .d_in(Stackin), .d_out(Stackout));

    Register X(.clk(clk), .rst(rst), .PI(Stackout), .ld(Xwrite),.out(Xout));
    Register Y(.clk(clk), .rst(rst), .PI(Stackout), .ld(Ywrite),.out(Yout));

    ALU ALUinst( .X(Xout), .Y(Yout), .ALU_Sel(ALUControl), .Result(ALUout));


endmodule