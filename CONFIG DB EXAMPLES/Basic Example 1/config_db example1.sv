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


class env extends uvm_env;

    //---------------------------------------------------------------------------
    `uvm_component_utils(env)
    //---------------------------------------------------------------------------
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
       `uvm_info("ENV",$sformatf("loop_count is  %0d",loop_count),UVM_LOW)
   endfunction
   //----------------------------------------------------------------------------
 
endclass:env

`ifndef TB_PKG
`define TB_PKG
`include "uvm_macros.svh"
package tb_pkg;
 import uvm_pkg::*;
 `include "env.sv"                  // environment class

 `include "test.sv"                 // test1
endpackage
`endif 

/* OUTPUT

# KERNEL: UVM_INFO /home/runner/env.sv(17) @ 0: uvm_test_top.env_h [ENV] loop_count is  200
# KERNEL: UVM_INFO /home/runner/test.sv(34) @ 0: uvm_test_top [TEST] Running test

LINK : https://www.edaplayground.com/x/JSS_
*/