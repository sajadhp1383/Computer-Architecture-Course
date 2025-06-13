module riscv_processor(clk,rst);
    input clk,rst;

    wire clk, rst, StallF, StallD, FlushD, RegWriteD, MemWriteD, JumpD, ALUSrcD;
    wire FlushE, LuiD, zero, PCSrcE, sel_adderD, RegWriteW, RegWriteM;
    wire [2:0] ALUControlD, funct3, ImmSrcD;
    wire [1:0] ResultSrcD, BranchD, ResultSrcE, ResultSrcM, ResultSrcW;
    wire [4:0] Rs1, Rs2, RdE, Rs1E, Rs2E, RdM, RdW;
    wire [6:0] funct7, op;
    wire [1:0] BranchE, ForwardAE, ForwardBE;

    datapath dp(
    .clk(clk),
    .rst(rst),
    .StallF(StallF),
    .StallD(StallD),
    .ForwardAE(ForwardAE),
    .ForwardBE(ForwardBE),
    .FlushD(FlushD), 
    .BranchD(BranchD), 
    .RegWriteD(RegWriteD), 
    .MemWriteD(MemWriteD), 
    .JumpD(JumpD), 
    .ALUSrcD(ALUSrcD),
    .ALUControlD(ALUControlD), 
    .ImmSrcD(ImmSrcD), 
    .ResultSrcD(ResultSrcD), 
    .LuiD(LuiD), 
    .FlushE(FlushE), 
    .Rs1(Rs1), 
    .Rs2(Rs2),
    .RdE(RdE),
    .Rs1E(Rs1E),
    .Rs2E(Rs2E),
    .zero(zero),
    .funct3(funct3),
    .funct7(funct7), 
    .op(op),
    .BranchE(BranchE),
    .PCSrcE(PCSrcE),
    .ResultSrcE(ResultSrcE),
    .RdM(RdM),               
    .RegWriteM(RegWriteM),   
    .RegWriteW(RegWriteW),
    .sel_adderD(sel_adderD)
);


    controller con(
        .op(op),
        .funct3(funct3),
        .funct7(funct7),
        .ResultSrcD(ResultSrcD),
        .MemWriteD(MemWriteD),
        .ALUControlD(ALUControlD),
        .ALUSrcD(ALUSrcD),
        .ImmSrcD(ImmSrcD),
        .RegWriteD(RegWriteD),
        .BranchD(BranchD),
        .JumpD(JumpD),
        .sel_adder(sel_adderD)
    );

    HazardUnit hazard_unit(
        .StallF(StallF),
        .StallD(StallD),
        .FlushD(FlushD),
        .FlushE(FlushE),
        .ForwardAE(ForwardAE),
        .ForwardBE(ForwardBE),
        .RegWriteM(RegWriteM),
        .RegWriteW(RegWriteW),
        .ResultSrcE(ResultSrcE),
        .ResultSrcM(ResultSrcM),
        .ResultSrcW(ResultSrcW),
        .PCSrcE(PCSrcE),
        .Rs1D(Rs1),
        .Rs2D(Rs2),
        .Rs1E(Rs1E),
        .Rs2E(Rs2E),
        .RdE(RdE),
        .RdM(RdM),
        .RdW(RdW)
    );

endmodule
