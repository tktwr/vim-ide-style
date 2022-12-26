"------------------------------------------------------
" init
"------------------------------------------------------
set laststatus=2
set statusline=%!vis#statusline#VisStatusline()
set tabline=%!vis#tabline#VisTabLine()

"------------------------------------------------------
" command for ide
"------------------------------------------------------
command                         VisIDE            call vis#VisIDE()
command                         VisRedraw         call vis#VisRedraw()

"------------------------------------------------------
" command for buffer
"------------------------------------------------------
command                         VisBufDelete      call vis#buffer#VisBufDelete()
command -nargs=1                Wx                call vis#buffer#VisWinBufExchange(<f-args>)
command -nargs=1                Wc                call vis#buffer#VisWinBufCopy(<f-args>)

"------------------------------------------------------
" command for window
"------------------------------------------------------
command -nargs=1                VisWinResize      call vis#window#VisWinResize(<f-args>)
command -nargs=1                VisWinVResize     call vis#window#VisWinVResize(<f-args>)

func VisWinMaximizeXToggle(max_width)
  call vis#window#VisWinMaximizeXToggle(a:max_width)
endfunc

func VisWinMaximizeYToggle(max_height)
  call vis#window#VisWinMaximizeYToggle(a:max_height)
endfunc

func VisWinMaximizeXYToggle(max_width, max_height)
  call vis#window#VisWinMaximizeXYToggle(a:max_width, a:max_height)
endfunc

"------------------------------------------------------
" command for sidebar
"------------------------------------------------------
command                         VisSideBarToggle  call vis#sidebar#VisSideBarToggle()

"------------------------------------------------------
" command for tab
"------------------------------------------------------
command -nargs=+ -complete=file VisTabDiff        call vis#tab#VisTabDiff(<f-args>)
command                         VisTabClosePrev   call vis#tab#VisTabClosePrev()

func VisTabDiff(file1, file2)
  call vis#tab#VisTabDiff(a:file1, a:file2)
endfunc

func VisTabEdit()
  tabedit
  tcd
endfunc

"------------------------------------------------------
" command for statusline
"------------------------------------------------------
command -nargs=1                VisStatuslineForTermSetLabel call vis#statusline#set_label(<f-args>)

"------------------------------------------------------
" command for tabline
"------------------------------------------------------
command -nargs=1                VisTabLineSetLabel call vis#tabline#set_label(<f-args>)
command -nargs=1                VisTabLineSetInfo  call vis#tabline#set_info(<f-args>)

"------------------------------------------------------
" command for term
"------------------------------------------------------
command -nargs=?                VisTerm            call vis#term#VisTerm(<f-args>)
command -nargs=0                VisTermV           call vis#term#VisTermV()

func Tapi_ExecEcho(bufnr, cmdline)
  call vis#term#Tapi_ExecEcho(a:bufnr, a:cmdline)
endfunc

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
" command for send
"------------------------------------------------------
command -nargs=1                VisVResizeT2E     call vis#send#VisVResizeT2E(<f-args>)
command -nargs=+ -complete=dir  VisSendCdT2T      call vis#send#VisSendCdT2T(<f-args>)
command                         VisSendCdE2T      call vis#send#VisSendCdE2T()

func VisSendCurrCmdE2T()
  call vis#send#VisSendCmdE2T("")
endfunc

"------------------------------------------------------
" command for dirdiff
"------------------------------------------------------
command -nargs=+ -complete=dir  VisTabDirDiff     call vis#external#dirdiff#VisTabDirDiff(<f-args>)
command                         VisTabDirDiffQuit call vis#external#dirdiff#VisTabDirDiffQuit()

func VisTabDirDiff(dir1, dir2)
  call vis#external#dirdiff#VisTabDirDiff(a:dir1, a:dir2)
endfunc

"------------------------------------------------------
" command for fern
"------------------------------------------------------
command                         VisFernDrawerToggle call vis#external#fern#VisFernDrawerToggle()
command -nargs=1 -complete=dir  VisFernDrawer       call vis#external#fern#VisFernDrawer(<f-args>)
command -nargs=1 -complete=dir  VisFern             call vis#external#fern#VisFern(<f-args>)

func VisFern(dir, drawer='', toggle='')
  call vis#external#fern#VisFern(a:dir, a:drawer, a:toggle)
endfunc

func VisFernOpenItem()
  call vis#external#fern#VisFernOpenItem()
endfunc

func VisFernViewItem()
  call vis#external#fern#VisFernViewItem()
