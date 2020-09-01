class random_test extends test;
  `uvm_component_utils(random_test)
  
  add_sequence add_seq;
  
  function new(string name = "random_test", uvm_component parent=null);
    super.new(name, parent);
  endfunction
  
  function void build_phase(uvm_phase phase);
    super.build_phase(phase);
    add_seq = add_sequence::type_id::create("add_seq", this);
  endfunction
  
  task run_phase(uvm_phase phase);
    
    phase.raise_objection(this);
    add_seq.start(env.active_ag.seq);
    phase.drop_objection(this);
    
    phase.phase_done.set_drain_time(this, 50);
  endtask
  
  
endclass