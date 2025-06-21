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
