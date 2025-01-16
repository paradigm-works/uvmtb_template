//----------------------------------------------------------------------
// This File: transx.svh
// Author:    cliff.cummings@paradigm-works.com
// SPDX-License-Identifier: MIT
//
// Includes do_copy() / do_compare() templated version of transaction
//----------------------------------------------------------------------

class trans1 extends uvm_sequence_item; 
  `uvm_object_utils(trans1)
  
       logic [15:0] dout;    // outputs not randomized
  rand bit   [15:0] din;
  rand bit          rst_n;

  function new (string name="trans1");
    super.new(name);
  endfunction

  function void do_copy(uvm_object rhs);
    trans1 tr;
    if(!$cast(tr, rhs)) `uvm_fatal("trans1", "ILLEGAL do_copy() cast")
    super.do_copy(rhs);
    dout  = tr.dout;
    din   = tr.din;
    rst_n = tr.rst_n;
  endfunction

  function bit do_compare(uvm_object rhs, uvm_comparer comparer);
    trans1 tr;
    bit    eq;
    if(!$cast(tr, rhs)) `uvm_fatal("trans1", "ILLEGAL do_compare() cast")
    eq  = super.do_compare(rhs, comparer);
    eq &= (dout === tr.dout);
    return(eq);
  endfunction

  function void do_print(uvm_printer printer);
    $display("\n\n\t\t*** print() and sprint() are not implemented ",
             "for this transaction type ***\n\n");
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
