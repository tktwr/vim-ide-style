# vim-ide-style

vim-ide-style is a helper plugin for ide-style window management.

## Install

vim-ide-style is intended for use with
[fern](https://github.com/lambdalisue/fern.vim).

For vim-plug, install the fern plugin as follows.
~~~
Plug 'lambdalisue/fern.vim'
Plug 'lambdalisue/nerdfont.vim'
Plug 'lambdalisue/fern-renderer-nerdfont.vim'
Plug 'lambdalisue/glyph-palette.vim'
let g:fern#disable_default_mappings = 1
let g:fern#renderer = 'nerdfont'
~~~

vim-ide-style is supposed to be used with
[vim-winbuf-menu](https://github.com/tktwr/vim-winbuf-menu) and
[vim-bmk-menu](https://github.com/tktwr/vim-bmk-menu).

For vim-plug, install the vim-ide-style plugin as follows.
~~~
Plug 'tktwr/vim-winbuf-menu'
Plug 'tktwr/vim-bmk-menu'
Plug 'tktwr/vim-ide-style'
~~~

## bashrc

~~~
export MY_VIM_BMK="$MY_VIM/plugged/vim-bmk-menu"
export MY_VIM_IDE="$MY_VIM/plugged/vim-ide-style"
export PATH="$MY_VIM_IDE/bin:$MY_VIM_BMK/bin:$PATH"
source $MY_VIM_IDE/etc/bashrc
~~~

## Command

~~~
:VisIDE
~~~

