# Shell Scripting

Shell Scripting means writing a series of commands in a text (.sh) file, which the Shell (like bash, sh, zsh, etc.) reads and executes **line-by-line**

Shell scripts are mostly used to:
- Automate repetitive tasks
- Manage files, backups and logs
- Install software
- Run cron jobs
- Chain together Unix/Linux tools

> [!NOTE]
> - Shell Scripting is POSIX-compliant
> - POSIX (Portable Operating System Interface) is a standard defined by IEEE to ensure that programs (including shell scripts) behave consistently across different Unix-like operating systems (like Linux, macOS, BSD, etc.)
> - POSIX is a set of rules or guidelines that OSes and tools can follow to behave in a consistent and predictable way
> - So when we say `"This script is POSIX compliant..."`, it means that it only uses features and syntax that are standardized and available in all POSIX-compliant shells, and also avoid shell specific extensions


## The Shebang
A Shebang is the first line in a script file that tells the OS **which interpreter to use** to run the script. It is one of the most important features in scripting.

The format is: `#!/path/to/interpreter`
It literally means: `"Hey OS, run the script using this program/interpreter"`

### Examples:
| Shebang Line          | Interpreter Used        | Use Case                     |
| --------------------- | ----------------------- | ---------------------------- |
| `#!/bin/sh`           | POSIX shell (`sh`)      | Portable shell scripting     |
| `#!/bin/bash`         | Bash shell              | Bash-specific scripts        |
| `#!/usr/bin/env bash` | Finds `bash` in `$PATH` | More portable across systems |
| `#!/usr/bin/python3`  | Python 3 interpreter    | Python scripts               |
| `#!/usr/bin/env node` | Node.js interpreter     | JavaScript CLI apps          |

> [!IMPORTANT]
> - Now if we were to use: `#!/bin/<shell-to-use>`, the path might not be the same on different Operating Systems
> - Hence we use a more portable way to do this:
>   ```
>   #!/usr/bin/env <shell-to-use>
>   ```
>   This will use the `env` program common in all POSIX compliant systems (path is common in all), which looks for the `$PATH` envronment variable which is ":" seperated and includes a list of places to search for commands and gets the <shell-to-use> in our bash script and then shebang does the work of using it.

> [!WARNING]
> - What if we don't use a Shebang?
> - The OS might use the default shell, which could be anything
> - The script may fail silently if it uses only a specific shell (like bash) features

> [!TIP]
> - We can use the `which <command>`
> - It is used to give the executable file for that particular command. For e.g. `which bash` would give us the executable file path for bash command


