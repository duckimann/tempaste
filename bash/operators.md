# Linux Operators

### 1. Ampersand Operator ( & )
The function of ‘&‘ is to make the command run in background. Just type the command followed with a white space and ‘&‘. You can execute more than one command in the background, in a single go.

``` bash 
apt-get update & apt-get upgrade
```

### 2. semi-colon Operator ( ; )
The semi-colon operator makes it possible to run, several commands in a single go and the execution of command occurs sequentially.

``` bash 
apt-get update; mkdir test
```

### 3. AND Operator ( && )
The AND Operator ( && ) would execute the second command only, if the execution of first command SUCCEEDS, i.e., the exit status of the first command is 0. This command is very useful in checking the execution status of last command.

``` bash 
sudo apt update && echo "Done."
```

### 4. OR Operator ( || )
The OR Operator (||) is much like an ‘else‘ statement in programming. The above operator allow you to execute second command only if the execution of first command fails, i.e., the exit status of first command is ‘1‘.

``` bash 
sudo apt update || echo "Failed."
```

### 5. NOT Operator ( ! )
The NOT Operator (!) is much like an ‘except‘ statement. This command will execute all except the condition provided.

``` bash 
rm -rf !(*.txt) # Remove everything except txt file
```

### 6. PIPE Operator ( | )
This PIPE operator is very useful where the output of first command acts as an input to the second command. For example, pipeline the output of ‘ls -l‘ to ‘less‘ and see the output of the command.
``` bash 
ls -l | less
```

### 7. Command Combination Operator {}
Combine two or more commands, the second command depends upon the execution of the first command.

``` bash 
[ -d bin ] || { echo Directory does not exist, creating directory now.; mkdir bin; } && e
ho Directory exists.
```

### 8. Precedence Operator ()
The Operator makes it possible to execute command in precedence order.

``` bash 
(Command_x1 &&Command_x2) || (Command_x3 && Command_x4)
```

### 9. Concatenation Operator ( \ )
The Concatenation Operator (\) as the name specifies, is used to concatenate large commands over several lines in the shell. For example, The below command will open text file test(1).txt.

``` bash
nano test\(1\).txt
```

### 10. AND - OR operator ( && - || )
The above operator is actually a combination of ‘AND‘ and ‘OR‘ Operator. It is much like an 'if-else' statement.
``` bash
ping -c3 github.com && echo "verified" || echo "Host Down"
```