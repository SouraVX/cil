; NOTE: Assertions have been autogenerated by utils/update_llc_test_checks.py
; RUN: llc -mtriple=riscv32 -verify-machineinstrs < %s \
; RUN:   | FileCheck %s -check-prefix=RV32I

; This test checks that unnecessary masking of shift amount operands is
; eliminated during instruction selection. The test needs to ensure that the
; masking is not removed if it may affect the shift amount.

define i32 @sll_redundant_mask(i32 %a, i32 %b) nounwind {
; RV32I-LABEL: sll_redundant_mask:
; RV32I:       # %bb.0:
; RV32I-NEXT:    sll a0, a0, a1
; RV32I-NEXT:    ret
  %1 = and i32 %b, 31
  %2 = shl i32 %a, %1
  ret i32 %2
}

define i32 @sll_non_redundant_mask(i32 %a, i32 %b) nounwind {
; RV32I-LABEL: sll_non_redundant_mask:
; RV32I:       # %bb.0:
; RV32I-NEXT:    andi a1, a1, 15
; RV32I-NEXT:    sll a0, a0, a1
; RV32I-NEXT:    ret
  %1 = and i32 %b, 15
  %2 = shl i32 %a, %1
  ret i32 %2
}

define i32 @srl_redundant_mask(i32 %a, i32 %b) nounwind {
; RV32I-LABEL: srl_redundant_mask:
; RV32I:       # %bb.0:
; RV32I-NEXT:    srl a0, a0, a1
; RV32I-NEXT:    ret
  %1 = and i32 %b, 4095
  %2 = lshr i32 %a, %1
  ret i32 %2
}

define i32 @srl_non_redundant_mask(i32 %a, i32 %b) nounwind {
; RV32I-LABEL: srl_non_redundant_mask:
; RV32I:       # %bb.0:
; RV32I-NEXT:    andi a1, a1, 7
; RV32I-NEXT:    srl a0, a0, a1
; RV32I-NEXT:    ret
  %1 = and i32 %b, 7
  %2 = lshr i32 %a, %1
  ret i32 %2
}

define i32 @sra_redundant_mask(i32 %a, i32 %b) nounwind {
; RV32I-LABEL: sra_redundant_mask:
; RV32I:       # %bb.0:
; RV32I-NEXT:    sra a0, a0, a1
; RV32I-NEXT:    ret
  %1 = and i32 %b, 65535
  %2 = ashr i32 %a, %1
  ret i32 %2
}

define i32 @sra_non_redundant_mask(i32 %a, i32 %b) nounwind {
; RV32I-LABEL: sra_non_redundant_mask:
; RV32I:       # %bb.0:
; RV32I-NEXT:    andi a1, a1, 32
; RV32I-NEXT:    sra a0, a0, a1
; RV32I-NEXT:    ret
  %1 = and i32 %b, 32
  %2 = ashr i32 %a, %1
  ret i32 %2
}
