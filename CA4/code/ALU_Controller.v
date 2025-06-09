`define R_TYPE 7'b0110011
`define I_TYPE 7'b0010011
`define S_TYPE 7'b0100011
`define B_TYPE 7'b1100011
`define J_TYPE 7'b1101111
`define U_TYPE 7'b0110111
`define LW  7'b0000011
`define JALR  7'b1100111



module ALU_Controller(funct3, funct7, op, ALUControlD);
    input [2:0] funct3;
    input [6:0] funct7;
    input [6:0] op;
    output reg [2:0] ALUControlD;

    always@(funct3 or funct7 or op) begin
        case(op)
            `R_TYPE:begin
                case(funct3)
                    3'h00:begin
                        if(funct7==7'h0) ALUControlD=3'b0; //add
                        else if(funct7==7'h20) ALUControlD=3'b001; //sub
                    end
                    3'h06: if(funct7==7'h00) ALUControlD=3'b011; //or
                    3'h07: if(funct7==7'h00) ALUControlD=3'b010; //and
                    3'h02: if(funct7==7'h00) ALUControlD=3'b101; //slt
                endcase
            end
           `I_TYPE: begin
                case(funct3)
                    3'h0: ALUControlD = 3'b000; // addi, jalr
                    3'h6: ALUControlD = 3'b011; // ori
                    3'h2: ALUControlD = 3'b101; // slti, lw 
                    3'h7: ALUControlD = 3'b010; // andi
                endcase
           end
           `S_TYPE:begin
                case(funct3)
                    3'h0: ALUControlD = 3'b000; // sw 
                endcase
           end
            `B_TYPE:begin
                case(funct3)
                    3'h0:begin // beq
                        ALUControlD = 3'b001; 
                    end
                    3'h1:begin // bne
                        ALUControlD = 3'b001; 
                    end
                endcase
            end
            `U_TYPE:
                ALUControlD = 3'b0; // lui
            `LW:
                ALUControlD = 3'b0;
            `JALR:
                ALUControlD = 3'b0;

            default: ALUControlD = 3'b000;
        endcase
end

endmodule
