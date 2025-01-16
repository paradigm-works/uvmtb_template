//----------------------------------------------------------------------
// This File: env.sv
// Author:    cliff.cummings@paradigm-works.com
// SPDX-License-Identifier: MIT
//----------------------------------------------------------------------

class env extends uvm_env;
  `uvm_component_utils(env)

  tb_agent      agnt;
  tb_scoreboard sbd;
  // Functional coverage on the dut-output agent
  tb_cover      cov;

  function new (string name, uvm_component parent);
    super.new(name, parent);
  endfunction

  function void build_phase(uvm_phase phase);
    super.build_phase(phase);
    agnt =      tb_agent::type_id::create("agnt", this);
    sbd  = tb_scoreboard::type_id::create("sbd",  this);
    cov  =      tb_cover::type_id::create("cov",  this);
    // agnt_mon.is_active = UVM_PASSIVE;
  endfunction

  function void connect_phase(uvm_phase phase);
    super.connect_phase(phase);
    agnt.ap.connect(sbd.axp);
    agnt.ap.connect(cov.analysis_export);
  endfunction
endclass

