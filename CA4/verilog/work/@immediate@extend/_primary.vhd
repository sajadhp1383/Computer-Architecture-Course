library verilog;
use verilog.vl_types.all;
entity ImmediateExtend is
    port(
        immSrc          : in     vl_logic_vector(2 downto 0);
        \in\            : in     vl_logic_vector(24 downto 0);
        \out\           : out    vl_logic_vector(31 downto 0)
    );
end ImmediateExtend;
