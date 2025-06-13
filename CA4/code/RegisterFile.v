module RegisterFile(clk,rst,A1,A2,A3,WD3,WE3,RD1,RD2);
    input clk;
    input rst;
    input [4:0] A1,A2,A3;
    input [31:0] WD3;
    input WE3;
    output [31:0] RD1,RD2;
    
    reg [31:0] regfile[31:0];
    
    integer i;
    
    always @(posedge clk or posedge rst) begin
        if (rst) begin
            for (i = 0; i < 32; i = i + 1) begin
                regfile[i] <= 32'b0;
            end
        end else if (WE3 && A3 != 5'b00000) begin
            regfile[A3] <= WD3;
        end
    end
    
    assign RD1 = (A1 == 5'b00000) ? 32'b0 : regfile[A1];
    assign RD2 = (A2 == 5'b00000) ? 32'b0 : regfile[A2];

endmodule


// module RegisterFile(input clk,we,input [4:0] A1,A2,A3,input[31:0] WD3,output[31:0] RD1,RD2);
// 	reg[31:0] regs [0:31];
// 	initial begin
// 		regs[0]=32'b0;
// 	end
// 	assign RD1=regs[A1];
// 	assign RD2=regs[A2];
// 	always@(negedge clk)begin 
// 		if(we==1&&A3!=32'b0)
// 			regs[A3]<=WD3;
// 		else
// 			regs[A3]<=regs[A3];
// 	end
// endmodule			
