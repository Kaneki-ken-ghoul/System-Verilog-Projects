`include "environment.sv"

program test(intf in);
  environment env;
  
  initial begin
    env = new(in);
    env.gen.repeat_count = 100;
    env.run;
  end
endprogram

