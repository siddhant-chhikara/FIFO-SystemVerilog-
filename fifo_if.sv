interface fifo_if (input logic clk);

  logic rst;
  logic wr_en;
  logic rd_en;
  logic [7:0] wr_ip;
  logic [7:0] rd_op;
  logic full;
  logic empty;

  clocking cb @(posedge clk);
    output wr_en, rd_en, wr_ip;
    input  rd_op, full, empty;
  endclocking

endinterface
