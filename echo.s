 .text
         .globl main
         .include "syscalls.s"
 
 main:   nop
         ## Formal Arguments
         # a0: argc
         # a1: argv
         # v0: 0

         ## Register Allocation
         # t0: argc
         # t1: argv
         # t2: i 
         # t3: p_args
         # t4: str
 
         # De-marshal input args
         move $t0, $a0
         move $t1, $a1
  
         # Print number of arguments
         print_d $t0
         print_ci '\n'
     
         # Return from main with the value of zero
         exiti 0
