class driver;

  virtual fifo_if vif;

localparam RUNCYCLES = 777;

  logic [7:0] rand_ip = 0;
  function new(virtual fifo_if vif);
    this.vif = vif;
  endfunction
  
  logic [2:0] expcount;
  
  typedef enum logic [1:0] {IDLE=2'b00, READ=2'b01, WRITE=2'b10, BOTH=2'b11} STATE_R;
  STATE_R STATE;


  task run();

    vif.cb.wr_en <= 0;
    vif.cb.rd_en <= 0;
    vif.cb.wr_ip <= 0;
    expcount <= 0;


//TODO: Random task selection + Condition Matching + Testing

repeat(RUNCYCLES) begin

@(vif.cb)
std::randomize(STATE);  //Randomise state

//Checking states 

if (expcount == 0 && expcount == 7) begin //Glitch case
STATE = IDLE; //Safe state
end
else if (STATE == READ && expcount == 0) begin
STATE = IDLE;
end
else if ( STATE == WRITE && expcount == 7) begin
STATE = IDLE;
end
else if (STATE == BOTH && expcount == 0) begin
STATE = WRITE;
end
else if (STATE == BOTH && expcount == 7) begin
STATE = READ;
end


rand_ip = $urandom_range(0, 255);

case (STATE)

IDLE : begin
vif.cb.rd_en <= 0;
vif.cb.wr_en <= 0;
end

READ: begin
vif.cb.rd_en <= 1;
vif.cb.wr_en <= 0; //Ensuring previous values dont leak.
expcount <= expcount - 1;
end

WRITE: begin
vif.cb.wr_en <= 1;
vif.cb.wr_ip <= rand_ip;
vif.cb.rd_en <= 0; //Ensuring previous values dont leak
expcount <= expcount + 1;
end

BOTH: begin
vif.cb.wr_en <= 1;
vif.cb.wr_ip <= rand_ip;
vif.cb.rd_en <= 1;
end

default: begin
vif.cb.rd_en <= 0;
vif.cb.wr_en <= 0;
end

endcase

end

  endtask

endclass
