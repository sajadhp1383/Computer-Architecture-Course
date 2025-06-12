library verilog;
use verilog.vl_types.all;
entity BranchBox is
    port(
        Zero            : in     vl_logic;
        Branch          : in     vl_logic_vector(1 downto 0);
        Jump            : in     vl_logic;
        PCSrc           : out    vl_logic
    );
end BranchBox;
