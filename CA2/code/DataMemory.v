module DataMemory (clk,memWrite,addr,writeData,readData);
    input clk;
    input memWrite;     
    input [31:0] addr;         
    input [31:0] writeData;    
    output wire [31:0] readData; 

    
    reg [31:0] memory [0:1023];

    
    assign readData = memory[addr[11:2]]; 

    
    always @(posedge clk) begin
        if (memWrite) begin
            memory[addr[11:2]] <= writeData;
        end
    end

endmodule
