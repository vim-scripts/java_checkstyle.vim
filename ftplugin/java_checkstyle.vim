" File: java_checkstyle.vim
" Author: Xandy Johnson
" Version: 0.2
" Last Modified: October 22, 2002
"
" Credits
" -------
" The structure of this filetype plugin is based on the grep.vim plugin by
" Yegappan Lakshmanan (see
" <http://vim.sourceforge.net/script.php?script_id=311>), who generously gave
" permission for this use.  Many thanks to Yegappan.
"
" Special thanks are also due to Doug Kearns, who wrote a compiler plugin with
" essentially the same purpose as this filetype plugin, namely the integration
" of Checkstyle and Vim (see
" <http://mugca.its.monash.edu.au/~djkea2/vim/compiler/checkstyle.vim>).
" Using his errorformat allowed the use of Checkstyle directly, eliminating
" several dependencies.  I also thank Salmon Halim, who sent me Doug Kearns'
" compiler plugin.  Both Doug and Salmon helpfully explained things for me and
" graciously allowed me to use their work.
" 
" Also, quite obviously, many thanks are due to the Checkstyle developers, as
" well as Bram Moolenaar and the other developers of Vim.
"
" Usage
" -----
" java_checkstyle.vim is a filetype plugin for Java files that introduces the
" following command:
"
" :Checkstyle - runs Checkstyle <http://checkstyle.sourceforge.net/> on the
"               current file and opens the results in an errorfile
"
"
" Configuration
" -------------
" The 'Checkstyle_Jar_Path' variable is used to locate the checkstyle-all jar
" file from the Checkstyle distribution.  By default, this is set to
" /opt/checkstyle/checkstyle-all-2.4.jar. You can change this using something
" like the following let command (which you may want to put in your vimrc
" file):
"
"       :let Checkstyle_Jar_Path = 'C:\checkstyle-2.4\checkstyle-all-2.4.jar'

if exists("loaded_java_checkstyle") || &cp
    finish
endif
let loaded_java_checkstyle = 1

" Location of the checkstyle-all jar file
if !exists("Checkstyle_Jar_Path")
    let Checkstyle_Jar_Path = '/opt/checkstyle/checkstyle-all-2.4.jar'
endif

" RunCheckstyle()
" This function runs Checkstyle using the jar file represented by
" Checkstyle_Jar_Path as the classpath, redirects the output to a temp
" file, uses that file as an errorfile, and cleans up.
function! s:RunCheckstyle()

    " Setup and invoke the command
    let filename = expand("%:p")
    let checkstyle_cmd = 'java -cp ' . g:Checkstyle_Jar_Path . ' com.puppycrawl.tools.checkstyle.Main -f plain ' . filename
    let cmd_output = system(checkstyle_cmd)

    " Redirect the output to a temp file
    let tmpfile = tempname()
    execute "redir! > " . tmpfile
    silent echon cmd_output
    redir END

    " store the existing errorformat so that it can be restored later
    let old_errorformat = &errorformat

    set errorformat=%f:%l:\ %m,%f:%l:%v:\ %m,%-G%.%#

    " Read the error file
    execute "silent! cfile " . tmpfile

    " restore the previously existing error format
    let &errorformat = old_errorformat

    " Jump to the first error
    cc

    call delete(tmpfile)
endfunction

" Define the command
command! -nargs=* Checkstyle call s:RunCheckstyle()

