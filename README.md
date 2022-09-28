# Echo
### Program: Echo-ing the command line arguements

# Objectives:
   1. to introduce the command "echo" to the students
   1. to introduce command-line arguments in Java
   1. to write a MIPS program that is functional equivalent to the "echo"
      - 

# Purpose:
This is your first MIPS program.  It is


To guide you through the development process, this program is to be developed in individual stages.  Each stage will be tagged and can subsequently tested as a valid program.  The stages of this assignment are as follows:

   1. The echo program written in Java.
      - language: Java
      - See (command-line-argument)[https://www.javatpoint.com/command-line-argument]
      - tag: 
   1. Comand line count
   1. Loop with 
   1. 

# Assignment:
Write a Java program that computes a simple checksum of 8-bit integers.  This program is *based* upon the calculation of the checksum value of a IPv4 header, defined by RFC791. 

You may use any editor or IDE (for example eclispe) to develop the program.  You must, however, test your program via the commandline.  To do this final testing step, you might have to install a current version of java onto your computer.  (https://www.java.com/en/download/)

This program should conform to the following specification:

  

### Development Steps:
 1. Accept and clone the assignment
 1. Work on the Java version of the project
    1. Create an file called echo.java that includes the starter code
    1. Test this program to ensure it works correctly
       ```
       $ javac echo.java
       $ java echo one two three four
       4
       $
       ```
    1. Commit this working version to repo
       - ``git add echo.java``
       - ``git commit -m 'some informative message'`` 
       - ``git tag java-echo-start``
    1. Using the web site provided as a guide, complete a working version "echo.java"
    1. Test this program to ensure it works correctly
       ```
       $ javac echo.java
       $ java echo one two three four
       one two three four
       $
       ```
    1. Commit this working version to repo
       - ``git add echo.java``
       - ``git commit -m 'some informative message'`` 
       - ``git tag java-echo-done``

 1. Work on the MIPS version of the project
    1. Stage 1: Getting Started
       1. Create an file called echo.s that includes the starter code
       1. Test this program to ensure it works correctly
          ```
          $ mars me echo.s pa apple peach grape 2>/dev/null
          4
          $
          ```
       1. Commit this working version to repo
          - ``git add echo.s``
          - ``git commit -m 'some informative message'`` 
          - ``git tag mips-echo-start``
    1. Stage 2: Looping from 0 to argc -1
       1. Consider the following Java loop
          ```
          i=0;
          for( ; i < argc; ) {
            printf("%d\n", i);
            i++;
          }
          ```
       1. Incorporate the following MIPS that is equivalent to the above Java loop
          ``` 
                 li $t1, 0              # i=0
          loop:  bge $t1, $t0, done     # for ( ; i < argc ; ) {
                   print_d($t0)         #   print("%d\n", i);
                   print_ci '\n'        #
                   addi $t1, $t1, 1     #   i++;
                 b loop                 #
          done:  nop                    # }
          ```
       1. Remove the code that prints out the number of arguments.
       1. Test your code to ensure you have the following output
          ```
          
          $ mars me echo_cmd_line.s pa apple peach grape 2>/dev/null
          1
          2
          3
          $
          ```
    1. Stage 3: Print out each command-line argument
       1. Modify your loop to ...
          - walk the argv array
          - print each string
       1. Test your code to ensure you have the following output
          ```
          $ mars me echo_cmd_line.s pa apple peach grape 2>/dev/null
          apple peach grape
          $
          ```

   1. Stage 4: Final Test
      1. Run each of the test cases in the "Validation Testing" Section
      1. Ensure you commit, and push your submission to the remote repo.
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


