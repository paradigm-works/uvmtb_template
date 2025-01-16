//----------------------------------------------------------------------
// This File: sb_predictor.sv
// Author:    cliff.cummings@paradigm-works.com
// SPDX-License-Identifier: MIT
//----------------------------------------------------------------------

//----------------------------------------------------------------------
// - the predictor only looks at the transaction inputs 
// - the predictor ignores any sampled outputs 
// - the predictor will predict and write the expected output
//----------------------------------------------------------------------

class sb_predictor extends uvm_subscriber #(trans1);
  `uvm_component_utils(sb_predictor) 
  
  uvm_analysis_port #(trans1) results_ap; 

  function new(string name, uvm_component parent);
    super.new(name, parent);
  endfunction 

  function void build_phase(uvm_phase phase);
    super.build_phase(phase);
    results_ap = new("results_ap", this);
  endfunction 

  function void write(trans1 t); 
    trans1 exp_tr;
    //---------------------------
    exp_tr = sb_calc_exp(t); 
    results_ap.write(exp_tr); 
  endfunction 

  extern function trans1 sb_calc_exp(trans1 t); 
endclass
