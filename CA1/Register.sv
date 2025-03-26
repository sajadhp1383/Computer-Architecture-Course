module Reg_4Bit(input clk,rst, ld, input [3:0] PI, output logic [3:0] PO);

    always @(posedge clk, posedge rst) begin
        if(rst)
            PO <= 0;
        else
           PO <= (ld) ? PI: PO;
    end

endmodule


module Reg_2Bit(input clk,rst, ld, input [1:0] PI, output logic [1:0] PO);

    always @(posedge clk, posedge rst) begin
        if(rst)
            PO <= 0;
        else
           PO <= (ld) ? PI: PO;
    end

endmodule