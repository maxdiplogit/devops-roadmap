# Basics

The basics of an OS, Kernel, CLI and Shell

## The Kernel
- This is the **core** part of an Operating System. It manages the CPU, memory, devices, and system calls
- Kernel is always the gatekeeper to hardware
- For example: Linux kernel, NT kernel

## Operating System (OS)
- This is the **entire** system, which includes kernel + utilities, user interfaces and tools
- For example: Ubuntu, macOS, Windows

## Terminal OR Command Line Interface (CLI)
- The Terminal talks to the kernal **indirectly**
- It's the interface where we type commands (e.g. iTerm2 etc.)

## Shell
- This is a program inside the Terminal (CLI)
- It parses our input and talks to the kernel

## Overall Picture
```
+-----------------------------------------------------+
|                  User Applications                  |  <-- GUI apps, scripts, tools
|    (Browsers, Editors, VS Code, etc.)               |
|    +---------------- CLI ------------------------+  |  
|    | Terminal Emulator (e.g., Terminal, iTerm2)   | |  <-- CLI: text-based interface
|    |   +------------- Shell -------------+        | |  
|    |   | bash / zsh / fish / PowerShell  |        | |  <-- Shell: command interpreter
|    |   +---------------------------------+        | |  
|    +---------------------------------------------+  |
+--------------------↑--------------------------------+
                     | (System Calls via Shell commands)
+--------------------|--------------------------------+
|                Operating System (OS)                |  <-- Kernel + system tools
|   +---------------------------------------------+   |
|   |                Kernel (Core)                |   |  <-- Manages hardware resources
|   |  - Memory Management                        |   |
|   |  - Process Scheduling                       |   |
|   |  - File Systems                             |   |
|   |  - Device Drivers                           |   |
|   +---------------------------------------------+   |
+-----------------------------------------------------+
|                Hardware (CPU, RAM, Disk)            |  <-- Physical machine
+-----------------------------------------------------+
```
