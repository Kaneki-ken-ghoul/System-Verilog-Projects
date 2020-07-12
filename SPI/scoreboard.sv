 class scoreboard;
  
  mailbox mon2scb;
  mailbox gen2scb;
  transaction trans, tr;
  int flag;

   bit [8:0]mem1, mem2, mem3;
   bit [3:0]c, d;
   int count = 1;
   bit [7:0]write_mem[$];
  
   function new(mailbox mon2scb, mailbox gen2scb);
    this.mon2scb = mon2scb;
    this.gen2scb = gen2scb;
  endfunction
  
  task main;
    fork
      forever begin
        mon2scb.get(trans);
        if(trans.rd_wr == 0) begin
          mem1[c] = trans.miso;
          c++;
          if(c == 9)begin            
            mem3 = write_mem.pop_front();
            if(mem1[8:1] == mem3)
              $display("Data read = %0h", mem3);
             else
              $error("Actual data = %0h Data got = %0h", mem3, mem1[8:1]);
            c = 0;
          end
        end
      end
      
      forever begin
        gen2scb.get(tr);
        if(tr.rd_wr) begin
          mem2 = tr.data;
          count = 1;
        end
        else begin
          if(count == 1)begin
            write_mem.push_back(mem2);
          end
          else begin
            write_mem.push_back(0);
          end
          count++;
        end
      end
     join_any
  endtask
  
endclass

