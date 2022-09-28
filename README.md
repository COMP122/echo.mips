# Echo
### Program: Echo-ing the command line arguements


# Purpose:
This is your first MIPS program.  To guide you through the development process, this program is to be developed in individual stages.  Each stage will be tagged and can subsequently tested as a valid program.  The stages of this assignment are as follows:

   1. The echo program written in Java.
      - language: Java
      - See (command-line-argument)[https://www.javatpoint.com/command-line-argument]
      - tag: 
   1. Comand line count
   1. Loop with 
   1. 




 git push origin --tags

 
# Assignment:
Write a Java program that computes a simple checksum of 8-bit integers.  This program is *based* upon the calculation of the checksum value of a IPv4 header, defined by RFC791. 

You may use any editor or IDE (for example eclispe) to develop the program.  You must, however, test your program via the commandline.  To do this final testing step, you might have to install a current version of java onto your computer.  (https://www.java.com/en/download/)

This program should conform to the following specification:

  

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
            # Formal Arguments
            # a0: argc
            # a1: argv
            # v0: 0
    
            # De-marshal input args
            move $t0, $a0
            move $t1, $a1
     
            # Print number of arguments
            print_d($t0)
            print_ci '\n'
        
            # Return from main with the value of zero
            exiti(0)

   ```            


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
       - ``git tag java-echo-complete``

 1. Work on the MIPS version of the project
    1. Stage 1: Getting Started
       1. Create an file called echo.s that includes the starter code
       1. Test this program to ensure it works correctly
          ```
          $ mars echo.s pa one two three four
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
          for( ; i < argc; i++) {
            printf("%d\n", i);
          }
          ```
       1. Incorporate the following MIPS that is equivalent to the above Java loop
          ``` 
                 li $t1, 0     # i=0
          loop:  bge $t1, $t0, nop
                   print_d($t0)
                   print_ci '\n'
                   addi $t1, $t1, 1
                 b loop
          done:  nop
          ```
       1. Remove the code that prints out the number of arguments.
       1. Test your code to ensure you have the following output
          ```
          $ mars echo.s pa one two three four
          1
          2
          3
          4
          $
          ```
    1. Stage 3: Process each arg




    
       1. Remove
          - ``git add echo.s``
          - ``git commit -m 'some informative message'`` 
          - ``git tag mips-echo-loop``

     1. Stage 2: Looping from 0 to argc -1

 Work on the MIPS
    - ``git add checksum.java`` 
    - ``git commit -m 'added starter code'``
    - ``git tag initialized``
 5. Introduce a loop that calculates the sum of 10 integers, and then commit and tag.
    - ``git add checksum.java``
    - ``git commit -m 'added loop'``
    - ``git tag loop``
 6. Introduce a conditional to handle the sixth input value, and then commit and tag.
    - ``git add checksum.java``
    - ``git commit -m 'handled the 6th element'``
    - ``git tag sixth``
 7. Compute the values of quotient, remainder, and then commit and tag.
    - ``git add checksum.java``
    - ``git commit -m 'quotient & remainder done'``
    - ``git tag quotient``
 8. Recompute the value of sum, and then commit and tag.
    - ``git add checksum.java``
    - ``git commit -m 'recomputed sum'`` 
    - ``git tag sum``
 9. Compute the final value of complement, and then commit and tag.
    - ``git add checksum.java``
    - ``git commit -m 'calculated complement'``
    - ``git tag complement``
 10. Perform a final push with tags included
    - ``git push --tags``

Note that you must perform at least one ``push`` to your repo before the due date to have your submission graded.
That it so say, you will get an automatic zero for this assignment if you do not make at least one push by the due date.


    
### Testing:
Via the command line, test your program with the provided test cases.

```
$ java checksum < 156.txt
Stored Checksum: 156, Computed Checksum: 156
```

```
$ java checksum < 229_error.txt
Stored Checksum: 229, Computed Checksum: 132
Error Detected!
```

```
$ java checksum < 81.txt
Stored Checksum: 81, Computed Checksum: 81
```


#### Git Commands to remember
1. ``git clone``: to create a local repository (and working directory) of your remote repository
2. ``git pull``: a command to perform a *fetch* and *merge* in one step 
   - ``git fetch``: to copy all new information from the remote repository into the local repository
   - ``git merge``: to merge all new information from the local repository into the working directory
4. ``git add``: to add a file to the staging area 
5. ``git commit``: to place all stage files into the local repository
6. ``git push``: to copy all new information from the local repository into the remote repository
7. ``git status``: to obtain a recap of your current working directory, staging, and branch information
8. ``git tag``: to associate a name with your current "commit" location.



# Other Information and Resources:
This program is based upon the structure if a IPv4 packet.  Although you do not need to understand this structure to complete this assignment, you may want to review some of the material associated with IPv4.  More information will be provided in the lecture.
* https://en.wikipedia.org/wiki/IPv4
* https://en.wikipedia.org/wiki/IPv4_header_checksum

### Notes:
* The IPv4 header utilizes a checksum field that is 16-bit quantity. This program reduces the size in half to a 8-bit quantity.  Correspondingly, the following changes are made to keep things consistent: 
* The IPv4 header, without any options, has a total size of 20 bytes. This program reduces the size in half to a 10 byte size.
* This checksum value is stored in the 11th & 12th byte of the IPv4 header. This program assigns its location to the 6th byte.


