`include "transaction.sv"
`include "sequence.sv"
`include "sequencer.sv"
`include "driver.sv"
`include "monitor.sv"

class agent1 extends uvm_agent;
  
  `uvm_component_utils(agent1)
  
  sequencer seq;
  driver dr;
  monitor mon1;
  
  function new(string name, uvm_component parent);
    super.new(name, parent);
  endfunction
  
  function void build_phase(uvm_phase phase);
    super.build_phase(phase);
    seq = sequencer::type_id::create("seq", this);
    dr = driver::type_id::create("dr", this);
    mon1 = monitor::type_id::create("mon1", this);
  endfunction	
  
  function void connect_phase(uvm_phase phase);
    dr.seq_item_port.connect(seq.seq_item_export);
  endfunction
  
endclass