# The Echo Utility

## Assignment:
   1. Write a Java program equivalent to the echo utility
   1. Write a MIPS program equivalent to the echo utility

## Echo Overview
  - From: ``$ man echo``
  - Name:
    * echo - write arguments to the standard output

  - Description:
    - The echo utility writes any specified operands, separated by single blank (' ') characters and followed by a newline (‘\n’) character, to the standard output.<br>
    (You do not have to implement the '-n' option.)

  - Example:
    ```
    $ echo one two three
    one two three
    $
    ```

## Assignment Objectives:
   1. To introduce command-line processing, which is defined across all programming languages
   1. To exercise the student's Java knowledge to create the 'echo' command
   1. To introduce the student to MIPS programming:
      1. the structure of the main subroutine
      1. the command-line argument passing convention
      1. the use of syscall to perform I/O operations
      1. the use of a loop to iterate over an array
   1. To further exercise the use of "git"


## Project Description
To complete this program, you will be guided through a prescribed development process, via a set of stages. Each stage is designed to help you to better understand the problem at hand or to complete the final MIPS program.  Moreover, each stage produces a working program, which is a deliverable associated with this project.  

To complete this project successfully, each of your individual deliverables must compile/assemble and pass the Professor's test cases. 


### Command Line Processing and the argv Data Structure

Consider the following prototypes for the main method/function in Java and C, which are practically equivalent.[^1]

  - Java
    * Example usage: ``$ java echo one two three four``
      ```java
         public static void main(String args[]);
      ```
  - C
    * Example usage: ``$ echo one two three four``
      ```C
        int main(int argc, char * argv[]);
      ```

    * argc is an integer representing the <u>arg</u>ument <u>c</u>ount
      - In Java parlance, argc is equivalent to args.length

    * argv is an array, where each element is a string
      - In C, a string is implemented as a pointer to a char, e.g., (char \*)
      - In Java, the <u>underlying</u> implementation of a String is also a pointer to a char

A MIPS program can also have command-line arguments. These are not provided via formal arguments as in Java and C, but are provided to the main subroutine via registers.

  - argc is placed into $a0, and the value represents an integer
  - argv is placed into $a1, and the value represents the address

The MARS application requires additional syntax to call a MIPS program with arguments from the command line. The 'pa' (program arguments) option is used to introduce the command-line arguments.

This syntax is as follows:

  ```
  $ mars echo.s pa one two three four
  MARS 4.5  Copyright 2003-2014 Pete Sanderson and Kenneth Vollmar
   
  one two three four
   
  ```

Given the CLI command ``$ echo one two three four``, we can depict the values of argc and argv as follows:

![The data structure for the argv](/argv.png)

[^1]: In C, the program name is stored in argv[0].  Consequently, the command-line arguments are then stored in argv[1]..argv[argc].  Java and MARS, use the structure as depicted above.

Note the following within the diagram:
   1. The rval of argc is 4, which corresponds to the number of command-line arguments.
   1. The rval of argv is an address in memory, 0x7fffefec, where the array is stored.
   1. The depicted memory addresses are in increments of 4.
      - Recall, an address is a 32-bit quantity on the MIPS architecture.
      - Hence, 4 bytes are required to store each 32-bit quantity.
   1. The rval of each array element is an address.
      - This address is the starting location of each string: "one", "two", "three", and "four". This address is not provided in the diagram, but is depicted by a pointer.
   1. The variable p_arg has been introduced into the diagram.
      - Via a loop, we can examine each element of the argv array: argv[0] ... argv[3].
      - The p_arg variable is used to <u>p</u>oint to the current <u>arg</u>ument being examined.



### Project Deliverables

The deliverables for this projects are:
  1. echo.java: which prints out the number of command-line arguments
     - Task: ensure provided starter code works
     - Tag: java-echo-start

  1. echo.java: which prints out each of the the command-line arguments 
     - Task: insert a for-loop to print each argument separated by a space (' ')
     - Tag: java-echo-done

  1. echo.s: which prints out the number of command-line arguments
     - Task: ensure provided starter code works
     - Tag: mips-echo-start

  1. echo.s: which prints out the series 1..argc 
     - Task: insert a loop to print each value in the series on individual lines
     - Tag: mips-echo-loop

  1. echo.s: prints out the command-line arguments
     - Task: augment the loop to walk the argv structure and print the corresponding command-line argument
     - Tag: mips-echo-done


