module Counter_2Bit(input clk, rst, ld, en, Iz0, input [1:0] PI, output logic [1:0] C, output logic cout);

    always @(posedge clk, posedge rst) begin
        if(rst)
            C <= 0;
        else if(Iz0)
            C <= 0;    
        else if(ld)
            C <= PI;
        else
            {cout,C} <= (en) ? C + 1 : C;
    end

endmodule