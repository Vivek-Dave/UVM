
class adder_env extends uvm_env;

   //---------------------------------------------------------------------------
   `uvm_component_utils(adder_env)
   //---------------------------------------------------------------------------

  //----------------------------------------------------------------------------
  function new(string name="",uvm_component parent);
    super.new(name,parent);
  endfunction
  //----------------------------------------------------------------------------

  //-------------------- class handles -----------------------------------------
  adder_agent      agent_h;
  adder_coverage   coverage_h;
  adder_scoreboard scoreboard_h;
  //----------------------------------------------------------------------------

  bit has_scoreboard;
  bit has_coverage;

  //---------------------- build phase -----------------------------------------
  function void build_phase(uvm_phase phase);
    super.build_phase(phase);
      agent_h      = adder_agent::type_id::create("agent_h",this);
      if(uvm_config_db#(bit)::get(null,"uvm_test_top","has_scoreboard",has_scoreboard))
        `uvm_info(get_type_name(),"HAS SCOREBOARD value get",UVM_LOW)
      else begin
        `uvm_error(get_type_name(),"Not getting has scoreboard")
      end
      if(uvm_config_db#(bit)::get(null,"uvm_test_top","has_coverage",has_coverage))
        `uvm_info(get_type_name(),"HAS COVERAGE value get",UVM_LOW)
      else begin
        `uvm_error(get_type_name(),"Not getting has coverage")
      end

      if(has_coverage==1) begin
        coverage_h   = adder_coverage::type_id::create("coverage_h",this);
      end
      if(has_scoreboard==1) begin
        scoreboard_h = adder_scoreboard::type_id::create("scoreboard_h",this);
      end
   endfunction
  //----------------------------------------------------------------------------

  //-------------------------- connect phase -----------------------------------
  function void connect_phase(uvm_phase phase);
    super.connect_phase(phase);
      if(has_coverage==1) begin
        agent_h.monitor_h.ap_mon.connect(coverage_h.analysis_export);
      end
      
      if(has_scoreboard==1) begin
        agent_h.monitor_h.ap_mon.connect(scoreboard_h.aport_mon);
        agent_h.driver_h.drv2sb.connect(scoreboard_h.aport_drv);
      end
  endfunction
  //----------------------------------------------------------------------------
endclass:adder_env

