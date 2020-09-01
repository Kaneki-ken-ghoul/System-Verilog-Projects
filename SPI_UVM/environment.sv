`include "agent_1.sv"
`include "agent_2.sv"
`include "scoreboard.sv"
class environment extends uvm_env;
  
  `uvm_component_utils(environment)
  
  agent1 active_ag;
  agent2 passive_ag;
  scoreboard scb;
  
  function new(string name, uvm_component parent);
    super.new(name, parent);
  endfunction
  
  function void build_phase(uvm_phase phase);
    super.build_phase(phase);
    active_ag = agent1::type_id::create("active_ag", this);
    passive_ag = agent2::type_id::create("passive_ag", this);
    scb = scoreboard::type_id::create("scb", this);
  endfunction 
  
  function void connect_phase(uvm_phase phase);
    active_ag.mon1.item_port.connect(scb.item_export_ag1);
    passive_ag.mon2.item_port.connect(scb.item_export_ag2);
  endfunction
  
endclass
  