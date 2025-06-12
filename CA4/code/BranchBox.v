module BranchBox(Zero, Branch, Jump, PCSrc);
    input Zero, Jump;
    input [1:0] Branch;
    output PCSrc;

    assign PCSrc = ((Zero && Branch[0]) || (~Zero && Branch[1])) || Jump;

endmodule