library verilog;
use verilog.vl_types.all;
entity riscv_processor is
    port(
        clk             : in     vl_logic;
        rst             : in     vl_logic
    );
end riscv_processor;
