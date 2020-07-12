class generator;
  
  mailbox gen2driv;
  mailbox gen2scb;
  int repeat_count;
  transaction trans;
  event ended;
  bit d=1;
  
  function new(mailbox gen2driv, mailbox gen2scb);
    this.gen2driv = gen2driv;
    this.gen2scb = gen2scb;
  endfunction
  
  task main;
    repeat(repeat_count) begin
      trans = new();
      assert(trans.randomize());
      $display("rd_wr = %0b Data = %0h", trans.rd_wr, trans.data);
      gen2driv.put(trans);
      gen2scb.put(trans);
    end
    ->ended;
  endtask
  
endclass
