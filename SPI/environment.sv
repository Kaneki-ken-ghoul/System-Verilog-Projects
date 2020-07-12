`include "transaction.sv"
`include "generator.sv"
`include "driver.sv"
`include "monitor.sv"
`include "scoreboard.sv"

class environment;
  
  generator gen;
  driver driv;
  scoreboard scb;
  mailbox gen2driv;
  mailbox gen2scb;
  mailbox mon2scb;
  monitor mon;
  virtual intf vif;
  
  function new(virtual intf vif);
    gen2driv = new();
    mon2scb = new();
    gen2scb = new();
    this.vif = vif;
    gen = new(gen2driv, gen2scb);
    driv = new(gen2driv, vif);
    mon = new(vif, mon2scb);
    scb = new(mon2scb, gen2scb);
  endfunction 
  
  task pre_test;
    driv.reset;
  endtask
  
  task test;
    fork
    	gen.main;
    	driv.main;
    	mon.main;
        scb.main;
    join_any
  endtask
  
  task post_test;
    wait(gen.ended.triggered);
    wait(gen.repeat_count == driv.d);
  endtask
  
  task run;
    pre_test;
    test;
    post_test;
    $finish;
  endtask
  
endclass
