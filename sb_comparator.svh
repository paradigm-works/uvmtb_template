//----------------------------------------------------------------------
// This File: sb_comparator.sv
// Author:    cliff.cummings@paradigm-works.com
// SPDX-License-Identifier: MIT
//----------------------------------------------------------------------

class sb_comparator extends uvm_component; 
  `uvm_component_utils(sb_comparator) 
  
  trans1 exp_tr, out_tr;
  static int VECT_CNT, PASS_CNT, ERROR_CNT;

  uvm_analysis_export   #(trans1) exp_ap;
  uvm_analysis_export   #(trans1) out_ap;
  uvm_tlm_analysis_fifo #(trans1) expfifo;
  uvm_tlm_analysis_fifo #(trans1) outfifo;
  
  function new (string name, uvm_component parent);
    super.new(name, parent);
  endfunction

  function void build_phase(uvm_phase phase);
    super.build_phase(phase);
    exp_ap  = new("exp_ap", this);
    out_ap  = new("out_ap", this); 
    expfifo = new("expfifo", this);
    outfifo = new("outfifo", this);
  endfunction

  function void connect_phase(uvm_phase phase); 
    super.connect_phase(phase);
    exp_ap.connect(expfifo.analysis_export); 
    out_ap.connect(outfifo.analysis_export); 
  endfunction 
  
  task run_phase(uvm_phase phase);
    //---------------------------------------------------------------------------
    // Repeat loop used to throw aways one or more transactions if the design
    //   has synchronous reset or pipeline values that need to be flushed.
    //---------------------------------------------------------------------------
    // repeat (1) begin
    //   expfifo.get(exp_tr); // Throw away expected sample
    //   outfifo.get(out_tr); // Throw away output   sample
    // end
    forever begin 
      `uvm_info("SB_CMP", "WAITING for expected output", UVM_FULL)
      expfifo.get(exp_tr);
      `uvm_info("SB_CMP", "WAITING for actual output", UVM_FULL)
      outfifo.get(out_tr);
      if (out_tr.compare(exp_tr)) PASS();
      else                        ERROR();
    end
  endtask

  function void report_phase(uvm_phase phase);
    super.report_phase(phase); 
    if (VECT_CNT && !ERROR_CNT)
      `uvm_info("PASSED",
      $sformatf("\n\n\n*** TEST PASSED - Vectors: %0d Ran / %0d Passed ***\n",
                 VECT_CNT, PASS_CNT), UVM_LOW)
    else
      `uvm_error("FAILED",
      $sformatf("\n\n\n*** TEST FAILED - Vectors: %0d Ran / %0d Passed / %0d Failed ***\n",
                 VECT_CNT, PASS_CNT, ERROR_CNT))
  endfunction 

  function string get_vector_str();
    return($sformatf("Expected:%s  Actual:%s",
                exp_tr.convert2string(), out_tr.output2string()));
  endfunction

  function void PASS();
    `uvm_info ("PASS ", get_vector_str(), UVM_HIGH)
    VECT_CNT++;
    PASS_CNT++;
  endfunction

  function void ERROR();
    `uvm_error("ERROR", {get_vector_str(), "\n"})
    VECT_CNT++;
    ERROR_CNT++;
  endfunction
endclass 
