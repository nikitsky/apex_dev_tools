# APEX development tools

Set of scripts and templates for comfortable APEX development on Mac OS

##Tools
To effectively use this set of scripts and templates, the following additional tools supposed to be used: 
(All these tools are optional, but some changes would be required in the scripts if you are using sqlplus instead of sqlcl, for example)

###Sublime text
Sublime Text is a sophisticated text editor. It supports a ton of tricks and makes your development work efficient and enjoyable. 
The following plugins would be especially useful:

- Oracle PL\SQL - Oracle PL/SQL bundle inculding language syntax, templates and snippets 
- [AdvancedNewFile](https://github.com/skuroda/Sublime-AdvancedNewFile#features)  - This plugin allows for faster file creation within a project. 
- [FileDiffs](https://github.com/colinta/SublimeFileDiffs) - Show diffs between the current file, or selection(s) in the current file, and clipboard, another file, or unsaved changes. Configure to use ksdiff as the external diff tool.
- [Alignment](https://github.com/wbond/sublime_alignment) - Easy alignment of multiple selections and multi-line selections.

###SQL Command Line - SQLcl 
Oracle SQL Developer Command Line (SQLcl) is a free command line interface for Oracle Database. It allows you to interactively or batch execute SQL and PL/SQL. SQLcl provides in-line editing, statement completion, and command recall for a feature-rich experience,  all while also supporting your previously written SQL*Plus scripts. You can download it here: http://www.oracle.com/technetwork/developer-tools/sql-developer/downloads/index.html

###iTerm2
iTerm2 is terminal emulator for OS X. iTerm2 brings the terminal into the modern age with features you never knew you always wanted. You can download it here: https://www.iterm2.com

###Kaleidoscope 
[Kaleidoscope](http://www.kaleidoscopeapp.com) is a visual diff tool and spot the differences in text, images, and folders, review and merge changes. 
If you are going to use it, after installation from the Kaleidoscope integration menu, do install command-line tool and git integration.

#Install and configure
###Prepare project directory
1. create a directory and clone this repository to it
2. open _Sublime Text_, do _File -> New window_, than _Project -> Add folder to Project_..., select the project directory and _Project -> Save Project As..._

###Configure environments
Open ```config/environments.sh``` file and put your environments credentials.
The main configuration should be done in set_env function.
A case section should be added for every environment alias and the following variables should be defined: 

- _databaseUrl_: full oracle database URL in format host:port:sid
- _databaseUser_: database user name
- _databasePassword_: database password. It is optional, if not specified, you will be asked to enter you password before every connect
- _sshServer_: host name or IP for SSH access
- _sshPort_: ssh port 
- _sshUser_: user for ssh session
- _iTermBadge_: A badge is a large text label that appears in the top right of your iTerm window to provide dynamic status. This badge will be added to sqlcl and ssh session for simple identification

Update function known_env just for informational purposes.

###Configure APEX applications
File ```config/applications.sh``` holds information about APEX applications you are working with. For every application two variables are required: _appId_ and _appName_. Also an alias should be defined for simpler usage.
You can use the following sql to get all required information:
```sql
select lower(ALIAS) ALIAS, APPLICATION_ID,  APPLICATION_NAME
  from APEX_APPLICATIONS 
  where OWNER = user;
```

Also you can fetch all applications from your APEX workspace using ```WORKSPACE_DISPLAY_NAME='MY_WORKSPACE_NAME'``` in section ```where```.

##SQLcl
1. be sure that java is configured, sqlcl is installed and available within PATH. Type ```sql``` in the terminal to check.
2. type ```./sc``` and after login type the following:
```sql
alias load tools/sqlcl/aliases.xml
```
it will load sqlcl aliases. 


##Sublime text
Copy everything from ```<project dir>/tools/sublime_user_packages``` to Sublime Text user configuration directory. To find it, go to menu _Preferences -> Browse packages..._ and find User directory.

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
It will export application form the development environment and save it in ```apex\environment``` directory.
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
(description to be added)
- log 
- ld 
- col 
- invalid 
- script apxexp 
- script apximp 
- script kill 
- script logr 
- script sqlprompt 
- script transpose 