### Development Steps:
  1. Accept and clone the assignment.
  1. Work on the Java version of the project.
     * Stage 1:
       1. Create a file called "echo.java" that includes the starter code.
       1. Test this program to ensure it works correctly
          ```
          $ javac echo.java
          $ java echo one two three four
          4
          $
          ```
       1. Commit this working version to your repository
          - ``git add echo.java``
          - ``git commit -m 'some informative message'`` 
          - ``git tag java-echo-start``

     * Stage 2:
       1. Insert a for-loop to, in-turn, print out each command-line argument
          - You may use the following web site (or other) to help you write your code
          - https://www.javatpoint.com/command-line-argument

       1. Test this program to ensure it works correctly
          ```
          $ javac echo.java
          $ java echo one two three four
          one two three four
          $
          ```

       1. Commit this working version to your repository
          - ``git add echo.java``
          - ``git commit -m 'some informative message'`` 
          - ``git tag java-echo-done``
     ---
  1. Work on the Java version of the project.
     * Stage 3: 
       1. Create an file called echo.s that includes the starter code
       1. Note the following within the echo.s file
          1. Bookkeeping comments have been added to identify register allocation
          1. Code has been added to de-marshal the formal arguments
          1. A syscall, via the print_d macro, is used to print a decimal number
          1. A syscall, via the exiti macro, is used to exit the program with an <u>i</u>mmediate value
       1. Use the booking comments to guide your develop.
       1. Test this program to ensure it works correctly.
          ```
          $ mars me echo.s pa one two three four 2> /dev/null
          4
          $
          ```
       1. Commit this working version to your repository
          - ``git add echo.s``
          - ``git commit -m 'some informative message'`` 
          - ``git tag mips-echo-start``

     * Stage 4: 
       1. Consider the following Java loop
          ```
          i=0;
          for( ; i < argc; ) {
            System.out.printf("%d\n", i);
            i++;
          }
          ```
       1. Incorporate the following MIPS loop into your program
          -  this loop is equivalent to the above Java loop
          ``` 
                 li $t1,               #        i=0
          loop:  bge $t1, $t0, done     # loop:  for (; i < argc ;) {
                   print_d $t1          #          System.out.printf("%d\n", i);
                   print_ci '\n'        #    
                   addi $t1, $t1, 1     #          i++;
                 b loop                 #          continue loop;
                                        #        }
          done:  nop                    # done:  ;
          ```
       1. Remove the code that prints out the number of arguments.
       1. Test your code to ensure you have the following output
          ```
          $ mars me echo.s pa apple peach grape 2>/dev/null
          0
          1
          2
          $
          ```

     * Stage 5: 
       1. Modify your loop to
          - walk the argv array
            - initialize p_arg to be the value of argv before the start of the loop
            - increment the value p_arg by 4 at the end of each loop iteration
          - print each string, in turn, within the body of the loop
            - set the value of str to be equal that address stored at p_args <br>
              ``lw $t4, 0($t3)          #   str = (* p_args)``
            - call the ``print_s`` syscall to print the string

       1. Test your code to ensure you have the following output
          ```
          $ mars me echo.s pa apple peach grape 2>/dev/null
          apple peach grape
          $
          ```
     ---
  1. Perform final testing and submitting your project
     1. Run each of the test cases in the "Validation Testing" Section
     1. Ensure you push both your code and your tags to your repository 
        ```
        $ git push           # push all of your code
        $ git push --tags    # push all of your tags
        ```
        - Note that the command ``git push --mirror`` will push your code and tags in one  step. 
 
    
### Validation Testing:
Via the command line, test your program with at least the following test cases.

1. echo.java that prints out the number of command-line arguments:
   ```
   $ git checkout java-echo-start
   $ javac echo.java
   $ java echo apple peach grape
   3
   $ git checkout main
   ```

1. echo.java that echos out the command-line arguements:
   ```
   $ git checkout java-echo-done
   $ javac echo.java
   $ java echo apple peach grape
   apple peach grape
   $ git checkout main
   ```

1. echo.s that prints out the number of command-line arguments:
   ```
   $ git checkout mips-echo-start
   $ mars me echo.s pa apple peach grape 2>/dev/null
   3
   $ git checkout main
   ```

1. echo.s that counts and prints the number of command-line arguments:
   ```
   $ git checkout mips-echo-loop
   $ mars me echo.s pa apple peach grape 2>/dev/null
   0
   1
   2
   $ git checkout main
   ```

1. echo.s that echos out the command-line arguments:
   ```
   $ git checkout mips-echo-done
   $ mars me echo.s pa apple peach grape 2>/dev/null
   apple peach grape
   $ git checkout main
   ```

### Starter Code:

#### Java
   ```java
   class echo  
   {  
   
     public static void main(String args[]) {
   
       final int argc = args.length; 
       System.out.printf("%d\n",argc);
   
       System.exit(0); 
     }
   }  
   ```

#### MIPS
   ```mips
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
   ```            


