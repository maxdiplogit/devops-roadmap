## Level 0

This level requires us to login to a remote machine using ssh.

Usage of ssh:
```
> ssh <username>@<remote> -p <port>
```

Password found in this level: `ZjLjTmM6FvvyRnrb2rfNWOZOTa6ip5If`

## Level 1

This level asks us to use the following commands:
```
`ls` , `cd` , `cat` , `file`, `du` , `find`
```

`file`: tells you what type of content a file contains (based on its content, not its name)
`find`: searches for files and directories recursively in a given directory tree, based on various criteria like name, type, size, permissions, etc.
`du`: estimates and reports file/directory disk usage, typically in blocks, KB, MB, or GB.

This level asks us to login as the user `bandit0` using the password found in [Level 0](#level-0)

Password found in this level: `263JGJPfgU6LtdEvgfWU1XP5yac29mFx`

## Level 2
This level also asks us to login to the remote machine as bandit2 with the password found in [Level 1](#level-1)

This deals with escaping special characters in our shell.

Password found in this level: `MNk8KNH3Usiio41PRUEoDFPqfxLPlSmx`

## Level 3
This level also asks us to login to the remote machine as bandit3 with the password found in [Level 2](#level-2)

This deals with getting hidden files in a directory (usage of ls -a).

Password found in this level: `2WmrDFRmJIq3IPxneAaMGhap0pFhF3NJ`

## Level 4
This level also asks us to login to the remote machine as bandit4 with the password found in [Level 3](#level-3)

This level requires us to find the file which is in human-readble format using the `file` command.

Also for doing `cat` on a filename like `-file00`, had to do `cat ./-file07`
We can also do `cat -- -file07`, the `--` option tells `cat` to stop processing options, so anything after is treated as a filename

Password found in this level: `4oQYVPkxZOOEOO5pTW81FB8j8lxXGUQw`

## Level 5
This level also asks us to login to the remote machine as bandit5 with the password found in [Level 4](#level-4)


