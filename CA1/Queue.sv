module Queue(input clk, rst, enqueue, dequeue, recover, input [1:0] Din, output logic full, empty, output logic [1:0] Dout);

    logic [1:0] queue [255:0];      
    logic [1:0] backup_queue [255:0]; 
    logic [7:0] read_ptr, write_ptr, count, backup_count;

    always @(posedge clk, rst) begin
        if (rst) begin
            read_ptr <= 0; write_ptr <= 0; count <= 0; full <= 0; empty <= 1; backup_count <= 0;
        end else begin
            if (enqueue && ~full) begin
                queue[write_ptr] <= Din;
                write_ptr <= (write_ptr + 1) % 256;
                count <= count + 1;
            end
            if (dequeue && ~empty) begin
                Dout <= queue[read_ptr];
                backup_queue[backup_count] <= queue[read_ptr];
                backup_count <= backup_count + 1;
                read_ptr <= (read_ptr + 1) % 256;
                count <= count - 1;
            end
            if (recover && empty && backup_count > 0) begin
                for (int i = 0; i < backup_count; i=i+1) begin
                    queue[i] <= backup_queue[i];
                end
                read_ptr <= 0;
                write_ptr <= backup_count;
                count <= backup_count;
                empty <= 0;
                backup_count <= 0;
            end
            full <= (count == 256);
            empty <= (count == 0);
        end
    end
endmodule