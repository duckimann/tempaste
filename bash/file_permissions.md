# Ownership of Linux files
Every file and directory on your Unix/Linux system is assigned 3 types of owner, given below.

## User
A user is the owner of the file. By default, the person who created a file becomes its owner. Hence, a user is also sometimes called an owner.

## Group
A user- group can contain multiple users. All users belonging to a group will have the same Linux group permissions access to the file. Suppose you have a project where a number of people require access to a file. Instead of manually assigning permissions to each user, you could add all users to a group, and assign group permission to file such that only this group members and no one else can read or modify the files.

## Other
Any other user who has access to a file. This person has neither created the file, nor he belongs to a usergroup who could own the file. Practically, it means everybody else. Hence, when you set the permission for others, it is also referred as set permissions for the world.

Now, the big question arises how does Linux distinguish between these three user types so that a user 'A' cannot affect a file which contains some other user 'B's' vital information/data. It is like you do not want your colleague, who works on your Linux computer, to view your images. This is where Permissions set in, and they define user behavior.

<hr>

# Permissions
Every file and directory in your UNIX/Linux system has following 3 permissions defined for all the 3 owners discussed above.

* **Read** (r): This permission give you the authority to open and read a file. Read permission on a directory gives you the ability to lists its content.

* **Write** (w): The write permission gives you the authority to modify the contents of a file. The write permission on a directory gives you the authority to add, remove and rename files stored in the directory. Consider a scenario where you have to write permission on file but do not have write permission on the directory where the file is stored. You will be able to modify the file contents. But you will not be able to rename, move or remove the file from the directory.

* **Execute** (x): In Windows, an executable program usually has an extension ".exe" and which you can easily run. In Unix/Linux, you cannot run a program unless the execute permission is set. If the execute permission is not set, you might still be able to see/modify the program code(provided read & write permissions are set), but not run it.

``` bash
ducki@ubuntu~ ls -lAh
total 184K
drwxr-xr-x  2 ducki ducki 4.0K Jul 11 04:05 Desktop
drwxr-xr-x  2 ducki ducki 4.0K Jul 11 05:15 Downloads
drwxrwxr-x 35 ducki ducki 4.0K Jul 11 04:40 fonts
drwxr-xr-x  2 ducki ducki 4.0K Jul 11 04:05 Public
drwxrwxr-x  2 ducki ducki 4.0K Jul 12 08:54 Wallpapers
```
```
d(rwx)(rwx)(r-x)  2 ducki ducki 4.0K Jul 12 08:54 Wallpapers
|  |    |    |
|  |    |    |------------|
|  |    |                 |
|  |    |------- |        |
|  |             |        |
|  |----|        |        |
|       |        |        |
dir    user    group    other
```

<hr>

# Changing file/directory permissions with 'chmod' command
Say you do not want your colleague to see your personal images. This can be achieved by changing file permissions.

We can use the 'chmod' command which stands for 'change mode'. Using the command, we can set permissions (read, write, execute) on a file/directory for the owner, group and the world. Syntax:
``` bash
chmod permissions filename
```

There are 2 ways to use the command:
1. Absolute mode
2. Symbolic mode

## Absolute(Numeric) Mode
In this mode, file permissions are not represented as characters but a three-digit octal number.

The table below gives numbers for all for permissions types.

Number | Permission Type | Symbol
-|-|-
0 | No Permission | ---
1 | Execute | --x
2 | Write | -w-
3 | Execute + Write | -wx
4 | Read | r--
5 | Read + Execute | r-x
6 | Read + Write | rw-
7 | Read + Write + Execute | rwx

## Symbolic Mode
In the Absolute mode, you change permissions for all 3 owners. In the symbolic mode, you can modify permissions of a specific owner. It makes use of mathematical symbols to modify the Unix file permissions.

Operator | Description
-|-
\+ | Adds a permission to a file or directory
\- | Removes the permission
= | Sets the permission and overrides the permissions set earlier.

The various owners are represented as:


User Denotations | Represent of
-|-
u | user/owner
g | group
o | other
a | all

<hr>

# Changing Ownership and Group
For changing the ownership of a file/directory, you can use the following command:
``` bash
chown user
```

In case you want to change the user as well as group for a file or directory use the command:
``` bash
chown user:group filename
```

In case you want to change group-owner only, use the command:
``` bash
chgrp group_name filename # 'chgrp' stands for change group.
```

# Tips
- The file /etc/group contains all the groups defined in the system
- Command "groups" to find all the groups you are a member of
- You can use the command newgrp to work as a member a group other than your default group
- You cannot have 2 groups owning the same file.
- You do not have nested groups in Linux. One group cannot be sub-group of other
- x- eXecuting a directory means Being allowed to "enter" a dir and gain possible access to sub-dirs
- There are other permissions that you can set on Files and Directories which will be covered in a later advanced tutorial

[Credit]:# (https://www.guru99.com/file-permissions.html)