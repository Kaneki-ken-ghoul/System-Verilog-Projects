`define M vif2.MONITOR.monitor_cb
class monitor2 extends uvm_monitor;
  
  `uvm_component_utils(monitor2)
  
  uvm_analysis_port#(transaction) item_port;
  transaction itm_collected;
  
  virtual intf2 vif2;
  
  function new(string name, uvm_component parent);
    super.new(name, parent);
    itm_collected = new;
    item_port = new("item_port", this);
  endfunction
  
  function void build_phase(uvm_phase phase);
    super.build_phase(phase);
    if(!uvm_config_db#(virtual intf2)::get(this, "", "vif2", vif2))
      `uvm_fatal("NO VIF", {"vif should be :", get_full_name, ".vif2"})
  endfunction
      
     task run_phase(uvm_phase phase);
    	forever begin
          @(posedge vif2.MONITOR.sclk);
          itm_collected.mosi = `M.mosi;
          itm_collected.miso = `M.miso;
          item_port.write(itm_collected);
       end
    endtask
    
endclass