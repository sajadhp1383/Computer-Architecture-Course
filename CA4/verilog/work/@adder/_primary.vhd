library verilog;
use verilog.vl_types.all;
entity Adder is
    port(
        a               : in     vl_logic_vector(31 downto 0);
        b               : in     vl_logic_vector(31 downto 0);
        w               : out    vl_logic_vector(31 downto 0)
    );
end Adder;
