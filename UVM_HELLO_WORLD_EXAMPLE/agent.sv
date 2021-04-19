
class agent extends uvm_agent;
    `uvm_component_utils(agent)

    function new(string name="agent",uvm_component parent);
        super.new(name,parent);
    endfunction
    
    function void build_phase(uvm_phase phase);
        `uvm_info(get_type_name(), "Inside build phase", UVM_MEDIUM)
    endfunction: build_phase

    function void end_of_elaboration_phase(uvm_phase phase);
        `uvm_info(get_type_name(), "Inside end of eleboration phase", UVM_MEDIUM)
    endfunction: end_of_elaboration_phase

    function void start_of_simulation_phase(uvm_phase phase);
        `uvm_info(get_type_name(), "Inside start of simulation phase", UVM_MEDIUM)
    endfunction: start_of_simulation_phase

    function void report_phase(uvm_phase phase);
        `uvm_info(get_type_name(), "Inside report phase", UVM_MEDIUM)
    endfunction: report_phase

    function void hello_world();
        `uvm_info(get_type_name(), "----- HELLO WORLD -----", UVM_MEDIUM)
    endfunction

endclass
