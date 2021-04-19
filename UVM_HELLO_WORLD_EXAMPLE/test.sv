
class test extends uvm_test;
    `uvm_component_utils(test)

    function new(string name="test",uvm_component parent);
        super.new(name,parent);
    endfunction
    
    env env_h;
    function void build_phase(uvm_phase phase);
        `uvm_info(get_type_name(), "Inside build phase", UVM_MEDIUM)
      env_h=env::type_id::create("env_h",this);
    endfunction: build_phase

    function void end_of_elaboration_phase(uvm_phase phase);
        `uvm_info(get_type_name(), "Inside end of eleboration phase", UVM_MEDIUM)
    endfunction: end_of_elaboration_phase

    function void start_of_simulation_phase(uvm_phase phase);
        `uvm_info(get_type_name(), "Inside start of simulation phase", UVM_MEDIUM)
    endfunction: start_of_simulation_phase

    task run_phase(uvm_phase phase);
        phase.raise_objection(this);
        `uvm_info(get_name(), "<run_phase> started, objection raised.", UVM_NONE)
         #10;
         `uvm_info(get_type_name(), "Inside RUN phase", UVM_MEDIUM)
        phase.drop_objection(this);
        `uvm_info(get_name(), "<run_phase> finished, objection dropped.", UVM_NONE)
    endtask: run_phase
    
    function void report_phase(uvm_phase phase);
        `uvm_info(get_type_name(), "Inside report phase", UVM_MEDIUM)
    endfunction: report_phase

endclass
