"------------------------------------------------------
" init
"------------------------------------------------------
let g:my_tab_labels = {}
let g:my_tab_info = ""

set laststatus=2
set statusline=%!vis#statusline#MyStatusline()
set tabline=%!vis#tabline#MyTabLine()

"------------------------------------------------------
" command for ide
"------------------------------------------------------
command                         MyIDE            call vis#MyIDE()
command                         MyWinInitSize    call vis#MyWinInitSize()
command                         MySideBarToggle  call vis#sidebar#MySideBarToggle()

"------------------------------------------------------
" command for buffer
"------------------------------------------------------
command                         MyBufDelete      call vis#buffer#MyBufDelete()

"------------------------------------------------------
" command for window
"------------------------------------------------------
command -nargs=1                MyWinResize      call vis#window#MyWinResize(<f-args>)
command -nargs=1                MyWinVResize     call vis#window#MyWinVResize(<f-args>)
command -nargs=1                Wx               call vis#window#MyWinBufExchange(<f-args>)
command -nargs=1                Wc               call vis#window#MyWinBufCopy(<f-args>)

command                         MyRedraw         call vis#MyRedraw()

"------------------------------------------------------
" command for tab
"------------------------------------------------------
command -nargs=+ -complete=file MyTabDiff        call vis#tab#MyTabDiff(<f-args>)
command -nargs=+ -complete=dir  MyTabDirDiff     call vis#tab#MyTabDirDiff(<f-args>)
command                         MyTabDirDiffQuit call vis#tab#MyTabDirDiffQuit()
command                         MyTabClosePrev   call vis#tab#MyTabClosePrev()

command -nargs=1                MyIDEVResizeT2E  call vis#send#MyIDEVResizeT2E(<f-args>)
command -nargs=+ -complete=dir  MyIDESendCdT2T   call vis#send#MyIDESendCdT2T(<f-args>)
command                         MyIDESendCdE2T   call vis#send#MyIDESendCdE2T()

func MyTabDiff(file1, file2)
  call vis#tab#MyTabDiff(a:file1, a:file2)
endfunc

"------------------------------------------------------
" command for tabline
"------------------------------------------------------
command -nargs=1                MyTabLineSetLabel call vis#tabline#MyTabLine_SetLabel(<f-args>)
command -nargs=1                MyTabLineSetInfo  call vis#tabline#MyTabLine_SetInfo(<f-args>)

"------------------------------------------------------
" command for term
"------------------------------------------------------
command -nargs=?                MyTerm             call vis#term#MyTerm(<f-args>)
command -nargs=0                MyTermV            call vis#term#MyTermV()

func Tapi_Exec(bufnr, cmdline)
  call vis#term#Tapi_Exec(a:bufnr, a:cmdline)
endfunc

func Tapi_ExecInPrevWin(bufnr, cmdline)
  call vis#term#Tapi_ExecInPrevWin(a:bufnr, a:cmdline)
endfunc

func Tapi_ExecInAboveWin(bufnr, cmdline)
  call vis#term#Tapi_ExecInAboveWin(a:bufnr, a:cmdline)
endfunc

func Tapi_ExecInNewTab(bufnr, cmdline)
  call vis#term#Tapi_ExecInNewTab(a:bufnr, a:cmdline)
endfunc

"------------------------------------------------------
" command for fern
"------------------------------------------------------
command                         MyFernDrawerToggle call vis#external#fern#MyFernDrawerToggle()
command -nargs=1 -complete=dir  MyFernDrawer       call vis#external#fern#MyFernDrawer(<f-args>)
command -nargs=1 -complete=dir  MyFern             call vis#external#fern#MyFern(<f-args>)

func MyFern(dir, drawer='', toggle='')
  call vis#external#fern#MyFern(a:dir, a:drawer, a:toggle)
endfunc

"------------------------------------------------------
" command for nerdtree
"------------------------------------------------------
command                         MyNERDTreeToggle   call vis#external#nerdtree#MyNERDTreeToggle()
command -nargs=1 -complete=dir  MyNERDTreeFind     call vis#external#nerdtree#MyNERDTreeFind(<f-args>)

"------------------------------------------------------
" command for fugitive
"------------------------------------------------------
command -nargs=1                MyGgrep            call vis#external#fugitive#MyGgrep(<f-args>)
command                         MyGstatusToggle    call vis#external#fugitive#MyGstatusToggle()

"------------------------------------------------------
" command for quickhl
"------------------------------------------------------
command -nargs=1                MyQuickhl          call vis#external#quickhl#MyQuickhl(<f-args>)

"------------------------------------------------------
" command for ref
"------------------------------------------------------
command -nargs=+                MyMan              call vis#external#ref#MyRef("man", <q-args>)
command -nargs=+                MyPydoc            call vis#external#ref#MyRef("pydoc", <q-args>)

"------------------------------------------------------
" command for help
"------------------------------------------------------
command -nargs=?                MyHelp             call vis#internal#help#MyHelp(<f-args>)

"------------------------------------------------------
" command for vimgrep
"------------------------------------------------------
command -nargs=+                MyVimgrep          call vis#internal#vimgrep#MyVimgrep(<f-args>)

"------------------------------------------------------
" command for tag jump
"------------------------------------------------------
command -nargs=+                MyTjump            call vis#internal#tjump#MyTjump(<f-args>)

func MyTjump(tag_name, winnr=0)
  call vis#internal#tjump#MyTjump(a:tag_name, a:winnr)
endfunc

"------------------------------------------------------
" command for util
"------------------------------------------------------
command -nargs=1                MySetTab           call vis#util#MySetTab(<f-args>)
command                         MyLineNumberToggle call vis#util#MyLineNumberToggle()

command                         MyCheckEnv         call vis#util#MyCheckEnv()
command -nargs=0                MyWinInfo          call vis#util#MyWinInfo()

command                         MyCdHere           exec "cd"  expand("%:p:h")
command                         MyTcdHere          exec "tcd" expand("%:p:h")
command                         MyLcdHere          exec "lcd" expand("%:p:h")

"------------------------------------------------------
" autocmd
"------------------------------------------------------
augroup ag_ide_map
  autocmd!
  autocmd WinEnter        *      call vis#map#MyBufferMap()
  autocmd QuickFixCmdPost *grep* below cwindow
  autocmd QuickFixCmdPost *make* below cwindow
augroup END

augroup ag_ide_term
  autocmd!
  if !has('nvim')
    autocmd TerminalOpen *       call vis#statusline#MySetStatuslineForTerm()
  else
    autocmd TermOpen     *       call vis#statusline#MySetStatuslineForTerm()
  endif
augroup END

augroup ag_ide_bmk
  autocmd!
  autocmd FileType bmk           call vis#statusline#TtSetStatuslineForSideBar()
augroup END

augroup ag_ide_fern
  autocmd!
  autocmd FileType fern          call glyph_palette#apply()
  autocmd FileType fern          call vis#statusline#TtSetStatuslineForSideBar()
  autocmd FileType fern          call vis#external#fern#MyFernMap()
  autocmd User     FernSyntax    call vis#external#fern#MyFernSyntax()
  autocmd User     FernHighlight call vis#external#fern#MyFernHighlight()
augroup END

augroup ag_ide_nerdtree
  autocmd!
  autocmd FileType nerdtree      call vis#external#nerdtree#MyNERDTreeMap()
augroup END

augroup ag_ide_fugitive
  autocmd!
  autocmd FileType fugitive      call vis#external#fugitive#MyFugitiveMap()
augroup END

