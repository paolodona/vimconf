" System vimrc file for Mac OS X
" Author:  Benji Fisher <benji@member.AMS.org>
" Last modified:  8 May 2006

" TODO:  Is there a better way to tell that Vim.app was started from Finder.app?
" Note:  Do not move this to the gvimrc file, else this value of $PATH will
" not be available to plugin scripts.
if has("gui_running") && system('ps xw | grep "Vim -psn" | grep -vc grep') > 0
  " Get the value of $PATH from a login shell.
  " If your shell is not on this list, it may be just because we have not
  " tested it.  Try adding it to the list and see if it works.  If so,
  " please post a note to the vim-mac list!
  if $SHELL =~ '/\(sh\|csh\|bash\|tcsh\|zsh\)$'
    let s:path = system("echo echo VIMPATH'${PATH}' | $SHELL -l")
    let $PATH = matchstr(s:path, 'VIMPATH\zs.\{-}\ze\n')
  endif
endif

if has("gui_running")
  if has("gui_gtk2")
    set gfn=Bitstream\ Vera\ Sans\ Mono\ 20
  elseif has("gui_kde")
    set gfn=Bitstream\ Vera\ Sans\ Mono/20
  elseif has("x11")
    set gfn=*-courier-medium-r-normal-*-*-200-*-*-m-*-*
  else
    set gfn=Anonymous:h12:cDEFAULT
  endif
endif 

" paolo's customizations
set nocompatible
syntax on
filetype plugin indent on
set hidden
set number
set shiftwidth=2
set ts=2
map Y y$
map ,r :Rfind<space>
set dir=~/tmp
set hls is
set autoindent
set expandtab
set incsearch
nnoremap <C-n> :bnext<CR>
nnoremap <C-p> :bprevious<CR>
" colorscheme ir_black
 
"Macros
map ,ofs :%s/ it / xit <CR>''?xit<CR>x:w<CR>
map ,oft :%s/def test/def xtest<CR>''?xtest<CR>x:w<CR>

map ,ons :%s/ xit / it /<CR>'':w<CR>
map ,ont :%s/def xtest/def test/<CR>'':w<CR>

map ,db Odebugger<ESC>:w<CR>
nmap ,ih <ESC>:AlignPush<CR>:AlignCtrl lp1P1l<CR>mmvaB:Align =><CR>:AlignPop<CR>'mvaB=
nmap ,fh <ESC>^:s/{/{\r/<CR>:s/}$/\r}<CR>vaB:s/\v,\s*:/,\r:/g<CR>,ih

"Abbreviations
abbr doo do \|
abbr ,,v =>
abbr ..v #{
abbr eend <% end -%>
abbr eelse <% else -%>
abbr ruby #!/usr/bin/env ruby
abbr sh #!/bin/sh 
abbr lorem Lorem ipsum dolor sit amet, consectetur adipisicing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum.

"comment on/off
map ,cc :s/^/#
map ,co :s/^#//
