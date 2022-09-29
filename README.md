# The Echo Utility

## Assignment:
   1. Write a Java program equivalent to the echo utility
   1. Write a MIPS program equivalent to the echo utility

## Echo Overview (from ``man echo``)
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
   1. Introduce command-line processing
   1. To exercise the student Java knowledge to create the 'echo' command
   1. To introduce the student to MIPS programming:
      1. the structure of the main subroutine
      1. the command-line argument passing convention
      1. the use of syscall to perform I/O operations
      1. the use of a loop to iterate over an array
   1. To further exercise the use of "git"


## Project Description
This is your first MIPS program. To complete this program, you will be guided through a prescribed development process, via a set of stages. Each stage is designed to help you to better understand the problem at hand or to complete the final MIPS program.  Moreover, each stage produces a working program, which is a deliverable associated with this project.  
To complete this project successfully, each of your individual deliverables must compile/assemble and pass the Professor's test cases. 

### Command Line Processing and the argv data structure

Consider the following prototypes for the main method/function in Java and C, which are practically equivalent.

   - Java
     ```java
        public static int main(String args[]);
     ```
   - C
     ```C
       int main(int argc, char * argv[]);
     ```

     * argc is an integer representing the **arg**ument **c**ount
       - in Java parlance, argc is equivalent to args.length;

     * argv is an array, where each element is a string.
       - In C, a string is implemented as a pointer to a char, e.g., (char \*).
       - In Java, the underlying implementation of a String is also a pointer to a char.

A MIPS program can also have command-line arguments. These are, however, proved to the main subroutine via the registers.

   - argc is placed into $a0, and the value represents an integer
   - argv is placed into $a1, and the value represents the address of argv

Given the command ``echo one two three four``, we can depict the values of argc and argv as follows:
![The data structure for the argv](/argv.png).

Note the following within the diagram:
   1. The rval of argc is four.
   1. The rval of argv is an address in memory: 0x7fffefec.
   1. The depicted addresses of memory are in increments of 4.
      - Recall, an address is a 32-bit quantity on the MIPS architecture.
      - Hence, 4 bytes are required to store a 32-bit quantity.
   1. The rval of each array element is an address.
      - This address is the starting location of each string: "one", "two", "three", and "four".
   1. The variable p_arg has been introduced into the diagram.
      - Via a loop, we will exam each element of the argv array: argv[0] ... argv[3].
      - The p_arg variable is used to **p**oint to the current **arg**ument being processed.


### Project Deliverables

The deliverables for this projects are:
  1. echo.java: which prints out the number of command-line arguments
     - Language: Java
     - Task: ensure provided starter code works
     - Tag: java-echo-start

  1. echo.java: which prints out each of the the command-line arguments 
     - Language: Java
     - Task: insert a for-loop to print each argument separated by a space (' ')
     - Tag: java-echo-done

  1. echo.s: which prints out the number of command-line arguments
     - Language: MIPS
     - Task: ensure provided starter code works
     - Tag: mips-echo-start

  1. echo.s: which prints out the series 1 .. argc 
     - Language: MIPS
     - Task: insert a loop to print the value separated by a newline ('\n')
     - Tag: mips-echo-loop

  1. echo.s: prints out the command-line arguments
     - Language: MIPS
     - Task: augment the loop to walk the argv structure and print the corresponding command-line argument
     - Tag: mips-echo-done


### Development Steps:
 1. Accept and clone the assignment.
 1. Work on the Java version of the project.

    1. Stage 1:
       * Create a file called "echo.java" that includes the starter code.
       * Test this program to ensure it works correctly
          ```
          $ javac echo.java
          $ java echo one two three four
          4
          $
          ```
       * Commit this working version to your repository
       - ``git add echo.java``
       - ``git commit -m 'some informative message'`` 
       - ``git tag java-echo-start``

    1. Stage 2:
       * Insert a for-loop to, in-turn, print out each command-line argument
         - You may use this web site (or other) to help you write your code
         - https://www.javatpoint.com/command-line-argument

       * Test this program to ensure it works correctly
         ```
         $ javac echo.java
         $ java echo one two three four
         one two three four
         $
         ```

       * Commit this working version to your repository
         - ``git add echo.java``
         - ``git commit -m 'some informative message'`` 
         - ``git tag java-echo-done``
---
 1. Work on the Java version of the project.
    1. Stage 3: 
       * Create an file called echo.s that includes the starter code
       * Note the following within the echo.s file
         1. Bookkeeping comments have been added to identify register allocation
         1. Code has been added to de-marshal the formal arguments
         1. A syscall, via the print_d macro, is used to print a decimal number
         1. A syscall, via the exiti macro, is used to exit the program with an **i**mmediate value
       * Use the booking comments to guide your develop.
       * Test this program to ensure it works correctly.
          ```
          $ mars me echo.s pa apple peach grape 2> /dev/null
          4
          $
          ```
       * Commit this working version to your repository
          - ``git add echo.s``
          - ``git commit -m 'some informative message'`` 
          - ``git tag mips-echo-start``

    1. Stage 4: 
       * Consider the following Java loop
          ```
          i=0;
          for( ; i < argc; ) {
            printf("%d\n", i);
            i++;
          }
          ```
       1. Incorporate the following MIPS loop into your program
          -  this loop is equivalent to the above Java loop
          ``` 
                 li $t1, 0              # i=0
          loop:  bge $t1, $t0, done     # for ( ; i < argc ; ) {
                   print_d $t0          #   print("%d\n", i);
                   print_ci '\n'        #
                   addi $t1, $t1, 1     #   i++;
                 b loop                 #
          done:  nop                    # }
          ```
       *  Remove the code that prints out the number of arguments.
       *  Test your code to ensure you have the following output
          ```
          $ mars me echo_cmd_line.s pa apple peach grape 2>/dev/null
          1
          2
          3
          $
          ```

    1. Stage 5: 
       1. Modify your loop to ...
          - walk the argv array
            - initialize p_arg to be the value of argv before the start of the loop
            - increment the value p_arg by 4 at the end of each loop iteration
          - print each string, in turn, within the body of the loop
            - set the value of str to be equal that address stored at p_args
              ``lw $t4, 0($t3)          #   str = (* p_args)``
            - call the ``print_s`` syscall to print the string

       1. Test your code to ensure you have the following output
          ```
          $ mars me echo_cmd_line.s pa apple peach grape 2>/dev/null
          apple peach grape
          $
          ```

1. Perform final testing and submitting your project
   
   1. Run each of the test cases in the "Validation Testing" Section
   1. Ensure you push both your code and your tags to your repository 
      ```
      $ git push           # push all of your code
      $ git push --tags    # push all of your tags
      ```
      - Note that the command ``git push --mirror`` will push your code and tags in one step.


    
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
1
2
3
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
   
     public static int main(String args[]) {
   
       final int argc = args.length; 
       System.out.printf("%d\n",argc);
   
       return 0; 
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


