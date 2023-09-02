if exists("g:loaded_vis")
  finish
endif
let g:loaded_vis = 1

call vis#init()

"------------------------------------------------------
" functions
"------------------------------------------------------
func VisWinMaximizeXToggle(max_width)
  call vis#window#maximize_x_toggle(a:max_width)
endfunc

func VisWinMaximizeYToggle(max_height)
  call vis#window#maximize_y_toggle(a:max_height)
endfunc

func VisWinMaximizeXYToggle(max_width, max_height)
  call vis#window#maximize_xy_toggle(a:max_width, a:max_height)
endfunc

func VisFern(dir, drawer='', toggle='')
  call vis#external#fern#open(a:dir, a:drawer, a:toggle)
endfunc

func VisFernOpenItem()
  call vis#external#fern#VisFernOpenItem()
endfunc

func VisFernViewItem()
  call vis#external#fern#VisFernViewItem()
endfunc

func VisFernSaveItem()
  call vis#external#fern#VisFernSaveItem()
endfunc

func VisTjump(tag_name, winnr=0)
  call vis#internal#tjump#open(a:tag_name, a:winnr)
endfunc

func VisTjumpPrompt()
  call vis#internal#tjump#open_prompt()
endfunc

"------------------------------------------------------
" functions: tab
"------------------------------------------------------
func VisTabEdit()
  tabedit
  tcd
endfunc

func VisTabGS()
  tabedit
  call vis#external#fugitive#toggle()
endfunc

func VisTabGV()
  tabedit
  call vis#external#gv#open()
endfunc

func VisTabDiff(file1, file2)
  call vis#internal#diff#open(a:file1, a:file2)
endfunc

func VisTabDirDiff(dir1, dir2)
  call vis#external#dirdiff#open(a:dir1, a:dir2)
endfunc

"------------------------------------------------------
" functions: Tapi
"------------------------------------------------------
func Tapi_Exec(bufnr, cmdline)
  call vis#term#Tapi_Exec(a:bufnr, a:cmdline)
endfunc

func Tapi_ExecInPrevWin(bufnr, cmdline)
  wincmd p
  call vis#term#Tapi_Exec(a:bufnr, a:cmdline)
endfunc

func Tapi_ExecInAboveWin(bufnr, cmdline)
  wincmd k
  call vis#term#Tapi_Exec(a:bufnr, a:cmdline)
endfunc

func Tapi_ExecInNewTab(bufnr, cmdline)
  tabedit
  call vis#term#Tapi_Exec(a:bufnr, a:cmdline)
endfunc

func Tapi_ExecEcho(bufnr, cmdline)
  call vis#term#Tapi_ExecEcho(a:bufnr, a:cmdline)
endfunc

"------------------------------------------------------
" commands
"------------------------------------------------------
command                         VisCdHere           exec "cd"  expand("%:p:h")
command                         VisTcdHere          exec "tcd" expand("%:p:h")
command                         VisLcdHere          exec "lcd" expand("%:p:h")
command                         VisModifiable       call vis#buffer#modifiable()
"------------------------------------------------------
command                         VisIDE              call vis#ide()
command                         VisRedraw           call vis#redraw()
command                         VisSideBarToggle    call vis#sidebar#toggle()
command                         VisTagbarToggle     TagbarToggle
command                         VisTerm             call vis#term#open(<q-mods>)
command                         VisTermV            call vis#term#vopen(<q-mods>)
"------------------------------------------------------
command                         VisBufDelete        call vis#buffer#delete()
command -nargs=1                Wx                  call vis#buffer#exchange(<f-args>)
command -nargs=1                Wc                  call vis#buffer#copy(<f-args>)

command -nargs=?                VisWinResize        call vis#window#resize(<f-args>)
command -nargs=?                VisWinVResize       call vis#window#vresize(<f-args>)
command                         VisQuickFix         call vis#window#qf()

command VisWinMaximizeXYToggle      call VisWinMaximizeXYToggle(g:vis_winwidth_max, "")
command VisWinMaximizeXToggle       call VisWinMaximizeXToggle(g:vis_winwidth_max)
command VisWinMaximizeYToggle       call VisWinMaximizeYToggle("")

command VisWinMaximizeXYToggleTerm  call VisWinMaximizeXYToggle(g:vis_winwidth_max, g:vis_term_winheight_max)
command VisWinMaximizeXToggleTerm   call VisWinMaximizeXToggle(g:vis_winwidth_max)
command VisWinMaximizeYToggleTerm   call VisWinMaximizeYToggle(g:vis_term_winheight_max)

