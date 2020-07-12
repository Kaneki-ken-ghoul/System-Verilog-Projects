`define MN vif.MONITOR.monitor_cb
class monitor;
  transaction trans;
  virtual intf vif;
  mailbox mon2scb;
  bit [8:0]mem;
  bit [3:0]c;
  
  function new(virtual intf vif, mailbox mon2scb);
  	this.vif = vif;
    this.mon2scb = mon2scb;
  endfunction
  
  task main;
    trans = new;
     trans.rd_wr = `MN.rd_wr;
    forever begin

      wait(`MN.rd_wr == 0);
      @(posedge vif.sclk);
      trans.miso = `MN.miso;
      mon2scb.put(trans);
    end
  endtask
  
endclass
