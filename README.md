# JMAN

A PoC environment manager for J. Currently a single script that will only run on Linux. Idea is to have a single management point on the user's computer, to manage the various J versions, and projects.

Management files are put into the `$HOME/.jman` directory.

## example

Create a new project, called `myproject`, using J 701

```
./installer.sh myproject 701
```

If `J701` is not installed, the script will download the files and install,
before creating the project folder.
