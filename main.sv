`timescale 1ns / 1ps

module main
(
input logic clk,
input logic rst,
input bit wr_en,
input bit rd_en,
input logic [7:0] wr_ip,
output logic [7:0] rd_op,
output logic empty,
output logic full
);

parameter FULL = 8;
parameter EMPTY = 0;

logic [2:0] wr_ptr = 0;
logic [2:0] rd_ptr = 0;
logic [7:0] mem [0:7]; //MEMORY
logic [3:0] count = 0;
assign full  = (count == FULL);
assign empty = (count == EMPTY);

//Assertion for write
assert property (@(posedge clk)
disable iff (rst)
!(wr_en && full)
);

//Assertion for read
assert property (@(posedge clk)
disable iff (rst)
!(rd_en && empty)
);

//Assertion for count
assert property (@(posedge clk)
disable iff (rst)
count inside {[0:8]}
);

always_ff @(posedge clk) begin

//RESET.
if (rst) begin
wr_ptr <= 0;
rd_ptr <= 0;
count <= 0;
rd_op <= 0; 
end

else begin

//WRITE
if (wr_en && !full) begin
mem[wr_ptr] <= wr_ip;
wr_ptr <= wr_ptr + 1'b1;
end

//READ
if (rd_en && !empty) begin
rd_op <= mem[rd_ptr];
rd_ptr <= rd_ptr + 1'b1;
end

//COUNT MANAGEMENT (INC , DEC OR NO OPERATION)
case ({rd_en && !empty, wr_en && !full})
2'b10: count <= count - 1;
2'b01: count <= count + 1;
default: count <= count;
endcase

end
end

endmodule
