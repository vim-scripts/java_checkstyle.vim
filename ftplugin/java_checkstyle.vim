" File: java_checkstyle.vim
" Author: Xandy Johnson
" Version: 0.1
" Last Modified: October 15, 2002
"
" Credits
" -------
" This filetype plugin is heavily based on the grep.vim plugin by Yegappan
" Lakshmanan (see <http://vim.sourceforge.net/script.php?script_id=311>), who
" generously gave permission for this use.  Many thanks to Yegappan.
"
" Also, quite obviously, many thanks are due to the Checkstyle developers, as
" well as the developers of the many other fine tools involved in making this
" plugin work.
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
" The 'VIMCheckstyle_Path' variable is used to locate the vimcheckstyle
" utility. By default, this is set to /usr/local/bin/vimcheckstyle. You can
" change this using something like the following let command (which you may
" want to put in your .vimrc):
"
"       :let VIMCheckstyle_Path = '/home/xandy/bin/vimcheckstyle'

if exists("loaded_java_checkstyle") || &cp
    finish
endif
let loaded_java_checkstyle = 1

" Location of the vimcheckstyle script
if !exists("VIMCheckstyle_Path")
    let VIMCheckstyle_Path = '/usr/local/bin/vimcheckstyle'
endif

" RunCheckstyle()
" The script represented by VIMCheckstyle_Path runs Checkstyle on the current
" file and uses XSLT to transform it into something that easily fits a VIM
" errorformat.  This function runs that script, redirects the output to a temp
" file, uses that file as an errorfile, and cleans up.
function! s:RunCheckstyle()
    let filename = expand("%:p")
    let checkstyle_cmd = g:VIMCheckstyle_Path . ' ' . filename
    let cmd_output = system(checkstyle_cmd)

    let tmpfile = tempname()

    execute "redir! > " . tmpfile
    silent echon cmd_output
    redir END

    let old_errorformat = &errorformat
    set errorformat=[checkstyle-errors]:%f:%l:%c:%m

    execute "silent! cfile " . tmpfile

    let &errorformat = old_errorformat

    " Jump to the first error
    cc

    call delete(tmpfile)
endfunction

" Define the command
command! -nargs=* Checkstyle call s:RunCheckstyle()

