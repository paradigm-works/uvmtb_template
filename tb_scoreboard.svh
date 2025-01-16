//----------------------------------------------------------------------
// This File: tb_scoreboard.sv
// Author:    cliff.cummings@paradigm-works.com
// SPDX-License-Identifier: MIT
//----------------------------------------------------------------------

//----------------------------------------------------------------------
// This scoreboard architecture just connects sub-components. 
// Since the scoreboard only declares analysis_exports and not 
//   analysis_imp ports, no write methods are required, just 
//   connections.
//----------------------------------------------------------------------

class tb_scoreboard extends uvm_scoreboard;
  `uvm_component_utils(tb_scoreboard)

  uvm_analysis_export #(trans1) axp;
  sb_predictor                  prd;
  sb_comparator                 cmp;

  function new(string name, uvm_component parent);
    super.new(name, parent);
  endfunction 

  function void build_phase(uvm_phase phase);
    super.build_phase(phase);
    axp = new("axp", this); 
    prd =  sb_predictor::type_id::create("prd", this);
    cmp = sb_comparator::type_id::create("cmp", this);
  endfunction

  function void connect_phase( uvm_phase phase ); 
    // Connect predictor & comparator to respective analysis exports
    axp.connect           (prd.analysis_export); 
    axp.connect           (cmp.out_ap); 
    // Connect predictor to comparator
    prd.results_ap.connect(cmp.exp_ap); 
  endfunction 
endclass
