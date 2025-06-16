module datapath(clk, rst, StallF, StallD, ForwardAE, ForwardBE, FlushD, Rs1D, Rs2D, BranchD, RegWriteD, MemWriteD, JumpD, ALUSrcD,
                ALUControlD, ImmSrcD, ResultSrcD, LuiD, FlushE, zero, funct3, funct7, op, Rs1E, Rs2E, PCSrcE,RegWriteW,
                sel_adderD, RdE, RdM, BranchE, RegWriteM, ResultSrcE, RdW, ResultSrcM, ResultSrcW);

    input wire clk, rst, StallF, StallD, FlushD, RegWriteD, MemWriteD, JumpD, ALUSrcD;
    input wire FlushE, LuiD, RegWriteM, sel_adderD;
    input wire[2:0] ALUControlD, ImmSrcD;
    input wire[1:0] ResultSrcD, BranchD, ForwardAE, ForwardBE;
    
    output wire [4:0] RdE, Rs1E, Rs2E, RdM, RdW, Rs1D, Rs2D;
    output wire [1:0] BranchE, ResultSrcM, ResultSrcE, ResultSrcW;
    output wire PCSrcE, RegWriteW;
    output wire zero;
    output wire [2:0] funct3;
    output wire [6:0] funct7, op;

    wire [31:0] PCPlus4F, PCTargetE, PCFprim, PCF, InstructionMemoryOut, ResultW, ExtImmD, PCPlus4E;
    wire [31:0] ExtImmE, PCPlus4D, InstrD, PCD, SrcAE, WriteDataE, SrcBE, ALUResultM, ALUResultE, PCE, ExtImmM, PCPlus4M;
    wire [31:0] RD1D, RD2D, RD1E, RD2E, WriteDataM;
    wire [4:0] RdD;
    wire [2:0] ALUControlE;
    wire RegWriteE, MemWriteE, JumpE, ALUSrcE, LuiE, ZeroE, Zero, Branch, Jump;
    wire MemWriteM, LuiM, sel_adderE;




