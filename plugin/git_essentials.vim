" Fix GBrowse when over SSH; fix courtesy of Tim Pope: https://github.com/tpope/vim-rhubarb/issues/69#event-6633323753
if exists('$SSH_CONNECTION')
  command! -bar -nargs=* Browse echo "Link: " . <q-args>
endif

" Ensure that when we leave a git buffer by usual (:wq) which leave the buffer there
" the buffer is still closed since editing it later wouldn't make sense
augroup GitBuffers
  autocmd FileType gitcommit,gitrebase,gitconfig set bufhidden=delete
augroup END

" Ensure X works on a conflicted file delete by the rebasee in git status
" see https://github.com/tpope/vim-fugitive/issues/1699
let g:fugitive_conflict_x = 1

" Set signify symbols
let g:signify_sign_add               = '+'
let g:signify_sign_delete            = '_'
let g:signify_sign_delete_first_line = '‾'
let g:signify_sign_change            = '~'

let g:signify_sign_show_count = 1
let g:signify_sign_show_text = 1

" Sane vim-fuzzy-stash configuration
let g:fuzzy_stash_actions = {
  \ 'ctrl-d': 'drop',
  \ 'ctrl-o': 'pop',
  \ 'ctrl-a': 'apply' }

" Flog settings
let g:flog_default_opts = { 'date' : 'short' }

" Git messenger settings
let g:git_messenger_include_diff = 'current'

