
class env extends uvm_env;
    `uvm_component_utils(env)

    function new(string name="env",uvm_component parent);
        super.new(name,parent);
    endfunction
    
    agent agent_h;


    function void build_phase(uvm_phase phase);
        `uvm_info(get_type_name(), "Inside build phase", UVM_MEDIUM)
      agent_h=agent::type_id::create("agent_h",this);
    endfunction: build_phase

    function void end_of_elaboration_phase(uvm_phase phase);
        `uvm_info(get_type_name(), "Inside end of eleboration phase", UVM_MEDIUM)
    endfunction: end_of_elaboration_phase

    function void start_of_simulation_phase(uvm_phase phase);
        `uvm_info(get_type_name(), "Inside start of simulation phase", UVM_MEDIUM)
        `uvm_info(get_type_name(), "----- calling : agent_h.hello_world();", UVM_MEDIUM)
        agent_h.hello_world();
    endfunction: start_of_simulation_phase

    function void report_phase(uvm_phase phase);
        `uvm_info(get_type_name(), "Inside report phase", UVM_MEDIUM)
    endfunction: report_phase

endclass
