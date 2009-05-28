"
" Find a file. (like cmd-t in textmate)
"
" Put this into ~/.vim/plugins/Find.vim
"
" Modified not to find svn files, and not to look in ./vendor
" 
" Based on http://www.vim.org/tips/tip.php?tip_id=1432 by Samuel Hughes
" 
" From his notes;
" This adds similar capabilities as the cmd-t file search feature in TextMate.
" I put the "Find" function below into my .vimrc since it's relatively small.
" I found a similar function a while ago, but I can't trace the author in
" order to credit them. Anyway, I modified it a bit in order to make it more
" like TextMate.
"
" It will search recursively whatever directory you are in.
"
" So for example, I am in "~/alumni" directory and I am looking for a file
" named "admin_controller.rb" somewhere beneath "~/alumni", I could type:
"
" :Fi adm trol
"
" where "adm" and "trol" are excerpts of "admin_controller.rb", and the result
" will be:
"
" 1       ./app/controllers/admin_controller.rb
" 2       ./test/functional/admin_controller_test.rb
" Which ? (<enter>=nothing)
"
" Then you type the number next to the file you're searching for and hit
" enter.
"
function! Find(name)
  let l:_name = substitute(a:name, "\\s", "*", "g")
  let l:list=system("find . -iname '*".l:_name."*' -not -name \"*.class\" -and -not -name \"*.swp\" -not -name \"*.svn*\" | grep -v '^\.\/\.git' | grep -v '^\.\/vendor' | grep -v '^\.\/coverage' | perl -ne 'print \"$.\\t$_\"'")
  let l:num=strlen(substitute(l:list, "[^\n]", "", "g"))
  if l:num < 1
    echo "'".a:name."' not found"
    return
  endif

  if l:num != 1
    echo l:list
    let l:input=input("Which ? (<enter>=nothing)\n")

    if strlen(l:input)==0
      return
    endif

    if strlen(substitute(l:input, "[0-9]", "", "g"))>0
      echo "Not a number"
      return
    endif

    if l:input<1 || l:input>l:num
      echo "Out of range"
      return
    endif

    let l:line=matchstr("\n".l:list, "\n".l:input."\t[^\n]*")
  else
    let l:line=l:list
  endif

  let l:line=substitute(l:line, "^[^\t]*\t./", "", "")
  execute ":e ".l:line
endfunction

command! -nargs=1 Find :call Find("<args>")

map ,f :Find<space>
