Description
-----------
The java_checkstyle.vim filetype plugin script integrates Checkstyle
<http://checkstyle.sourceforge.net/> with Vim.  "Checkstyle is a
development tool to help programmers write Java code that adheres to a
coding standard" (from the Checkstyle home page).  This plugin allows a
user to run Checkstyle on the current Java file, putting the results in an
errorfile and jumping to the first Checkstyle error.

Dependencies
------------
The plugin depends on Java <http://java.sun.com/> and Checkstyle
<http://checkstyle.sourceforge.net/>.  It was written using Checkstyle
version 3.1.

Installation
------------
The java_checkstyle.vim script should be copied to the right directory.
On UNIX, this is ~/.vim/ftplugin; see ':help ftplugins' and ':help
add-global-plugin' for more information.  You will likely need to specify
the location of the checkstyle-all jar file and your desired Checkstyle
configuration file, which can be done either by editing the script itself
or by adding the settings to your vimrc file (see the section in the
script called "Configuration").  If you have not already done so, you will
also need to turn on filetype plugin usage in Vim using the following
command (you will probably want to put this in your vimrc file):

    :filetype plugin on

Usage
-----
java_checkstyle.vim is a filetype plugin for Java files that introduces the
following command:

:Checkstyle - runs Checkstyle <http://checkstyle.sourceforge.net/> on the
              current file and opens the results in an errorfile

In order to use the command, simply edit a Java file and then execute
:Checkstyle.  You should jump to the first Checkstyle error.  You can move
through the remain errors using the standard QuickFix commands (see ':help
quickfix' for more information).

Platforms
---------
This script has been developed on Linux, but it should work on any
platform with Vim and Java.  I would appreciate any feedback regarding
portability.

