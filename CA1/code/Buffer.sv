module Buffer_2bit(input en, input [1:0] din, output [1:0] dout);
    assign dout = en ? din : 2'bx;
endmodule