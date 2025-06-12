library verilog;
use verilog.vl_types.all;
entity Control_Unit is
    port(
        op              : in     vl_logic_vector(6 downto 0);
        funct3          : in     vl_logic_vector(2 downto 0);
        RegWriteD       : out    vl_logic;
        ResultSrcD      : out    vl_logic_vector(1 downto 0);
        MemWriteD       : out    vl_logic;
        JumpD           : out    vl_logic;
        BranchD         : out    vl_logic_vector(1 downto 0);
        ImmSrcD         : out    vl_logic_vector(2 downto 0);
        ALUSrcD         : out    vl_logic;
        sel_adder       : out    vl_logic
    );
end Control_Unit;
