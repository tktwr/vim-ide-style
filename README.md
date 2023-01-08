# vim-ide-style

vim-ide-style is a helper plugin for ide-style window management.

Requirements: Vim >= 8.1 or Neovim >= 0.7.0 (limited functionalities)

## Install

Install plugins using a plugin manager such as
[vim-plug](https://github.com/junegunn/vim-plug).

vim-ide-style is intended for use with
[fern](https://github.com/lambdalisue/fern.vim).
~~~
Plug 'lambdalisue/fern.vim'
Plug 'lambdalisue/nerdfont.vim'
Plug 'lambdalisue/fern-renderer-nerdfont.vim'
Plug 'lambdalisue/glyph-palette.vim'
let g:fern#disable_default_mappings = 1
let g:fern#renderer = 'nerdfont'
~~~

Install
[vim-popup-menu](https://github.com/Ajnasz/vim-popup-menu)
to support a popup menu in neovim.
~~~
if has('nvim')
  Plug 'Ajnasz/vim-popup-menu'
endif
~~~

vim-ide-style is supposed to be used with
[vim-winbuf-menu](https://github.com/tktwr/vim-winbuf-menu) and
[vim-bmk-menu](https://github.com/tktwr/vim-bmk-menu).
~~~
Plug 'tktwr/vim-winbuf-menu'
Plug 'tktwr/vim-bmk-menu'
Plug 'tktwr/vim-ide-style'
~~~

## bashrc

~~~
source ~/.vim/plugged/vim-ide-style/etc/bashrc
source ~/.vim/plugged/vim-ide-style/etc/bashrc.alias
~~~

## Command

~~~
:VisIDE
~~~

