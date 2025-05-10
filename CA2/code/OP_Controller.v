`define R_TYPE 7'b0110011
`define I_TYPE 7'b0010011
`define S_TYPE 7'b0100011
`define B_TYPE 7'b1100011
`define J_TYPE 7'b1101111
`define U_TYPE 7'b0110111
`define LW  7'b0000011
`define JALR 7'b1100111

module OP_Controller(op,pcsrc, funct3, zero, resultsrc,memWrite,ALUSrc,ImmSrc,regWrite,sel);
    input [6:0] op;
    input [2:0] funct3;
    input zero;
    output reg [2:0] ImmSrc;    
    output reg [1:0] pcsrc,resultsrc;                
    output reg memWrite,ALUSrc,regWrite,sel;

    always @(op, zero) begin
        case(op)
            `R_TYPE:begin
                pcsrc= 2'b00;
                resultsrc= 2'b00;
                memWrite= 1'b0;
                ALUSrc= 1'b0;
                // ImmSrc = ; //dont care
                regWrite= 1'b1;
                sel= 1'b0;
                end
            `I_TYPE:begin
                pcsrc= 2'b00;
                resultsrc= 2'b00;
                memWrite= 1'b0;
                ALUSrc= 1'b1;
                ImmSrc = 3'b000; 
                regWrite= 1'b1;
                sel= 1'b0;
            end
            `S_TYPE:begin
                pcsrc= 2'b00;
                // resultsrc= ; //dont care
                memWrite= 1'b1;
                ALUSrc= 1'b1;
                ImmSrc = 3'b001;
                regWrite= 1'b0; // ba erfan check beshe
                sel= 1'b0;
            end
            `J_TYPE:begin
                pcsrc= 2'b01;
                resultsrc= 2'b10;
                memWrite= 1'b0;
                // ALUSrc= ; //dont care
                ImmSrc = 3'b100;
                regWrite= 1'b1;
                sel= 1'b0;
            end
            `B_TYPE:begin
                // pcsrc= ; //set in ALU controller
                // resultsrc= ; //dont care
                memWrite= 1'b0;
                ALUSrc= 1'b0;
                ImmSrc = 3'b010;
                regWrite= 1'b0;
                sel= 1'b0;
                case(funct3)
                    3'h0: pcsrc = zero ? 2'b01 : 2'b00;  // beq
                    3'h1:  pcsrc = zero ? 2'b00 : 2'b01;  //bne
                endcase
            end
            `U_TYPE:begin
                pcsrc= 2'b00;
                resultsrc= 2'b00;
                memWrite= 1'b0;
                ALUSrc= 1'b1;
                ImmSrc = 3'b011;
                regWrite= 1'b1;
                sel= 1'b1;
            end
            `LW: begin
                pcsrc = 2'b0;
                resultsrc = 2'b01;
                memWrite = 1'b0;
                ALUSrc = 1'b1;
                ImmSrc = 3'b0;
                regWrite = 1'b1;
            end
            `JALR: begin
                pcsrc = 2'b10;
                resultsrc = 2'b10;
                memWrite = 1'b0;
                ALUSrc = 1'b1;
                ImmSrc = 3'b0;
                regWrite = 1'b1;
            end
            default:begin
                pcsrc= 2'b00;
                resultsrc= 2'b00;
                memWrite= 1'b0;
                ImmSrc = 3'b000;
                ALUSrc= 1'b0;
                regWrite= 1'b0;
                sel= 1'b0;
            end
        endcase
    end
endmodule
