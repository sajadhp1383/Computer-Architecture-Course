module ALU(a,b,op,aluout,zero);
    input [31:0] a,b;
    input [2:0] op;
    output reg [31:0] aluout;
    output reg zero;

    always @(*) begin
        case (op)
            3'b000: aluout = a + b; //add
            3'b001: aluout = a - b; //sub
            3'b010: aluout = a & b; //and
            3'b011: aluout = a | b; //or
            3'b101: aluout = (a < b) ? 1 : 0; //slti
            3'b110: aluout = a << b; //sll
            default: aluout = 32'b0; 
        endcase

        zero = (aluout == 32'b0) ? 1 : 0; 
    end
endmodule