endfunc

func VisFernBmkItem()
  call vis#external#fern#VisFernBmkItem()
endfunc

"------------------------------------------------------
" command for nerdtree
"------------------------------------------------------
command                         VisNERDTreeToggle   call vis#external#nerdtree#VisNERDTreeToggle()
command -nargs=1 -complete=dir  VisNERDTreeFind     call vis#external#nerdtree#VisNERDTreeFind(<f-args>)

"------------------------------------------------------
" command for fugitive
"------------------------------------------------------
command -nargs=1                VisGgrep            call vis#external#fugitive#VisGgrep(<f-args>)
command                         VisGstatusToggle    call vis#external#fugitive#VisGstatusToggle()

func VisTabGstatusToggle()
  call vis#external#fern#VisLcd()
  tabedit
  call vis#external#fugitive#VisGstatusToggle()
endfunc

"------------------------------------------------------
" command for gv
"------------------------------------------------------
func VisTabGV()
  call vis#external#fern#VisLcd()
  tabedit
  call MyGV()
endfunc

"------------------------------------------------------
" command for quickhl
"------------------------------------------------------
command -nargs=1                VisQuickhl          call vis#external#quickhl#VisQuickhl(<f-args>)

"------------------------------------------------------
" command for ref
"------------------------------------------------------
command -nargs=+                VisMan              call vis#external#ref#VisRef("man", <q-args>)
command -nargs=+                VisPydoc            call vis#external#ref#VisRef("pydoc", <q-args>)

"------------------------------------------------------
" command for help
"------------------------------------------------------
command -nargs=?                VisHelp             call vis#internal#help#VisHelp(<f-args>)

"------------------------------------------------------
" command for vimgrep
"------------------------------------------------------
command -nargs=+                VisVimgrep          call vis#internal#vimgrep#VisVimgrep(<f-args>)

"------------------------------------------------------
" command for tag jump
"------------------------------------------------------
command -nargs=+                VisTjump            call vis#internal#tjump#VisTjump(<f-args>)

func VisTjump(tag_name, winnr=0)
  call vis#internal#tjump#VisTjump(a:tag_name, a:winnr)
endfunc

func VisTjumpPrompt()
  call vis#internal#tjump#VisTjumpPrompt()
endfunc

"------------------------------------------------------
" command for util
"------------------------------------------------------
command -nargs=1                VisSetTab           call vis#util#VisSetTab(<f-args>)
command                         VisLineNumberToggle call vis#util#VisLineNumberToggle()

command                         VisCheckEnv         call vis#util#VisCheckEnv()
command -nargs=0                VisWinInfo          call vis#util#VisWinInfo()

command                         VisCdHere           exec "cd"  expand("%:p:h")
command                         VisTcdHere          exec "tcd" expand("%:p:h")
command                         VisLcdHere          exec "lcd" expand("%:p:h")

"------------------------------------------------------
" autocmd
"------------------------------------------------------
augroup ag_ide_map
  autocmd!
  autocmd WinEnter        *      call vis#map#VisBufferMap()
  autocmd QuickFixCmdPost *grep* below cwindow
  autocmd QuickFixCmdPost *make* below cwindow
augroup END

augroup ag_ide_term
  autocmd!
  if !has('nvim')
    autocmd TerminalOpen *       call vis#statusline#VisSetStatuslineForTerm()
  else
    autocmd TermOpen     *       call vis#statusline#VisSetStatuslineForTerm()
    autocmd TermOpen     *       startinsert
    autocmd BufWinEnter,WinEnter term://* startinsert
  endif
augroup END

augroup ag_ide_bmk
  autocmd!
  autocmd FileType bmk           call vis#statusline#VisSetStatuslineForSideBar()
augroup END

augroup ag_ide_fern
  autocmd!
  autocmd FileType fern          call glyph_palette#apply()
  autocmd FileType fern          call vis#statusline#VisSetStatuslineForSideBar()
  autocmd FileType fern          call vis#external#fern#VisFernMap()
  autocmd User     FernSyntax    call vis#external#fern#VisFernSyntax()
  autocmd User     FernHighlight call vis#external#fern#VisFernHighlight()
augroup END

augroup ag_ide_nerdtree
  autocmd!
  autocmd FileType nerdtree      call vis#external#nerdtree#VisNERDTreeMap()
augroup END

augroup ag_ide_fugitive
  autocmd!
  autocmd FileType fugitive      call vis#external#fugitive#VisFugitiveMap()
augroup END

call vis#VisInit()
