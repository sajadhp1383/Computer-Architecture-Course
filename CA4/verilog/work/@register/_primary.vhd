library verilog;
use verilog.vl_types.all;
entity \Register\ is
    generic(
        LEN             : integer := 32
    );
    port(
        \in\            : in     vl_logic_vector;
        clk             : in     vl_logic;
        rst             : in     vl_logic;
        \out\           : out    vl_logic_vector
    );
    attribute mti_svvh_generic_type : integer;
    attribute mti_svvh_generic_type of LEN : constant is 1;
end \Register\;
