//Testbench for basic FIFO.
module tb;

  logic clk;

  fifo_if intf(clk);

  main dut (
    .clk(clk),
    .rst(intf.rst),
    .wr_en(intf.wr_en),
    .rd_en(intf.rd_en),
    .wr_ip(intf.wr_ip),
    .rd_op(intf.rd_op),
    .full(intf.full),
    .empty(intf.empty)
  );

  // components
  driver     drv;
  monitor    mon;
  scoreboard sb;

  // clock
  initial clk = 0;
  always #5 clk = ~clk;

  initial begin
    // create objects
    sb  = new();
    drv = new(intf);
    mon = new(intf, sb);

    // reset
    intf.rst = 1;
    repeat (2) @(posedge clk);
    intf.rst = 0;

    // run
    fork
      drv.run();
      mon.run();
    join_any

    #100 $finish;
  end

endmodule
