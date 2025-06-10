module datapath(clk, rst, StallF, StallD, RegWriteW, FlushD, BranchD, RegWriteD, MemWriteD, JumpD, ALUSrcD,
                ALUControlD, ImmSrcD, ResultSrcD, LuiD, FlushE, Rs1, Rs2);

    input wire clk, rst, StallF, StallD, RegWriteW, FlushD, BranchD, RegWriteD, MemWriteD, JumpD, ALUSrcD;
    input wire FlushE,LuiD;
    input wire[2:0] ALUControlD;
    input wire[1:0] ImmSrcD, ResultSrcD;
    
    output [4:0] Rs1, Rs2;

    wire [31:0] PCPlus4F, PCTargetE, PCFprim, PCF, InstructionMemoryOut, RdW, ResultW, RD1out, RD2out, ExtImmD, PCPlus4E, ALUResultE;
    wire [31:0] ExtImmE, PCPlus4D, InstrD, PCD;
    wire [31:0] RD1D, RD2D, RD1E, RD2E;
    wire [4:0] Rs1D, Rs2D, RdD, Rs1E, Rs2E, RdE;
    wire [2:0] ALUControlE;
    wire RegWriteE, BranchE, MemWriteE, JumpE, ALUSrcE, LuiE;

/////////////////////////////////////////// IF ///////////////////////////////////////////////////////////////
    
    
    MUX3to1 mux1(.in0(PCPlus4F), .in1(PCTargetE), .in2(ALUResultE), .sel(StallF), .out(PCFprim));

    Register #(32) PC(.in(PCFprim), .clk(clk), .rst(rst), .out(PCF)); 

    InstructionMemory IM(.pc(PCF), .instruction(InstructionMemoryOut));

    Adder adder1(.a(PCF),.b(3'b100),.w(PCPlus4F));


    EnRegister #(32) IF1(.in(InstructionMemoryOut), .clk(clk), .rst(rst), .clr(FlushD), .en(~(StallD)) ,.out(InstrD)); 

    EnRegister #(32) IF2(.in(PCF), .clk(clk), .rst(rst), .clr(FlushD), .en(~(StallD)) ,.out(PCD)); 

    EnRegister #(32) IF3(.in(PCPlus4F), .clk(clk), .rst(rst), .clr(FlushD), .en(~(StallD)) ,.out(PCPlus4D)); 

/////////////////////////////////////////// End IF ////////////////////////////////////////////////////////////

/////////////////////////////////////////// ID ///////////////////////////////////////////////////////////////

    RegisterFile RF(.clk(clk),.rst(rst),.A1(Rs1D),.A2(Rs2D),.A3(RdD),.WD3(ResultW),.WE3(RegWriteW),.RD1(RD1out),.RD2(RD2out));
    assign Rs1D = InstrD[19:15];
    assign Rs2D = InstrD[24:20];
    assign RdD  = InstrD[11:7];

    ImmediateExtend Extend(.immSrc(ImmSrcD), .in(InstrD[31:7]), .out(ExtImmD));
    
    EnRegister #(32) ID1(.in(ExtImmD), .clk(clk), .rst(rst), .en(1'b1), .clr(FlushE), .out(ExtImmE)); 

    EnRegister #(32) ID2(.in(PCPlus4D), .clk(clk), .rst(rst), .en(1'b1), .clr(FlushE), .out(PCPlus4E));  

    EnRegister #(5) ID3(.in(Rs1D), .clk(clk), .rst(rst), .en(1'b1), .clr(FlushE), .out(Rs1E));  

    EnRegister #(5) ID4(.in(Rs2D), .clk(clk), .rst(rst), .en(1'b1), .clr(FlushE), .out(Rs2E));  

    EnRegister #(5) ID5(.in(RdD), .clk(clk), .rst(rst), .en(1'b1), .clr(FlushE), .out(RdE)); 

    EnRegister #(32) ID6(.in(RD1D), .clk(clk), .rst(rst), .en(1'b1), .clr(FlushE), .out(RD1E)); 

    EnRegister #(32) ID7(.in(RD2D), .clk(clk), .rst(rst), .en(1'b1), .clr(FlushE), .out(RD2E)); 

    EnRegister #(3) ID8(.in(ALUControlD), .clk(clk), .rst(rst), .en(1'b1), .clr(FlushE), .out(ALUControlE));
    
    EnRegister #(1) ID9(.in(BranchD), .clk(clk), .rst(rst), .en(1'b1), .clr(FlushE), .out(BranchE)); 

    EnRegister #(1) ID10(.in(JumpD), .clk(clk), .rst(rst), .en(1'b1), .clr(FlushE), .out(JumpE)); 

    EnRegister #(1) ID11(.in(MemWriteE), .clk(clk), .rst(rst), .en(1'b1), .clr(FlushE), .out(MemWriteE));

    EnRegister #(2) ID12(.in(ResultSrcD), .clk(clk), .rst(rst), .en(1'b1), .clr(FlushE), .out(ResultSrcE));

    EnRegister #(1) ID13(.in(RegWriteD), .clk(clk), .rst(rst), .en(1'b1), .clr(FlushE), .out(RegWriteE)); 

    EnRegister #(1) ID14(.in(ALUSrcD), .clk(clk), .rst(rst), .en(1'b1), .clr(FlushE), .out(ALUSrcE));

    EnRegister #(1) ID15(.in(LuiD), .clk(clk), .rst(rst), .en(1'b1), .clr(FlushE), .out(LuiE)); 


/////////////////////////////////////////// End ID ////////////////////////////////////////////////////////////
    
 
 
    

 




endmodule