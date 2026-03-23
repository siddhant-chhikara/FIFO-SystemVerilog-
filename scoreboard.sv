class scoreboard;

  int q[$];

  // WRITE
  function void write(input int data);
    q.push_back(data);
  endfunction

  // READ
  function void read(input int data);

    if (q.size() == 0) begin
      $display("ERROR: Underflow");
    end
    else begin
      int exp;
      exp = q.pop_front();

      if (exp == data)
        $display("PASS: %0d", data);
      else
        $display("ERROR: Expected=%0d Got=%0d", exp, data);

    end

  endfunction

endclass