## Shell Scripting Basics
- [Go to this link to learn the basics of Shell Scripting](https://www.tutorialspoint.com/unix/shell_scripting.htm)


## Linux File Permissions and Ownership
Linux file permissions and ownership are based on three layers:
- **User (owner)**: The person who owns the file
- **Group**: A group of users who can share permissions
- **Others**: Everyone else

Each layer has three types of permissions:
- r -> read
- w -> write
- x -> execute (run, or enter directory)

To view the metadata of a file, run the command `ls -l`, it will display something as follows:
```
-rwxr-xr-- 1 harshmeet devops  131 Jun 19  script.sh

-rwxr-xr--  
 │ │ │
 │ │ └── "Others": can read only
 │ └──── "Group": can read & execute
 └────── "User": can read, write, execute
```

### chmod to change permissions
Syntax: `chmod [options] [permissions] file`

#### Examples:
```
u -> user
g -> group
o -> others
a -> all
```
```
- chmod u+x script.sh      # Add execute for User
- chmod g-w script.sh      # Remove write for Group
- chmod o=r script.sh      # Others can only read
- chmod a+x script.sh      # All (user/group/others) can execute
```

### chown to change ownership
Syntax: `chown [user][:group] file`

> [!IMPORTANT]
> We need to be either `sudo | root` to change ownership of files

#### Examples
```
- chown root script.sh 			# Change owner to root
- chown maxdiplo:devops script.sh 	# Change owner to 'maxdiplo' and group 'devops'
- chown :devops script.sh 		# Only change group
```

## Variable Types in Shell
When a shell is running, three main types of variables are present:
- **Shell Variables**: These are variables created and used inside our shell session (or script) but not exported to sub processes
  Example:
  ```
  NAME="maxdiplo"
  echo $NAME
  ```
  - Only available to the current shell
  - Not inherited by commands you run from this shell (e.g. a script, `ls`, `python`)
- **Environment Variables**: These are variables that are exported to subprocesses and child shells
  ```
  export NAME="maxdiplo"
  ```
  Difference between shell and environment variable:
  ```
  FOO="123"       # shell variable
  export BAR="456"  # environment variable

  bash -c 'echo $FOO'  # No output
  bash -c 'echo $BAR'  # 456
  ```
- **Local Variables**: These are variables which are declared inside a function using the `local` keyword
```
my_func() {
  local MESSAGE="hello"
  echo "$MESSAGE"
}

my_func		# prints hello
echo $MESSAGE	# prints nothing (not visible here)
```

> [!IMPORTANT]
> Local Variables are only supported in `bash`, not POSIX `sh`


## Special Variables in Shell
Special Variables are built-in variables that the shell (bash, zsh, etc.) automatically sets for us. We don't declare them - they are always there and their meaning is special to the shell.

They usually start with a `$` + `a symbol or a number`

### Positional Parameters
These are used when we pass arguments to a script

- `$0` -> the name of the script iteself
- `$<n>` -> the nth argument passed
- `$@` -> all arguments, separately quoted
- ``$*` -> all arguments, as one string
- `$#` -> the number of arguments

### Exit Status
- `$?` -> the exit code of the last command
  - if 0 -> success,
  - else error

### Process IDs
- `$$` -> PID of the current shell/script
- `$!` -> PID of the last background command

### Special Symbols
- `$_` -> the last argument of the previous command
- `$-` -> current shell options (like `himBH`)
- `$$`

> [!NOTE]
> - When are these special symbols actually used?
> - `Script Arguments ($1, $2, $@)`: when writing scripts that take input
> - `Error Handling ($!)`: check if a command succeeded
> - `Process Control ($!, $$)`: useful in background jobs, debugging, logging
> - `Scripting tricks ($_)`: handy for re-running commands on the last file/arg


## Arrays in Shell
Array variables can hold multiple values at the same time, they provide a method of grouping a set of variables.

- This is how we can create an array (variable) in Shell:
  ```
  NAME[0] = "Zara";
  NAME[1] = "Ali";
  ```

- If we are using Bash, this is how we define array values:
  ```
  array_name=(value1 ... valuen);
  ```

- This is how we can access array values in Shell:
  ```
  ${array_name[index]}
  ```

## Shell Basic Operators
Different kinds of operators supported by Shell (but mostly discussing about Bash)

### Arithmetic Operators
```
a=10;
b=20;
```

| Operator | Description                                                           | Example                                 |
|----------|-----------------------------------------------------------------------|-----------------------------------------|
| +        | Adds values on either side of the operator                            | `expr $a + $b` will give 30             |
| -        | Subtracts right hand operand from left hand operand                   | `expr $a - $b` will give -10            |
| *        | Multiplies values on either side of the operator                      | `expr $a \* $b` will give 200           |
| /        | Divides left hand operand by right hand operand                       | `expr $b / $a` will give 2              |
| %        | Divides left hand operand by right hand operand and returns remainder | `expr $b % $a` will give 0              |
| =        | Assigns right operand to left operand                                 | `a = $b` would assign value of b into a |
| ==       | Compares two numbers; returns true if both are same                   | `[ $a == $b ]` would return false       |
| !=       | Compares two numbers; returns true if both are different              | `[ $a != $b ]` would return true        |

### Relational Operators
```
a=10;
b=20;
```

| Operator | Description                                                                                    | Example                     |
|----------|------------------------------------------------------------------------------------------------|-----------------------------|
| -eq      | Checks if the value of two operands are equal; true if equal                                   | `[ $a -eq $b ]` is not true |
| -ne      | Checks if the value of two operands are not equal; true if not equal                           | `[ $a -ne $b ]` is true     |
| -gt      | Checks if the left operand is greater than the right operand; true if yes                      | `[ $a -gt $b ]` is not true |
| -lt      | Checks if the left operand is less than the right operand; true if yes                         | `[ $a -lt $b ]` is true     |
| -ge      | Checks if the left operand is greater than or equal to the right operand; true if yes          | `[ $a -ge $b ]` is not true |
| -le      | Checks if the left operand is less than or equal to the right operand; true if yes             | `[ $a -le $b ]` is true     |

### Boolean Operators
```
a=10;
b=20;
```

| Operator | Description                                                                                   | Example                                |
|----------|-----------------------------------------------------------------------------------------------|----------------------------------------|
| !        | Logical negation; inverts a true condition into false and vice versa                          | `[ ! false ]` is true                  |
| -o       | Logical OR; true if at least one of the operands is true                                      | `[ $a -lt 20 -o $b -gt 100 ]` is true  |
| -a       | Logical AND; true only if both operands are true                                              | `[ $a -lt 20 -a $b -gt 100 ]` is false |

### String Operators
```
a="abc";
b="efg";
```

| Operator | Description                                                                                    | Example                   |
|----------|------------------------------------------------------------------------------------------------|---------------------------|
| =        | Checks if the value of two operands are equal; true if equal                                   | `[ $a = $b ]` is not true |
| !=       | Checks if the value of two operands are not equal; true if not equal                           | `[ $a != $b ]` is true    |
| -z       | Checks if the string length is zero; true if it is zero                                        | `[ -z $a ]` is not true   |
| -n       | Checks if the string length is non-zero; true if it is not empty                               | `[ -n $a ]` is not false  |
| str      | Checks if the string is not empty; true if it is not empty                                     | `[ $a ]` is not false     |

### File Test Operators
```
Assume a variable file holds an existing file name "test" the size of which is 100 bytes and has read, write and execute permission on
```

| Operator | Description                                                                                   | Example                    |
|----------|-----------------------------------------------------------------------------------------------|----------------------------|
| -b file  | True if file is a block special file                                                          | `[ -b $file ]` is false    |
| -c file  | True if file is a character special file                                                      | `[ -c $file ]` is false    |
| -d file  | True if file is a directory                                                                   | `[ -d $file ]` is not true |
| -f file  | True if file is a regular file (not directory or special file)                                | `[ -f $file ]` is true     |
| -g file  | True if file has its set-group-ID (SGID) bit set                                              | `[ -g $file ]` is false    |
| -k file  | True if file has its sticky bit set                                                           | `[ -k $file ]` is false    |
| -p file  | True if file is a named pipe (FIFO)                                                           | `[ -p $file ]` is false    |
| -t file  | True if file descriptor is open and associated with a terminal                                | `[ -t $file ]` is false    |
| -u file  | True if file has its set-user-ID (SUID) bit set                                               | `[ -u $file ]` is false    |
| -r file  | True if file is readable                                                                      | `[ -r $file ]` is true     |
| -w file  | True if file is writable                                                                      | `[ -w $file ]` is true     |
| -x file  | True if file is executable                                                                    | `[ -x $file ]` is true     |
| -s file  | True if file size is greater than 0                                                           | `[ -s $file ]` is true     |
| -e file  | True if file exists (including directories)                                                   | `[ -e $file ]` is true     |


## Decision Making
Two different ways for decision making in shell scripting

### if...else statement
Syntax:
```
if [ expression 1 ]
then
   Statement(s) to be executed if expression 1 is true
elif [ expression 2 ]
then
   Statement(s) to be executed if expression 2 is true
elif [ expression 3 ]
then
   Statement(s) to be executed if expression 3 is true
else
   Statement(s) to be executed if no expression is true
fi
```

### case...esac statement
```
case word in
   pattern1)
      Statement(s) to be executed if pattern1 matches
      ;;
   pattern2)
      Statement(s) to be executed if pattern2 matches
      ;;
   pattern3)
      Statement(s) to be executed if pattern3 matches
      ;;
   *)
     Default condition to be executed
     ;;
esac
```


## Shell Loops
There are 4 different kinds of loops that can be used in Shell Scripting

### `while` loop
Syntax:
```
while command
do
   Statement(s) to be executed if command is true
done
```

### `for` loop
This loop has many variations, but some are specific to Bash only

- POSIX for loop syntax:
  ```
  for var in word1 word2 ... wordN
  do
    Statement(s) to be executed for every word.
  done
  ```

- Bash specific c-style syntax:
  ```
  for (( i=start_value; i<=end_value; i++ ))
  do
    echo "Current number: $i"
  done
  ```

- POSIX until loop syntax:
  The until loop will keep on executing only if the condition specified is false
  ```
  until [ <false condition> ]
  do
    // do something
  done
  ```
