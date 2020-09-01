`define MN vif1.MONITOR.monitor_cb
class monitor extends uvm_monitor;
  
  `uvm_component_utils(monitor)
  
  uvm_analysis_port#(transaction) item_port;
  transaction itm_collected;
  
  virtual intf1 vif1;
  
  function new(string name, uvm_component parent);
    super.new(name, parent);
    itm_collected = new;
    item_port = new("item_port", this);
  endfunction
  
  function void build_phase(uvm_phase phase);
    super.build_phase(phase);
    if(!uvm_config_db#(virtual intf1)::get(this, "", "vif1", vif1))
      `uvm_fatal("NO VIF", {"vif should be :", get_full_name, ".vif1"})
  endfunction
      
     task run_phase(uvm_phase phase);
    	forever begin
          @(posedge vif1.MONITOR.sclk);
          itm_collected.mosi = `MN.mosi;
          itm_collected.miso = `MN.miso;
          item_port.write(itm_collected);
       end
    endtask
    
endclass