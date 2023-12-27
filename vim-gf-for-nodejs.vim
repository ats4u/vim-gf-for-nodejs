" Inspired by https://www.reddit.com/r/vim/comments/ckq3lc/navigate_to_node_module_using_gf_with_this_simple/
" Started  on 2022/01/06 16:08:22
" Modified on 2023/09/26 17:19:46
" COPY THIS FILE TO "$HOME/.vim/plugin/perfect-vim-gf-for-javascript.js"

" This plugin enables you to 'gf'-jump from filenames such as:
" require( 'module_name/foo.js' ) // a path to a filename
" require( 'module_name/foo'    ) // a path to a filename without its file extension
" require( 'module_name/'       ) // a path to a directory without filename
"
" If the path is to a directory, it reads 
" 'package.json' and get 'main' / 'module'
" field as its filename. 
" This hopefully covers most cases.

function! SetupPerfectGFForJavaScript()
  set path=.,src,node_modules
  set suffixesadd+=.js,.jsx,.ts,.tsx,.mjs,.cjs
  set includeexpr=LookupNodeModuleBoth(v:fname)
  set et sw=2 ts=2 sts=2
  syn keyword javaScriptStatement async await
endfunction

autocmd FileType javascript,json,jsx,typescript,tsx,typescriptreact call SetupPerfectGFForJavaScript()

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

  return a:fname
endfunction