/////////////////////////////////////////// IF ///////////////////////////////////////////////////////////////
    
    
    MUX2to1 mux1(.in0(PCPlus4F), .in1(PCTargetE), .sel(PCSrcE), .out(PCFprim));

    Register #(32) PC(.in(PCFprim), .en(~StallF), .clk(clk), .rst(rst), .out(PCF)); 

    InstructionMemory IM(.pc(PCF), .instruction(InstructionMemoryOut));

    Adder adder1(.a(PCF),.b(32'd4),.w(PCPlus4F));

    EnRegister #(32) IF1(.in(InstructionMemoryOut), .clk(clk), .rst(rst), .clr(FlushD), .en(~(StallD)) ,.out(InstrD)); 

    EnRegister #(32) IF2(.in(PCF), .clk(clk), .rst(rst), .clr(FlushD), .en(~(StallD)), .out(PCD)); 

    EnRegister #(32) IF3(.in(PCPlus4F), .clk(clk), .rst(rst), .clr(FlushD), .en(~(StallD)) ,.out(PCPlus4D)); 

/////////////////////////////////////////// End IF ////////////////////////////////////////////////////////////

/////////////////////////////////////////// ID ///////////////////////////////////////////////////////////////

    assign op = InstrD[6:0];
    assign funct3 = InstrD[14:12];
    assign funct7 = InstrD[31:25];

    wire [24:0] temp;
    RegisterFile RF(.clk(clk),.rst(rst),.A1(Rs1D),.A2(Rs2D),.A3(RdW),.WD3(ResultW),.WE3(RegWriteW),.RD1(RD1D),.RD2(RD2D));
    assign Rs1D = InstrD[19:15];
    assign Rs2D = InstrD[24:20];
    assign RdD  = InstrD[11:7];
    assign temp = InstrD[31:7];
    ImmediateExtend Extend(.immSrc(ImmSrcD), .in(temp), .out(ExtImmD));
    
    EnRegister #(32) ID1(.in(ExtImmD), .clk(clk), .rst(rst), .en(1'b1), .clr(FlushE), .out(ExtImmE)); 

    EnRegister #(32) ID2(.in(PCPlus4D), .clk(clk), .rst(rst), .en(1'b1), .clr(FlushE), .out(PCPlus4E));  

    EnRegister #(5) ID3(.in(Rs1D), .clk(clk), .rst(rst), .en(1'b1), .clr(FlushE), .out(Rs1E));  

    EnRegister #(5) ID4(.in(Rs2D), .clk(clk), .rst(rst), .en(1'b1), .clr(FlushE), .out(Rs2E));

    EnRegister #(32) ID5(.in(PCD), .clk(clk), .rst(rst), .en(1'b1), .clr(FlushE), .out(PCE));  

    EnRegister #(5) ID6(.in(RdD), .clk(clk), .rst(rst), .en(1'b1), .clr(FlushE), .out(RdE)); 

    EnRegister #(32) ID7(.in(RD1D), .clk(clk), .rst(rst), .en(1'b1), .clr(FlushE), .out(RD1E)); 

    EnRegister #(32) ID8(.in(RD2D), .clk(clk), .rst(rst), .en(1'b1), .clr(FlushE), .out(RD2E)); 

    EnRegister #(3) ID9(.in(ALUControlD), .clk(clk), .rst(rst), .en(1'b1), .clr(FlushE), .out(ALUControlE));
    
    EnRegister #(2) ID10(.in(BranchD), .clk(clk), .rst(rst), .en(1'b1), .clr(FlushE), .out(BranchE)); 

    EnRegister #(1) ID11(.in(JumpD), .clk(clk), .rst(rst), .en(1'b1), .clr(FlushE), .out(JumpE)); 

    EnRegister #(1) ID12(.in(MemWriteE), .clk(clk), .rst(rst), .en(1'b1), .clr(FlushE), .out(MemWriteE));

    EnRegister #(2) ID13(.in(ResultSrcD), .clk(clk), .rst(rst), .en(1'b1), .clr(FlushE), .out(ResultSrcE));

    EnRegister #(1) ID14(.in(RegWriteD), .clk(clk), .rst(rst), .en(1'b1), .clr(FlushE), .out(RegWriteE)); 

    EnRegister #(1) ID15(.in(ALUSrcD), .clk(clk), .rst(rst), .en(1'b1), .clr(FlushE), .out(ALUSrcE));

    EnRegister #(1) ID16(.in(LuiD), .clk(clk), .rst(rst), .en(1'b1), .clr(FlushE), .out(LuiE)); 

    EnRegister #(1) ID17(.in(sel_adderD), .clk(clk), .rst(rst), .en(1'b1), .clr(FlushE), .out(sel_adderE)); 


/////////////////////////////////////////// End ID ////////////////////////////////////////////////////////////

/////////////////////////////////////////// Exe ////////////////////////////////////////////////////////////
    wire [31:0] outMuxAdd;

    MUX4to1  MUX1(.in0(RD1E), .in1(ResultW), .in2(ALUResultM), .in3(ExtImmM), .sel(ForwardAE), .out(SrcAE));
    MUX4to1  MUX2(.in0(RD2E), .in1(ResultW), .in2(ALUResultM), .in3(ExtImmM), .sel(ForwardBE), .out(WriteDataE));
    MUX2to1  MUX3(.in0(WriteDataE), .in1(ExtImmE), .sel(ALUSrcE), .out(SrcBE));
    ALU AluE(.a(SrcAE), .b(SrcBE), .op(ALUControlE), .aluout(ALUResultE), .zero(ZeroE));

    BranchBox brbox(.Zero(ZeroE), .Branch(BranchE), .Jump(JumpE), .PCSrc(PCSrcE));

    MUX2to1 MuxAdder(.in0(PCE), .in1(RD1E), .sel(sel_adderE), .out(outMuxAdd));
    Adder adderE(.a(outMuxAdd), .b(ExtImmE), .w(PCTargetE));
    

    EnRegister #(1) Exe1(.in(RegWriteE), .clk(clk), .rst(rst), .en(1'b1), .clr(1'b0), .out(RegWriteM));

    EnRegister #(2) Exe2(.in(ResultSrcE), .clk(clk), .rst(rst), .en(1'b1), .clr(1'b0), .out(ResultSrcM));

    EnRegister #(1) Exe3(.in(MemWriteE), .clk(clk), .rst(rst), .en(1'b1), .clr(1'b0), .out(MemWriteM));

    EnRegister #(1) Exe4(.in(LuiE), .clk(clk), .rst(rst), .en(1'b1), .clr(1'b0), .out(LuiM));

    EnRegister #(32) Exe5(.in(ALUResultE), .clk(clk), .rst(rst), .en(1'b1), .clr(1'b0), .out(ALUResultM));

    EnRegister #(32) Exe6(.in(WriteDataE), .clk(clk), .rst(rst), .en(1'b1), .clr(1'b0), .out(WriteDataM));

    EnRegister #(5) Exe7(.in(RdE), .clk(clk), .rst(rst), .en(1'b1), .clr(1'b0), .out(RdM));

    EnRegister #(32) Exe8(.in(ExtImmE), .clk(clk), .rst(rst), .en(1'b1), .clr(1'b0), .out(ExtImmM));

    EnRegister #(32) Exe9(.in(PCPlus4E), .clk(clk), .rst(rst), .en(1'b1), .clr(1'b0), .out(PCPlus4M));

/////////////////////////////////////////// End Exe ////////////////////////////////////////////////////////////

/////////////////////////////////////////// M ////////////////////////////////////////////////////////////

    wire [31:0] PCPlus4W, ReadDataM, ALUResultW, ReadDataW, ExtImmW;

    DataMemory dataMem(.clk(clk), .memWrite(MemWriteM), .addr(ALUResultM), .writeData(WriteDataM), .readData(ReadDataM));

    EnRegister #(1) M1(.in(RegWriteM), .clk(clk), .rst(rst), .en(1'b1), .clr(1'b0), .out(RegWriteW));

    EnRegister #(2) M2(.in(ResultSrcM), .clk(clk), .rst(rst), .en(1'b1), .clr(1'b0), .out(ResultSrcW));

    EnRegister #(32) M3(.in(ALUResultM), .clk(clk), .rst(rst), .en(1'b1), .clr(1'b0), .out(ALUResultW));
    
    EnRegister #(32) M4(.in(ReadDataM), .clk(clk), .rst(rst), .en(1'b1), .clr(1'b0), .out(ReadDataW));

    EnRegister #(5) M5(.in(RdM), .clk(clk), .rst(rst), .en(1'b1), .clr(1'b0), .out(RdW));

    EnRegister #(32) M6(.in(ExtImmM), .clk(clk), .rst(rst), .en(1'b1), .clr(1'b0), .out(ExtImmW));

    EnRegister #(32) M7(.in(PCPlus4M), .clk(clk), .rst(rst), .en(1'b1), .clr(1'b0), .out(PCPlus4W));


/////////////////////////////////////////// End M ////////////////////////////////////////////////////////////

/////////////////////////////////////////// WB ////////////////////////////////////////////////////////////
    MUX4to1 MUX5(.in0(ALUResultW), .in1(ReadDataW), .in2(PCPlus4W), .in3(ExtImmW), .sel(ResultSrcW), .out(ResultW));

/////////////////////////////////////////// End WB ////////////////////////////////////////////////////////////


endmodule