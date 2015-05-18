# MIPS-Single-Cycle
Computer Assignment 2 of UT computer organization course.
<p>
This is a single cycle MIPS proccessor which supports the following <strong>instructions</strong>:
</br>R-Type(Both Reg-Reg, and Reg-immediate): ADD, ADDC (carry) , SUB, SUBC (carry), AND, OR, XOR, MASK
</br>Shift: SHL, SHR, ROL, ROR
</br>Mem: SW, LW
</br>Condition Branch:   BZ, BNZ, BC, BNC (based on carry and zero registers)
</br>Other controll instructions: JMP, JSB (implemented by a stack), RET (stack)
</p>
<p>
The proccessor has the following <strong>specifications</strong>:
</br>A register file: 8 registers, word size = 8bits
</br>Instruction length: 19 bits
</br>Instructon memory: 4096 registers (19 bits)
</br>Data memory: 256 registers (8 bits)
</br>ALU: 8 bits, carry, and Z (zero) support
</br>FlipFlops: C and Z
</p>
