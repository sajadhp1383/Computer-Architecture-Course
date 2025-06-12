library verilog;
use verilog.vl_types.all;
entity DataMemory is
    port(
        clk             : in     vl_logic;
        memWrite        : in     vl_logic;
        addr            : in     vl_logic_vector(31 downto 0);
        writeData       : in     vl_logic_vector(31 downto 0);
        readData        : out    vl_logic_vector(31 downto 0)
    );
end DataMemory;
