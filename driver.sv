class driver;

  virtual fifo_if vif;

  function new(virtual fifo_if vif);
    this.vif = vif;
  endfunction

  task run();

    vif.cb.wr_en <= 0;
    vif.cb.rd_en <= 0;
    vif.cb.wr_ip <= 0;

    repeat (4) @(vif.cb);

    // WRITE 4 VALUES
    @(vif.cb);
    vif.cb.wr_en <= 1;
    vif.cb.wr_ip <= 8'd10;

    @(vif.cb);
    vif.cb.wr_ip <= 8'd20;

    @(vif.cb);
    vif.cb.wr_ip <= 8'd30;
    
    @(vif.cb);
    vif.cb.wr_ip <= 8'd40;


    // STOP WRITING
    @(vif.cb);
    vif.cb.wr_en <= 0;

    // READ 4 VALUES
    repeat (4) begin
      @(vif.cb);
      vif.cb.rd_en <= 1;
    end

    // STOP READING
    @(vif.cb);
    vif.cb.rd_en <= 0;

  endtask

endclass
