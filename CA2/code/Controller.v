module controller(op,zero,funct3,funct7,pcsrc,resultsrc,memWrite,ALUControl,ALUSrc,ImmSrc,regWrite,sel);
    input zero;
    input [2:0] funct3;
    input [6:0] op,funct7;
    output wire memWrite,ALUSrc,regWrite,sel;
    output wire [1:0] pcsrc, resultsrc;                
    output wire [2:0] ALUControl, ImmSrc;  

    ALU_Controller ALU_Controller_inst(
        .zero(zero),
        .funct3(funct3),
        .funct7(funct7),
        .op(op),
        .ALUControl(ALUControl)
    );
    OP_Controller OP_Controller_inst(
        .op(op),
        .zero(zero),
        .funct3(funct3),
        .pcsrc(pcsrc),
        .resultsrc(resultsrc),
        .memWrite(memWrite),
        .ALUSrc(ALUSrc),
        .ImmSrc(ImmSrc),
        .regWrite(regWrite),
        .sel(sel)
    );
endmodule