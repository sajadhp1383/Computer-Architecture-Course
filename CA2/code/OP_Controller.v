`define R_TYPE 7'b0110011
`define I_TYPE 7'b0010011
`define S_TYPE 7'b0100011
`define B_TYPE 7'b1100011
`define J_TYPE 7'b1101111
`define U_TYPE 7'b0110111

module OP_Controller(op,pcsrc,resultsrc,memWrite,ALUControl,ALUSrc,ImmSrc,regWrite,sel);
    input [6:0] op;
    output reg [2:0] ALUControl,ImmSrc;    
    output reg [1:0] pcsrc,resultsrc;                
    output reg memWrite,ALUSrc,regWrite,sel;

    always @(op) begin
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
                regWrite= 1'b1; // ba erfan check beshe
                sel= 1'b0;
            end
            `J_TYPE:begin
                pcsrc= 2'b10;
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
