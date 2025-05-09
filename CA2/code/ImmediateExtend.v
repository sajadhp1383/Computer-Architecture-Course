module ImmediateExtend(immSrc, in, out);
    input [24:0] in;
    input [2:0]immSrc;
    output reg [31:0] out;

    always @(immSrc,in)begin
        case(immSrc)
            3'b000  : out <= {{20{in[24]}}, in[24:13]};
            3'b001  : out <= {{20{in[24]}}, in[24:18], in[4:0]};
            3'b010  : out <= {{20{in[24]}}, in[0], in[23:18], in[4:1], 1'b0};
            3'b011  : out <= {in[24:5], {12{1'b0}}};
            3'b100  : out <= {{12{in[24]}}, in[12:5], in[13], in[23:14], 1'b0};
            default: out <= 32'b0; 

        endcase
    end
endmodule
