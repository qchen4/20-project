# ADR-004: Prototype continues computing with a pending result

Status: owner-confirmed for the FPGA engineering prototype, 2026-11-06.

The owner chose to preserve existing MATLAB behavior: computation continues
while a result awaits acknowledgement. The first published snapshot remains
unchanged; subsequent completed candidates record RESULT_OVERFLOW rather than
replace it. This decision applies only to the engineering prototype.

This does not freeze AHB accesses, IRQ source/clearing, W1C, result register
fields, or same-cycle priorities. O-09/O-11 remain open for those details,
including ACK coinciding with publication, reset/abort coinciding with completion,
and how live overflow is presented separately from the immutable snapshot.
Implementations must not infer those priorities from this decision.

EXP-011 implements numerical window evaluation/storage, not the result mailbox
or bus/controller. Its response ready/valid transfer is an internal numerical
handshake and does not implement product ACK or IRQ semantics.


2026-11-06 follow-up: the owner explicitly chose to serialize ACK and publication in the prototype, with a simulation error for a collision, leaving priority for later freezing. EXP-012 implements the first-pending snapshot behavior with that precondition. No bus/IRQ/W1C or collision priority is inferred.
