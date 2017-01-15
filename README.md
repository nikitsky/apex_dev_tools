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

###iTerm2
iTerm2 is terminal emulator for OS X. iTerm2 brings the terminal into the modern age with features you never knew you always wanted. https://www.iterm2.com


#Install and configure
###Prepare project directory
1. create a directory and extract all files from this archive to it
2. open Sublime Text, do File -> New window, than Project -> Add folder to Project..., select the project directory and Project -> Save Project As...

###Configure environments
Open config/environments.sh file and put your environments credentials.
The main configuration should be done in set_env function.
A case section should be added for every environment alias and the following variables should be defined: 

- databaseUrl: full oracle database URL in format host:port:sid
- databaseUser: database user name
- databasePassword: database password. It is optional, if not specified, you will be asked to enter you password before every connect
- sshServer: host name or IP for SSH access
- sshPort: ssh port 
- sshUser: user for ssh session
- iTermBadge: A badge is a large text label that appears in the top right of your iTerm window to provide dynamic status. This badge will be added to sqlcl and ssh session for simple identification

Update function known_env just for informational purposes.

###Configure APEX applications
config/applications.sh file holds information about APEX applications you are working with. For every application two variables are required: appId and appName. Also an alias should be defined for simpler usage.
You can use the following sql to get all required information:
```sql
select lower(ALIAS) ALIAS, APPLICATION_ID,  APPLICATION_NAME
  from APEX_APPLICATIONS 
  where OWNER = user;
```

Also you can fetch all applications from your APEX workspace using ```WORKSPACE_DISPLAY_NAME='MY_WORKSPACE_NAME'``` in section ```where```.

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
3. open "Command Palette" ⌘ ⇧ + P 
4. select "file: Duplicate" 
5. enter new object name in the "Duplicate as" panel 

###useful sublime shortcuts 
- Command + ; (⌘ + ;) opens "Go to anything" panel with a word on which the cursor is 
- Control + Command + c (⌃ + ⌘ + c) copies current file path relatively to the project root. Just put @ on the beginning and use in sqlcl to execute

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


