module Memory (clk, we, addr, din, dout);
    input  clk;
    input  we;             
    input  [4:0] addr;      
    input  [7:0] din;      
    output logic [7:0] dout;

    reg [7:0] mem [0:31];

    initial begin
        $readmemb("main_test.mem", mem);
    end

    always_ff @(posedge clk) begin
        if (we) begin
            mem[addr] <= din;
        end
    end

    always_comb begin
        dout = mem[addr];
    end

endmodule
