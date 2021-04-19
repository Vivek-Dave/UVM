
`include "uvm_macros.svh"
`include "tb_pkg.sv"
module top;
    import uvm_pkg::*;
    import tb_pkg::*;
    
    initial begin
        run_test("test");
    end

endmodule