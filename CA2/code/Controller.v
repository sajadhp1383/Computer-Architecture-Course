module controller(op,zero,funct3,funct7,pcsrc,resultsrc,memWrite,ALUControl,ALUSrc,ImmSrc,regWrite,sel);
    input zero;
    input [2:0] funct3;
    input [6:0] op,funct7;
    output reg memWrite,ALUSrc,regWrite,sel;
    output reg [1:0] pcsrc,resultsrc;                
    output reg [2:0] ImmSrc,ALUControl;  

    ALU_Controller ALU_Controller_inst(
        .zero(zero),
        .funct3(funct3),
        .funct7(funct7),
        .op(op),
        .ALUControl(ALUControl),
        .pcsrc(pcsrc)
    );
    OP_Controller OP_Controller_inst(
        .op(op),
        .pcsrc(pcsrc),
        .resultsrc(resultsrc),
        .memWrite(memWrite),
        .ALUControl(ALUControl),
        .ALUSrc(ALUSrc),
        .ImmSrc(ImmSrc),
        .regWrite(regWrite),
        .sel(sel)
    );
endmodule