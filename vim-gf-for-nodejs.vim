
" Inspired by https://www.reddit.com/r/vim/comments/ckq3lc/navigate_to_node_module_using_gf_with_this_simple/
" Started  on 2022/01/06 16:08:22
" Modified on 2023/09/26 17:19:46
" COPY THIS FILE TO "$HOME/.vim/plugin/perfect-vim-gf-for-javascript.js"

function SetupPerfectGFForJavaScript()
  set path=.,src,node_modules
  set suffixesadd+=.mjs,.cjs,.jsx,.tsx,.ts,.js,.html,xhtml
  set includeexpr=LookupNodeModuleBoth(v:fname)
  set et sw=2 ts=2 sts=2
  syn keyword javaScriptStatement async await
endfunction

autocmd FileType javascript,json,jsx,javascriptreact,typescript,tsx,typescriptreact,html,xhtml call SetupPerfectGFForJavaScript()

function! LookupNodeModuleDir(fname)
  let basePath = finddir( 'node_modules/' . a:fname, expand('%:p:h') . ';' )
  let indexFileJs = basePath . '/index.js'
  let indexFileTs = basePath . '/index.ts'
  let packageFile = basePath . '/package.json'

  if filereadable(packageFile)
    let package = json_decode(join(readfile(packageFile)))

    if has_key(package, 'module')
      return basePath . '/' . package.module
    endif

    if has_key(package, 'main')
      return basePath . '/' . package.main
    endif
  endif

  if filereadable(indexFileTs)
    return indexFileTs
  endif

  if filereadable(indexFileJs)
    return indexFileJs
  endif

  return ''
endfunction

function! LookupNodeModuleFile(fname)
  " echo 'node_modules/' . a:fname
  let basePath = findfile( 'node_modules/' . a:fname, expand('%:p:h') . ';' )
  if len(basePath) != 0
    " echo 'not equal 0'
    return basePath
  endif
  return ''
endfunction

function! LookupNodeModuleBoth(fname)
  let dir0 = LookupNodeModuleDir(a:fname)
  if len( dir0 ) != 0
    return dir0
  endif

  let file0 = LookupNodeModuleFile(a:fname)
  if len( file0 ) != 0
    return file0
  endif

  let l:modname = a:fname
  let l:modname = substitute( l:modname, "^src/", "", "g" )
  let l:modname = substitute( l:modname, "^libtbc/", "", "g" )
  let l:modname = substitute( l:modname, "^/", "", "g" )
  echo l:modname

  " <<< ADDED (Tue, 12 Dec 2023 18:35:02 +0900)
  let dir1 = LookupNodeModuleDir( l:modname )
  if len( dir1 ) != 0
    return dir1
  endif

  let file1 = LookupNodeModuleFile( l:modname )
  if len( file1 ) != 0
    return file1
  endif
  " >>> ADDED (Tue, 12 Dec 2023 18:35:02 +0900)


  return l:modname
endfunction


