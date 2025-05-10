`timescale 1ns/1ns


module TEST_RISCV();

    reg clk = 0, rst = 0;

    top_module risc_v(clk, rst);

    always #20 clk = ~clk;

    always begin 
        #50 rst = 1; #50 rst = 0;
        #15000
        #20 $stop;
    end

endmodule