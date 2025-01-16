//----------------------------------------------------------------------
// This File: transy.svh
// Author:    cliff.cummings@paradigm-works.com
// SPDX-License-Identifier: MIT
//
// Field Macro version of transaction
//----------------------------------------------------------------------

class trans1 extends uvm_sequence_item; 
  // (0)  Declare transaction variables
       logic [15:0] dout;    // outputs are not randomized
  rand bit   [15:0] din;
  rand bit          rst_n;

  //      Optional: declare field macros  | (mostly in transactions)
  `uvm_object_utils_begin(trans1)
    `uvm_field_int(dout,  UVM_ALL_ON)
    `uvm_field_int(din,   UVM_ALL_ON | UVM_NOCOMPARE)
    `uvm_field_int(rst_n, UVM_ALL_ON | UVM_NOCOMPARE)
  `uvm_object_utils_end

  function new (string name="trans1");
    super.new(name);
  endfunction

  virtual function string input2string();
    return($sformatf("din=%4h  rst_n=%b", 
                      din,     rst_n));

  virtual function string output2string();
    return($sformatf("dout=%4h", dout));
  endfunction

  virtual function string convert2string();
    return({input2string(), "  ", output2string()});
  endfunction
endclass
