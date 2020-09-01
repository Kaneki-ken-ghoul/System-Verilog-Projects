class scoreboard extends uvm_scoreboard;
  
  `uvm_component_utils(scoreboard)
  
  `uvm_analysis_imp_decl(_port_a)
  `uvm_analysis_imp_decl(_port_b)
  
  uvm_analysis_imp_port_a#(transaction, scoreboard) item_export_ag1;
  uvm_analysis_imp_port_b#(transaction, scoreboard) item_export_ag2;
  
  transaction tr_qu1[$], tr_qu2[$];
  bit [8:0]mem_wr, mem_rd;
  int wr_count, rd_count = 8;
  function new(string name, uvm_component parent);
    super.new(name, parent);
  endfunction 
  
  function void build_phase(uvm_phase phase);
    super.build_phase(phase);
    item_export_ag1 = new("item_export_ag1", this);
    item_export_ag2 = new("item_export_ag2", this);
  endfunction
  
  function void write_port_a(transaction trans);
    tr_qu1.pushback(trans);
  endfunction
  
  function void write_port_b(transaction trans);
    tr_qu2.pushback(trans);
  endfunction
  
  virtual task run_phase(uvm_phase phase);
    transaction tr1;
    transaction tr2;
    
    forever begin
      wait(tr_qu1.size() > 1 && tr_au2.size() > 1);
      tr = tr_qu.pop_front();
      if(tr.rd_wr)begin
        mem_wr[wr_count] = tr.mosi;
        wr_count++;
      end
      else begin
        mem_rd[rd_count] = tr.miso;
        rd_count--;
      end
      if(wr_count == 9) begin
        `uvm_info(get_type_name(), $sformatf("Written data = %0h", mem_wr), UVM_LOW)
        wr_count = 0;
      end
      
      if(rd_count == -1)begin
        `uvm_info(get_type_name(), $sformatf("Read data = %0h",mem_rd), UVM_LOW)
        rd_count = 8;
      end
    end
  endtask*/
      
endclass