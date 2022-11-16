fu! git_essentials#SystemGit(command) abort
  return substitute(execute('Git ' . a:command), '^.', '', '')
endfunction

fu! git_essentials#Get_tracking_branch(localbranch) abort
  let l:remote_tracking_branch = git_essentials#SystemGit('config branch.'.a:localbranch.'.merge')
  return l:remote_tracking_branch
endfunction

fu! git_essentials#Set_tracking_branch_if_missing() abort
  let l:branch = git_essentials#SystemGit('name-rev --name-only HEAD')
  let l:remote_tracking_branch = git_essentials#Get_tracking_branch(l:branch)
  if l:remote_tracking_branch ==# ''
    call git_essentials#SystemGit('branch --set-upstream-to origin/' . l:branch . ' ' . l:branch)
  endif
endfunction

fu! git_essentials#Track_and_pull() abort
  call git_essentials#Set_tracking_branch_if_missing()
  execute 'Git pull'
endfunction

function! git_essentials#CommitQF(...)
    " Get the commit hash if it was specified
    let commit = a:0 == 0 ? 'HEAD^' : a:1

    " Get the result of git show in a list
    let flist = system(FugitiveShellCommand('diff') . ' --name-only ' . commit)
    let flist = split(flist, '\n')

    " Create the dictionaries used to populate the quickfix list
    let list = []
    for f in flist
        let l:real_filename = FugitiveWorkTree() . '/' . f
        let dic = {'filename': l:real_filename, 'lnum': 1}
        call add(list, dic)
    endfor

    " Populate the qf list
    call setqflist(list)
endfunction

