module datapath(clk,rst,pcsrc,resultsrc,memWrite,ALUControl,ALUSrc,ImmSrc,regWrite,sel,op,funct3,funct7,zero);
    input clk,rst;
    input [1:0] ImmSrc,pcsrc,resultsrc;                
    input memWrite,ALUSrc,regWrite,sel;
    input [2:0] ALUControl;

    output reg zero;
    output reg [2:0] funct3;
    output reg [6:0] funct7;
    output reg [3:0] op;

    wire [31:0] PCPlus4,PCNext,PC,PCTarget,result,Instr,ImmExt,SrcA,SrcB,SrcB2,ALUResult,readData;

    MUX4to1 MUX1(.in0(PCPlus4),.in1(PCTarget),.in2(ALUResult),.in3(32'b0),.sel(pcsrc),.out(PCNext));

    registor PC(.pcnext(PCNext),.clk(clk),.rst(rst),.out(PC));

    InstructionMemory IM(.pc(PC),.instruction(Instr));
    assign op = Instr[6:0];
    assign funct3 = Instr[14:12];
    assign funct7 = Instr[31:25];

    adder PC4(.a(PC),.b(32'b100),.result(PCPlus4));

    ImmediateExtend Extend(.immSrc(ImmSrc),.in(Instr[31:7]),.out(ImmExt));

    RegisterFile RF(.clk(clk),.rst(rst),.A1(Instr[19:15]),.A2(Instr[24:20]),.A3(Instr[11:7]),.WD3(result),.WE3(regWrite),.RD1(SrcA),.RD2(SrcB));

    MUX2to1 MUX2(.i0(SrcB),.i1(ImmExt),.sel(ALUSrc),.out(SrcB));

    MUX2to1 MUX3(.i0(SrcB),.i1(2'd12),.sel(sel),.out(SrcB2));

    ALU ALU(.a(SrcA),.b(SrcB2),.op(ALUControl),.aluout(ALUResult),.zero(zero));

    adder PCBranch(.a(PC),.b(ImmExt),.result(PCTarget));

    DataMemory DM(.clk(clk),.addr(ALUResult),.WD(SrcB),.WE(memWrite),.RD(readData));

    MUX4to1 MUX4(.i0(ALUResult),.i1(readData),.i2(PCPlus4),.i3(ImmExt),.sel(resultsrc),.out(result));
endmodule