command                         VisSendCdE2T        call vis#send#cd_e2t()
command                         VisSendCmdE2T       call vis#send#cmd_e2t()
"------------------------------------------------------
command -nargs=1                VisSetTabstop       call vis#util#set_tabstop(<f-args>)
command                         VisLineNumberToggle call vis#util#line_number_toggle()

command                         VisCheckEnv         call vis#util#check_env()
command                         VisWinInfo          call vis#util#win_info()
"------------------------------------------------------
command                         VisFernDrawerToggle call vis#external#fern#open_drawer_toggle()
command -nargs=1 -complete=dir  VisFernDrawer       call vis#external#fern#open_drawer(<f-args>)
command -nargs=1 -complete=dir  VisFern             call vis#external#fern#open(<f-args>)

command                         VisFzfBmk           call vis#external#fzf#bmk()
command                         VisFzfAll           call vis#external#fzf#fd('',  'BmkEditFile')
command                         VisFzfFiles         call vis#external#fzf#fd('f', 'BmkEditFile')
command                         VisFzfDirs          call vis#external#fzf#fd('d', 'BmkEditDir')
command                         VisFzfRg            call vis#external#fzf#rg('<cfile>')
command                         VisFzfTags          call vis#external#fzf#tags('<cfile>')
command                         VisFzfMemo          call vis#external#fzf#tags('memo: | sample: | bmk: ')

command -nargs=?                VisLazygit          call vis#shell#open('Lazygit', ['lazygit.sh'],  <f-args>)
command -nargs=?                VisFzfMan           call vis#shell#open('Man',     ['fzf_man.sh'],  <f-args>)
command -nargs=?                VisFzfApt           call vis#shell#open('Apt',     ['fzf_apt.sh'],  <f-args>)
command -nargs=?                VisFzfPip           call vis#shell#open('Pip',     ['fzf_pip.sh'],  <f-args>)
command -nargs=?                VisFzfDpkg          call vis#shell#open('Dpkg',    ['fzf_dpkg.sh'], <f-args>)

command                         VisGS               call vis#external#fugitive#toggle()
command                         VisGV               call vis#external#gv#open()

command -nargs=+                VisMan              call vis#external#ref#open_prompt("man", <q-args>)
command -nargs=+                VisPydoc            call vis#external#ref#open_prompt("pydoc", <q-args>)
command -nargs=?                VisHelp             call vis#internal#help#open(<f-args>)
"------------------------------------------------------
command -nargs=1                VisQuickhl          call vis#external#quickhl#open_prompt(<f-args>)
command -nargs=1                VisGgrep            call vis#external#fugitive#ggrep(<f-args>)
command -nargs=+                VisVimgrep          call vis#internal#vimgrep#open_prompt(<f-args>)
command -nargs=+                VisTjump            call vis#internal#tjump#open(<f-args>)
"------------------------------------------------------
" commands: tab
"------------------------------------------------------
command -nargs=+ -complete=file VisTabDiff          call VisTabDiff(<f-args>)
command -nargs=+ -complete=dir  VisTabDirDiff       call VisTabDirDiff(<f-args>)
command                         VisTabDirDiffQuit   call vis#external#dirdiff#quit()
command                         VisTabClosePrev     call vis#tab#close_prev()
"------------------------------------------------------
" commands: statusline/tabline
"------------------------------------------------------
command -nargs=1                VisTabLineSetLabel           call vis#tabline#set_label(<f-args>)
command -nargs=1                VisTabLineSetInfo            call vis#tabline#set_info(<f-args>)
command -nargs=1                VisStatuslineForTermSetLabel call vis#statusline#set_label(<f-args>)
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

  " statusline
  autocmd FileType        bmk             call vis#statusline#setup_side_bar()
  autocmd FileType        fern            call vis#statusline#setup_side_bar()
	autocmd User            CocStatusChange redrawstatus

  " map
  autocmd WinEnter        *               call vis#map#setup()
  autocmd FileType        fern            call vis#external#fern#map()
  autocmd FileType        fugitive        call vis#external#fugitive#map()
  autocmd FileType        git             call vis#external#gv#map()

  autocmd QuickFixCmdPost *grep*          below cwindow
  autocmd QuickFixCmdPost *make*          below cwindow
  autocmd QuickFixCmdPost *Quickfix*      below cwindow

  autocmd FileType        fern            call glyph_palette#apply()

  autocmd BufEnter        *               call vis#buffer#lcd_here()
augroup END
