# The Echo Utility

## Assignment:
   1. Write a Java program equivalent to the echo utility
   1. Write a MIPS program equivalent to the echo utility

## Echo Overview
  - Name:
    * echo - write aruments to the standard output

  - Description:
    - The echo utility writes any specified operands, separated by single blank (' ') characters and followed by a newline (‘\n’) character, to the standard output.

  - Example:
    ```
    $ echo one two three
    one two three
    $
    ```

## Assignment Objectives:
   1. Introduce command line processing
   1. To exercise your Java knowledge to create the 'echo' command
   1. To introduce you to MIPS programming:
      - the structure of the main subroutine
      - the command-line argument passing convention
      - the use of syscall to perform I/O operations
      - using a loop to iterate over an array of Strings
   1. To further your knowledge in the use of "git"


## Project Overview
This is your first MIPS program. You will be guided through this development process, via a set of stages. Each stage is designed to bring you closer to the final MIPS program.  Moreover, each stage produces a working program; said program is a deliverable that must be tested and submitted for grading.

The deliverables for this projects are:
  1. echo.java: prints out the number of command-line arguments
     - Language: Java
     - Task: ensure provided starter code works
     - Repo Tag: java-echo-start

  1. echo.java: prints out of the command-line arguments 
     - Language: Java
     - Tasks: insert a for-loop to process each argument in turn
     - Repo Tag: java-echo-done

  1. echo.s: prints out the number of command-line arguments
     - Language: MIPS
     - Task: ensure provided starter code works
     - Repo Tag: mips-echo-start

  1. echo.s: counts and prints the number of command-line arguments
     - Language: MIPS
     - Task: insert a loop to that counts from 1 to the number of arguments
     - Repo Tag: mips-echo-loop

  1. echo.s: prints out the command-line arguments
     - Language: MIPS
     - Task: augment the loop to walk the argv structure and print the corresponding command-line argument
     - Repo Tag: mips-echo-done


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
    1. Stage 3: MIPS code to echo the number of command-line arguments
       * Create an file called echo.s that includes the starter code
       * Test this program to ensure it works correctly
          ```
          $ mars me echo.s pa apple peach grape 2>/dev/null
          4
          $
          ```
       * Commit this working version to repo
          - ``git add echo.s``
          - ``git commit -m 'some informative message'`` 
          - ``git tag mips-echo-start``

    1. Stage 4: Looping from 0 to argc -1
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
                   print_d($t0)         #   print("%d\n", i);
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
          - print each string
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

1. echo.s that echos out the command-line arguements:
```
$ git checkout mips-echo-done
$ mars me echo_cmd_line.s pa apple peach grape 2>/dev/null
apple peach grape
$ git checkout main
```



### Starter Code:

#### Java
   ```
   class echo  
   {  
   
     public static int main(String args[]) {
   
       final int argc = args.length; 
       System.out.printf("%d\n,argc);
   
      return 0; 
     }
   }  
   ```

#### MIPS
   ```
            .data
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
            print_d($t0)
            print_ci '\n'
        
            # Return from main with the value of zero
            exiti(0)

   ```            


