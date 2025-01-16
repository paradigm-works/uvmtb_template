//----------------------------------------------------------------------
// This File: sb_calc_exp.svh
// Author:    cliff.cummings@paradigm-works.com
// SPDX-License-Identifier: MIT
//----------------------------------------------------------------------

function trans1 sb_predictor::sb_calc_exp(trans1 t); 
  // declare static state variables that need 
  // to be saved between function calls
  static logic [15:0] ex_dout;
   
  trans1 extr = trans1::type_id::create("extr");
  //---------------------------
  `uvm_info("CALC #1", t.convert2string(), UVM_FULL)

  // copy all sampled inputs & outputs
  extr.copy(t);

  // calculate the expected output values
  if      (!extr.rst_n) ex_dout = '0;
  else                  ex_dout = extr.din;

  // overwrite the extr outputs with the calculated 
  //           expected output values
  extr.dout = ex_dout;
  `uvm_info("CALC #2", extr.convert2string(), UVM_FULL)
  return(extr);
endfunction
