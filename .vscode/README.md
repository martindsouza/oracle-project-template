# MS Visual Studio Code Build Tasks

[Microsoft Visual Studio Code (VSC)](https://code.visualstudio.com/) is a code editor. It is the recommended editor for Logger. VSC allows for compile PL/SQL code directly from VSC (see [this blog](https://ora-00001.blogspot.ca/2017/03/using-vs-code-for-plsql-development.html)) for more information.

To help, all the [VSC Task](https://code.visualstudio.com/docs/editor/tasks) configuration has been taken care of. All you need to do is provide the Oracle connection string. When you first run the compile task a new file will be generated in this folder called `vsc-task-env`. In this file, replace `CHANGEME` with your connection string (such as `giffy/giffy@localhost:32122/orclpdb514.localdomain`).

To run the Task, open `packages/logger.pkb`. Launch Command Pallette (`cmd+shift+p`) then select `Tasks: Run Build Task` (it will show you the keyboard shortcut for future use). Select `compile: oos-logger`.