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

## Substitutions
The shell performs substitution when it encounters an expression that contains one or more special characters.

The following escape sequences which can be used in echo command:
| Escape | Description                 |
|:-------|:----------------------------|
| `\\`   | Backslash                   |
| `\a`   | Alert (BEL)                 |
| `\b`   | Backspace                   |
| `\c`   | Suppress trailing newline   |
| `\f`   | Form feed                   |
| `\n`   | New line                    |
| `\r`   | Carriage return             |
| `\t`   | Horizontal tab              |
| `\v`   | Vertical tab                |


You can use the -E option to disable the interpretation of the backslash escapes (default).

You can use the -n option to disable the insertion of a new line.


### Command substitutions
Command substitution is the mechanism by which the shell performs a given set of commands and then substitutes their output in the place of the commands.

Syntax:
When performing the command substitution make sure that you use the backquote, not the single quote character.
```
\`command\`
```

Command substitution is generally used to assign the output of a command to a variable.


### Variable Substitution
Variable substitution enables the shell programmer to manipulate the value of a variable based on its state.

Here is the following table for all the possible substitutions:
| Form              | Description                                                                                                                      |
|:------------------|:---------------------------------------------------------------------------------------------------------------------------------|
| `${var}`          | Substitute the value of `var`.                                                                                                   |
| `${var:-word}`    | If `var` is null or unset, `word` is substituted for `var`. The value of `var` does not change.                                  |
| `${var:=word}`    | If `var` is null or unset, `var` is set to the value of `word`.                                                                  |
| `${var:?message}` | If `var` is null or unset, `message` is printed to standard error. This is useful for checking that variables are set correctly. |
| `${var:+word}`    | If `var` is set, `word` is substituted for `var`. The value of `var` does not change.                                            |



## Quoting Mechanisms
Can find this section with examples in `shell-scripts/quoting-mechanisms` directory



## IO Redirections
Most Unix system commands take input from your terminal and send the resulting output back to your terminal. A command normally reads its input from the standard input, which happens to be your terminal by default. Similarly, a command normally writes its output to standard output, which is again your terminal by default.


### Output Redirection
The output for a command which is normally intended for standard output can be easily diverted to a file instead. This capability is known as **Output Redirection**.

If the notation > file is appended to any command that normally writes its output to standard output, the output of that command will be written to file instead of your terminal.

Example:
```
$ who > users.txt
```

If a command has its output redirected to a file and the file already contains some data, that data will be lost.

We can use `>>` operator to append the output in an existing file as follows:
```
$ echo "hello world" >> users.txt
```


### Input Redirection
Just as the output of a command can be redirected to a file, so can the input for a command be redirected from a file. The `<` operator is used for this purpose.

So basically, instead of prompting the user for an input on the terminal or by specifying some specific arguments for a command, we can pass inputs from any sort of file (or output from some other command) directly to the command using this operator.

The file that we generated while studying output redirection, lets take that file.

Lets get the line count of that file using standard `wc` approach:
```
$ wc -l users.txt

Result: 2 users.txt
```

Now instead of specifying the file as an arg to `wc`, lets give the command input directly from the file `users.txt` using **Input Redirection**:
```
$ wc -l < users

Result: 2
```

In the first case, wc knows that it is reading its input from the file users. In the second case, it only knows that it is reading its input from standard input so it does not display file name in the result.


### Here Document
A **Here Document** is used to redirect input into an interactive shell-script or program.

So basically, if we want to give a very large text input from the terminal (standard input) itself, we can use the **Here Document**

Syntax:
```
$ command << delimiter
fill some text
over here
delimeter
```

Here the shell interprets the `<<` operator as an instruction to read input until it finds a line containing the specified delimiter. All the input lines up to the line containing the delimiter are then fed into the standard input of the command.

The delimiter tells the shell that the **Here Document** has completed. Without it, the shell continues to read the input forever. The delimiter must be a single word that does not contain spaces or tabs.


Example:
```
$ wc -l << EOF
This is a sample lookup program
for testing Here Document functionality
EOF

Result: 3
```


### Discard the Output
Sometimes you will need to execute a command, but you don't want the output displayed on the screen. In such cases, you can discard the output by redirecting it to the file `/dev/null`.

Syntax:
```
$ command > /dev/null
```

The file `/dev/null` is a special file that automatically discards all its input.

> [!IMPORTANT]
> NOTE: Read up about file descriptors and what they are (basic working of the UNIX system, it's a must for any devops engineer)


### Redirection Commands
| Command       | Description                                                               |
|---------------|---------------------------------------------------------------------------|
| `pgm > file`  | Redirects the output of `pgm` to `file` (overwrite).                      |
| `pgm < file`  | Makes `pgm` read its input from `file`.                                   |
| `pgm >> file` | Appends the output of `pgm` to `file`.                                    |
| `n > file`    | Redirects output from file descriptor *n* to `file`.                      |
| `n >> file`   | Appends output from file descriptor *n* to `file`.                        |
| `n >& m`      | Merges output of file descriptor *n* with file descriptor *m*.            |
| `n <& m`      | Merges input of file descriptor *n* with file descriptor *m*.             |
| `<< tag`      | Here-document: standard input is read until a line containing only `tag`. |
| `&verbar`     | Takes output from one program, or process, and sends it to another        |



## Functions
Functions, their implementation can be seen inside the `shell_scripts` folder.

### Function Call from Prompt
We can put definitions for commonly used functions (the ones that we create or we use someone else's functions) in `.profile`. These function definitions will be available whenever we log in and we can use them at the command prompt.

Or put the function/s in a bash script and then just execute that bash script.

To remove the definition of a function from the shell, use the `unset` command with the `-f` option. This command is also used to remove the definition of a variable to the shell.
```
$ unset -f function_name
```
