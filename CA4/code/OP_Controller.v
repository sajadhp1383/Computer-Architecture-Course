`define R_TYPE 7'b0110011
`define I_TYPE 7'b0010011
`define S_TYPE 7'b0100011
`define B_TYPE 7'b1100011
`define J_TYPE 7'b1101111
`define U_TYPE 7'b0110111
`define LW  7'b0000011
`define JALR 7'b1100111

module Control_Unit(op, funct3, RegWriteD, ResultSrcD, MemWriteD,
                     JumpD, BranchD, ImmSrcD, ALUSrcD, sel_adder);
    input [6:0] op;
    input [2:0] funct3;
    output reg [2:0] ImmSrcD;    
    output reg [1:0] ResultSrcD, BranchD; 
    output reg RegWriteD, ALUSrcD, RegWriteD, JumpD, MemWriteD, sel_adder;

    always @(op, zero) begin
        case(op)
            `R_TYPE:begin
                ResultSrcD = 2'b00;
                MemWriteD= 1'b0;
                ALUSrcD= 1'b0;
                RegWriteD= 1'b1;
                end
            `I_TYPE:begin
                ResultSrcD = 2'b00;
                MemWriteD= 1'b0;
                ALUSrcD= 1'b1;
                ImmSrcD = 3'b000; 
                RegWriteD= 1'b1;
            end
            `S_TYPE:begin
                MemWriteD= 1'b1;
                ALUSrcD= 1'b1;
                ImmSrcD = 3'b001;
                RegWriteD= 1'b0;
            end
            `J_TYPE:begin
                ResultSrcD = 2'b10;
                MemWriteD = 1'b0;
                ImmSrcD = 3'b100;
                RegWriteD= 1'b1;
                JumpD = 1'b1;
            end
            `B_TYPE:begin
                MemWriteD= 1'b0;
                ALUSrcD= 1'b0;
                ImmSrcD = 3'b010;
                RegWriteD = 1'b0;
                BranchD = 1'b1;
            end
            `U_TYPE:begin
                ResultSrcD = 2'b00;
                MemWriteD= 1'b0;
                ALUSrcD= 1'b1;
                ImmSrcD = 3'b011;
                RegWriteD= 1'b1;
            end
            `LW: begin
                ResultSrcD  = 2'b01;
                MemWriteD = 1'b0;
                ALUSrcD = 1'b1;
                ImmSrcD = 3'b0;
                RegWriteD = 1'b1;
            end
            `JALR: begin
                ResultSrcD = 2'b10;
                MemWriteD = 1'b0;
                ALUSrcD = 1'b1;
                ImmSrcD = 3'b0;
                RegWriteD = 1'b1;
            end
            default:begin
                ResultSrcD = 2'b00;
                MemWriteD= 1'b0;
                ImmSrcD = 3'b000;
                ALUSrcD= 1'b0;
                RegWriteD= 1'b0;
            end
        endcase
    end
endmodule
