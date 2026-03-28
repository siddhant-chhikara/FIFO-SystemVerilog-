class monitor;

  virtual fifo_if vif;
  scoreboard sb;
  
  bit rd_en_d1 = 0;
  
  covergroup cg;
      coverpoint vif.wr_en;
      coverpoint vif.rd_en;
      coverpoint vif.empty;
      coverpoint vif.full;
      cross vif.rd_en, vif.wr_en;
   endgroup

  function new(virtual fifo_if vif, scoreboard sb);
    this.vif = vif;
    this.sb  = sb;
    cg = new();
  endfunction
  

  task run();

    forever begin
      @(vif.cb);


      // WRITE
      if (vif.wr_en && !vif.full) begin
        sb.write(vif.wr_ip);
      end
      
      //READ DELAY OF 1 CYCLE
      rd_en_d1 <= vif.rd_en;

      // READ
      if (rd_en_d1) begin  //No empty check because driver ensures it and this was using two signals from different clocking times.
        sb.read(vif.rd_op);
      end

    end

  endtask

endclass
