class agent1 extends uvm_agent;

    //----------------------------------------------------------------------------
    `uvm_component_utils(agent1)
    //----------------------------------------------------------------------------
      int loop_count;
    //----------------------------------------------------------------------------
    function new(string name="",uvm_component parent);
      super.new(name,parent);
    endfunction
    //----------------------------------------------------------------------------
  
    //---------------------- build phase -----------------------------------------
    function void build_phase(uvm_phase phase);
      super.build_phase(phase);
       if(uvm_config_db#(int)::get(null,"uvm_test_top","loop_count",loop_count))
         `uvm_info("AGENT1",$sformatf("loop_count is  %0d",loop_count),UVM_LOW)
    endfunction
    //----------------------------------------------------------------------------
  
endclass:agent1

class agent2 extends uvm_agent;

    //----------------------------------------------------------------------------
    `uvm_component_utils(agent2)
    //----------------------------------------------------------------------------
    int loop_count;
    //----------------------------------------------------------------------------
    function new(string name="",uvm_component parent);
      super.new(name,parent);
    endfunction
    //----------------------------------------------------------------------------
  
    //---------------------- build phase -----------------------------------------
    function void build_phase(uvm_phase phase);
      super.build_phase(phase);
       if(uvm_config_db#(int)::get(null,"uvm_test_top","loop_count",loop_count))
         `uvm_info("AGENT2",$sformatf("loop_count is  %0d",loop_count),UVM_LOW)
    endfunction
    //----------------------------------------------------------------------------
  
endclass:agent2

  class env extends uvm_env;

    //---------------------------------------------------------------------------
    `uvm_component_utils(env)
    //---------------------------------------------------------------------------
    int loop_count;
    agent1 ag1;
    agent2 ag2;
   //----------------------------------------------------------------------------
   function new(string name="",uvm_component parent);
     super.new(name,parent);
   endfunction
   //----------------------------------------------------------------------------
 
   //---------------------- build phase -----------------------------------------
   function void build_phase(uvm_phase phase);
     super.build_phase(phase);
     ag1=agent1::type_id::create("ag1",this);
     ag2=agent2::type_id::create("ag2",this);
     
     if(uvm_config_db#(int)::get(null,"uvm_test_top","loop_count",loop_count))
       `uvm_info("ENV",$sformatf("loop_count is  %0d",loop_count),UVM_LOW)
   endfunction
   //----------------------------------------------------------------------------
 
  endclass:env

  
class test extends uvm_test;

    //--------------------------------------------------------------------------
    `uvm_component_utils(test)
    //--------------------------------------------------------------------------

    //--------------------------------------------------------------------------
    function new(string name="",uvm_component parent);
	super.new(name,parent);
    endfunction
    //--------------------------------------------------------------------------

    env env_h;
    

    //--------------------------------------------------------------------------
    function void build_phase(uvm_phase phase);
      super.build_phase(phase);
      env_h = env::type_id::create("env_h",this);
      
      uvm_config_db#(int)::set(null,"uvm_test_top","loop_count",200);
      
    endfunction
    //--------------------------------------------------------------------------

    //--------------------------------------------------------------------------
    task run_phase(uvm_phase phase);
        
		phase.raise_objection(this);
        
        `uvm_info("TEST","Running test",UVM_LOW)
        #10;
		phase.drop_objection(this);
    endtask
    //--------------------------------------------------------------------------

endclass:test

`ifndef TB_PKG
`define TB_PKG
`include "uvm_macros.svh"
package tb_pkg;
 import uvm_pkg::*;
 `include "agent1.sv"
 `include "agent2.sv"
 `include "env.sv"                  

 `include "test.sv"        
endpackage
`endif 

`include "tb_pkg.sv"
module top;
  import uvm_pkg::*;
  import tb_pkg::*;
  
  //----------------------------------------------------------------------------
  initial begin
    run_test("test");
  end
  //----------------------------------------------------------------------------
endmodule
  


/* OUTPUT
# KERNEL: UVM_INFO /home/runner/env.sv(22) @ 0: uvm_test_top.env_h [ENV] loop_count is  200
# KERNEL: UVM_INFO /home/build/vlib1/vlib/uvm-1.2/src/base/uvm_resource_db.svh(121) @ 0: reporter [CFGDB/GET] Configuration 'uvm_test_top.loop_count' (type bit signed[31:0]) read by  = (bit signed[31:0]) 200
# KERNEL: UVM_INFO /home/runner/agent1.sv(17) @ 0: uvm_test_top.env_h.ag1 [AGENT1] loop_count is  200
# KERNEL: UVM_INFO /home/build/vlib1/vlib/uvm-1.2/src/base/uvm_resource_db.svh(121) @ 0: reporter [CFGDB/GET] Configuration 'uvm_test_top.loop_count' (type bit signed[31:0]) read by  = (bit signed[31:0]) 200
# KERNEL: UVM_INFO /home/runner/agent2.sv(17) @ 0: uvm_test_top.env_h.ag2 [AGENT2] loop_count is  200
# KERNEL: UVM_INFO /home/runner/test.sv(34) @ 0: uvm_test_top [TEST] Running test
*/

Link : https://www.edaplayground.com/x/NGy9