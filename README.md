# APEX development tools

Set of scripts and templates for comfortable APEX development

##Tools
To effectively use this set of scripts and templates, the following additional tools are recommended: 
###sublime text
Sublime Text is a sophisticated text editor.
Useful plugins:

- Oracle PL\SQL - Oracle PL/SQL bundle inculding language syntax, templates and snippets 
- [AdvancedNewFile](https://github.com/skuroda/Sublime-AdvancedNewFile#features)  - This plugin allows for faster file creation within a project. 
- [FileDiffs](https://github.com/colinta/SublimeFileDiffs) - Show diffs between the current file, or selection(s) in the current file, and clipboard, another file, or unsaved changes. Configure to use ksdiff as the external diff tool.
- [Alignment](https://github.com/wbond/sublime_alignment) - Easy alignment of multiple selections and multi-line selections.

###Kaleidoscope 
to spot the differences in text, images, and folders, review and merge changes. [website](http://www.kaleidoscopeapp.com)
From the Kaleidoscope integration menu, do install command-line tool and git integration

###SQL Command Line - SQLcl 
Oracle SQL Developer Command Line (SQLcl) is a free command line interface for Oracle Database. It allows you to interactively or batch execute SQL and PL/SQL. SQLcl provides in-line editing, statement completion, and command recall for a feature-rich experience,  all while also supporting your previously written SQL*Plus scripts.
http://www.oracle.com/technetwork/developer-tools/sql-developer/downloads/index.html

#Install and configure

##SQLcl
add a line to your .bash_profile file (~/.bash_profile)
```shell
export SQLPATH=<project dir>/tools/sqlcl
```

##Sublime text
Copy everything from <project dir>/tools/sublime_user_packages to Sublime Text user configuration directory. To find it, go to menu Preferences -> Browse packages... and find User directory.

##How to use
###oracle sql command line
in the project folder type 
```shell
./sc dev
```
You will be connected to the development environment. Use _prod_ instead of _dev_ to connect to the production database. 

###export APEX application
in the project folder type
```shell
./exp <application alias> [<environment>]
```
by default, it exports applications from the development environment. You can export all known application using 'all' instead of the application alias
It will export application form the development environment and save it in apex\environment directory.
The export file constructed as: "alias version (last modification date).sql"

###open ssh session to an environment
in the project folder type
```shell
./sh [<environment>]
```
by default, it connects to development environment

###database object templates
To create a database object from the template: 

1. in Sublime Text open "Go to anything"  ⌘ + P 
2. type new <object_type> and select appropriate file from the list, open it 
3. open "Command Pallete" ⌘ ⇧ + P 
4. select "file: Duplicate" 
5. enter new object name in the "Duplicate as" panel 

###useful sublime shortcuts 
- Command + ; (⌘ + ;) opens "Go to anything" panel with a word on which the cursor is 
- Control + Command + c (⌃ + ⌘ + c) copies current file path relatively to the project root. Just put @ on the beginning and use in sqlcli to execute

### useful sqlcl commands
log
ld
col
invalid
script apxexp
script apximp
script kill
script logr
script sqlprompt
script transpose


