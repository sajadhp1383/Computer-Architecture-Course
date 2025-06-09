module MUX3to1(in0,in1,in2,sel,out);
    input [31:0] in0, in1, in2;
    input [1:0] sel;
    output [31:0] out;
    assign out = (sel == 2'b00) ? in0 :
                 (sel == 2'b01) ? in1 :
                 (sel == 2'b10) ? in2 :
                 32'b0;
endmodule

module MUX2to1(in0, in1, sel, out);
    input [31:0] in0, in1;
    input sel;
    output reg [31:0] out;

    assign out = sel ? in1 : in0;

endmodule