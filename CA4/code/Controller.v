
module controller(op, funct3, funct7, ResultSrcD, MemWriteD, ALUControlD,
                    ALUSrcD, ImmSrcD, RegWriteD, BranchD, JumpD);
    input [2:0] funct3;
    input [6:0] op, funct7;
    output wire [1:0] ResultSrcD;                
    output wire [2:0] ALUControlD, ImmSrcD;
    output wire MemWriteD, ALUSrcD, RegWriteD;

    ALU_Controller ALU_Controller_inst(
        .funct3(funct3),
        .funct7(funct7),
        .op(op),
        .ALUControlD(ALUControlD)
    );
    OP_Controller OP_Controller_inst(
        .op(op),
        .funct3(funct3),
        .ResultSrcD(ResultSrcD),
        .MemWriteD(MemWriteD),
        .ALUSrcD(ALUSrcD),
        .ImmSrcD(ImmSrcD),
        .RegWriteD(RegWriteD),
    );
endmodule