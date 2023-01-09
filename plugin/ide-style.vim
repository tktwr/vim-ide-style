if exists("g:loaded_vis")
  finish
endif
let g:loaded_vis = 1

call vis#init()

"------------------------------------------------------
" command for ide
"------------------------------------------------------
command                         VisIDE            call vis#ide()
command                         VisRedraw         call vis#redraw()

"------------------------------------------------------
" command for buffer
"------------------------------------------------------
command                         VisBufDelete      call vis#buffer#delete()
command -nargs=1                Wx                call vis#buffer#exchange(<f-args>)
command -nargs=1                Wc                call vis#buffer#copy(<f-args>)

"------------------------------------------------------
" command for window
"------------------------------------------------------
command -nargs=1                VisWinResize      call vis#window#resize(<f-args>)
command -nargs=1                VisWinVResize     call vis#window#vresize(<f-args>)

func VisWinMaximizeXToggle(max_width)
  call vis#window#maximize_x_toggle(a:max_width)
endfunc

func VisWinMaximizeYToggle(max_height)
  call vis#window#maximize_y_toggle(a:max_height)
endfunc

func VisWinMaximizeXYToggle(max_width, max_height)
  call vis#window#maximize_xy_toggle(a:max_width, a:max_height)
endfunc

"------------------------------------------------------
" command for sidebar
"------------------------------------------------------
command                         VisSideBarToggle  call vis#sidebar#toggle()

"------------------------------------------------------
" command for diff
"------------------------------------------------------
command -nargs=+ -complete=file VisTabDiff        call vis#internal#diff#tab_open(<f-args>)

func VisTabDiff(file1, file2)
  call vis#internal#diff#tab_open(a:file1, a:file2)
endfunc

"------------------------------------------------------
" command for tab
"------------------------------------------------------
command                         VisTabClosePrev   call vis#tab#close_prev()

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
command -nargs=?                VisTerm            call vis#term#open(<f-args>)
command -nargs=0                VisTermV           call vis#term#vopen()

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
command -nargs=1                VisVResizeT2E     call vis#send#vresize_t2e(<f-args>)
command -nargs=+ -complete=dir  VisSendCdT2T      call vis#send#cd_t2t(<f-args>)
command                         VisSendCdE2T      call vis#send#cd_e2t()

func VisSendCurrCmdE2T()
  call vis#send#cmd_e2t("")
endfunc

"------------------------------------------------------
" command for dirdiff
"------------------------------------------------------
command -nargs=+ -complete=dir  VisTabDirDiff     call vis#external#dirdiff#tab_open(<f-args>)
command                         VisTabDirDiffQuit call vis#external#dirdiff#quit()

func VisTabDirDiff(dir1, dir2)
  call vis#external#dirdiff#tab_open(a:dir1, a:dir2)
endfunc

"------------------------------------------------------
" command for fern
"------------------------------------------------------
command                         VisFernDrawerToggle call vis#external#fern#open_drawer_toggle()
command -nargs=1 -complete=dir  VisFernDrawer       call vis#external#fern#open_drawer(<f-args>)
command -nargs=1 -complete=dir  VisFern             call vis#external#fern#open(<f-args>)

func VisFern(dir, drawer='', toggle='')
  call vis#external#fern#open(a:dir, a:drawer, a:toggle)
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
" command for fugitive
"------------------------------------------------------
command -nargs=1                VisGgrep            call vis#external#fugitive#ggrep(<f-args>)
command                         VisGstatusToggle    call vis#external#fugitive#toggle()

func VisTabGstatusToggle()
  tabedit
  call vis#external#fugitive#toggle()
endfunc

"------------------------------------------------------
" command for gv
"------------------------------------------------------
command                         VisGV               call vis#external#gv#open()

func VisTabGV()
  tabedit
  call vis#external#gv#open()
endfunc

"------------------------------------------------------
" command for quickhl
"------------------------------------------------------
command -nargs=1                VisQuickhl          call vis#external#quickhl#open_prompt(<f-args>)

"------------------------------------------------------
" command for ref
"------------------------------------------------------
command -nargs=+                VisMan              call vis#external#ref#open_prompt("man", <q-args>)
command -nargs=+                VisPydoc            call vis#external#ref#open_prompt("pydoc", <q-args>)

"------------------------------------------------------
" command for help
"------------------------------------------------------
command -nargs=?                VisHelp             call vis#internal#help#open(<f-args>)

"------------------------------------------------------
" command for vimgrep
"------------------------------------------------------
command -nargs=+                VisVimgrep          call vis#internal#vimgrep#open_prompt(<f-args>)

"------------------------------------------------------
" command for tag jump
"------------------------------------------------------
command -nargs=+                VisTjump            call vis#internal#tjump#open(<f-args>)

func VisTjump(tag_name, winnr=0)
  call vis#internal#tjump#open(a:tag_name, a:winnr)
endfunc

func VisTjumpPrompt()
  call vis#internal#tjump#open_prompt()
endfunc

"------------------------------------------------------
" command for util
"------------------------------------------------------
command -nargs=1                VisSetTabstop       call vis#util#set_tabstop(<f-args>)
command                         VisLineNumberToggle call vis#util#line_number_toggle()

command                         VisCheckEnv         call vis#util#check_env()
command -nargs=0                VisWinInfo          call vis#util#win_info()

command                         VisCdHere           exec "cd"  expand("%:p:h")
command                         VisTcdHere          exec "tcd" expand("%:p:h")
command                         VisLcdHere          exec "lcd" expand("%:p:h")

"------------------------------------------------------
" autocmd
"------------------------------------------------------
augroup ag_ide_style
  autocmd!

  if has('nvim')
    autocmd TermOpen      *               call vis#statusline#setup_term()
    autocmd TermOpen      *               startinsert
    autocmd BufWinEnter,WinEnter term://* startinsert
  else
    autocmd TerminalOpen  *               call vis#statusline#setup_term()
  endif

  autocmd QuickFixCmdPost *grep*          below cwindow
  autocmd QuickFixCmdPost *make*          below cwindow
  autocmd WinEnter        *               call vis#map#setup()
  autocmd BufEnter        *               call vis#buffer#lcd_here()
  autocmd FileType        bmk             call vis#statusline#setup_side_bar()
  autocmd FileType        fern            call glyph_palette#apply()
  autocmd FileType        fern            call vis#statusline#setup_side_bar()
  autocmd FileType        fern            call vis#external#fern#map()
  autocmd User            FernSyntax      call vis#external#fern#syntax()
  autocmd User            FernHighlight   call vis#external#fern#highlight()
  autocmd FileType        fugitive        call vis#external#fugitive#map()
  autocmd FileType        git             call vis#external#gv#map()
augroup END

