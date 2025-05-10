module top_module(clk,rst);
    input clk, rst;
    wire [2:0] funct3;
    wire [6:0] funct7;
    wire [6:0] op;
    wire [1:0] pcsrc, resultsrc;
    wire memWrite, aluSrc, regWrite, sel;
    wire [2:0] ALUControl, immSrc;
    wire zero;

    controller controller_inst(
        .op(op),
        .zero(zero),
        .funct3(funct3),
        .funct7(funct7),
        .pcsrc(pcsrc),
        .resultsrc(resultsrc),
        .memWrite(memWrite),
        .ALUControl(ALUControl),
        .ALUSrc(aluSrc),
        .ImmSrc(immSrc),
        .regWrite(regWrite),
        .sel(sel)
    );
    datapath datapath_inst(
        .clk(clk),
        .rst(rst),
        .pcsrc(controller_inst.pcsrc),
        .resultsrc(controller_inst.resultsrc),
        .memWrite(controller_inst.memWrite),
        .ALUControl(controller_inst.ALUControl),
        .ALUSrc(controller_inst.ALUSrc),
        .ImmSrc(controller_inst.ImmSrc),
        .regWrite(controller_inst.regWrite),
        .sel(controller_inst.sel),
        .op(controller_inst.op),
        .funct3(controller_inst.funct3),
        .funct7(controller_inst.funct7),
        .zero(zero)
    );

endmodule