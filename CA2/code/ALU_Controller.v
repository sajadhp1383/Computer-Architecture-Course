`define R_TYPE 7'b0110011
`define I_TYPE 7'b0010011
`define S_TYPE 7'b0100011
`define B_TYPE 7'b1100011
`define J_TYPE 7'b1101111
`define U_TYPE 7'b0110111


module ALU_Controller(zero,funct3,funct7,op,ALU_Controller,pcsrc);
    input zero;
    input [2:0] funct3;
    input [6:0] funct7;
    input [3:0] op;
    output reg [3:0] ALU_Controller;
    output reg [1:0] pcsrc;

    always@(funct3,funct7,op) begin
        case(op)
            `R_TYPE:begin
                case(funct3)
                    2'h00:begin
                        if(funct7==2) ALUControl=3'b000; //add
                        else if(funct7==2'h20) ALUControl=3'b001; //sub
                    end
                    2'h06: if(funct7==2'h00) ALUControl=3'b011; //or
                    2'h07: if(funct7==2'h00) ALUControl=3'b010; //and
                    2'h02: if(funct7==2'h00) ALUControl=3'b101; //slt
                endcase
            end
           `I_TYPE: begin
                case(funct3)
                    2'h0: ALUControl = 3'b000; // addi, jalr
                    2'h6: ALUControl = 3'b011; // ori
                    2'h2: ALUControl = 3'b101; // slti, lw 
                    2'h7: ALUControl = 3'b010; // andi
                endcase
           end
           `S_TYPE:begin
                case(funct3)
                    2'h0: ALUControl = 3'b000; // sw 
                endcase
           end
            `B_TYPE:begin
                case(funct3)
                    2'h0:begin // beq
                        ALUControl = 3'b001; 
                        pcsrc = zero? 2'b01 : 2'b00; 
                    end
                    2'h0:begin // bne
                        ALUControl = 3'b001; 
                        pcsrc = zero? 2'b00 : 2'b01; 
                    end
                endcase
            end
            `U_TYPE:
                ALUControl = 3'b110; // lui
        endcase
end

endmodule
