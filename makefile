EDITOR="subl"

all: review
	make java-echo-start
	make java-echo-done
	make java-echo-start
	make java-echo-loop
	make java-echo-done

java-echo-start:
	git checkout java-echo-start
	javac echo.java
	java echo pa apple peach grape 2>/dev
	git checkout main

java-echo-done:
	git checkout java-echo-done
	javac echo.java
	java echo pa apple peach grape 2>/dev
	git checkout main

mips-echo-start:
	git checkout mips-echo-start
	mars me echo pa apple peach grape 2>/dev
	git checkout main

mips-echo-loop:
	git checkout mips-echo-loop
	mars me echo pa apple peach grape 2>/dev
	git checkout main

mips-echo-start:
	git checkout mips-echo-done
	mars me echo pa apple peach grape 2>/dev
	git checkout main	

review:
	git checkout main
	$(EDITOR) echo.s
	git tags

