set shell=/bin/bash

" Vundle setup and initialize
set nocompatible 
filetype off
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()
Plugin 'VundleVim/Vundle.vim'
Plugin 'blueshirts/darcula'
Plugin 'tpope/vim-surround'
Plugin 'easymotion/vim-easymotion'

call vundle#end()

" Color Theme : Solarized
colorscheme darcula
set t_Co=256

set rnu " show relative line number
set nocompatible " disable back compatible mode for vi
set hidden " don't close unsaved buffers
"set spell " enable spell checking
"set spelllang=en "set spell checking language
set cursorline " highlights cursor line
set cursorcolumn " highlights cursor column
" enable soft wrap
set formatoptions=1
"set lbr
" enable syntax highlighting 
syntax on
filetype on
filetype plugin on
" enable auto indent
filetype indent on
filetype plugin indent on
set autoindent
set copyindent
set smartindent

set showcmd " show command in status line
set showmatch " show matching brackets
set ignorecase " enable case insensitive search
set smartcase
set incsearch " start search while writing
set hlsearch " highlights search

set noswapfile
set nobackup
set nowb
set backspace=indent,eol,start
set shiftwidth=4
set softtabstop=4
set tabstop=4
set mouse=a "turn on mouse
set encoding=utf-8
set laststatus=2

let mapleader="\<Space>"
let g:EasyMotion_smartcase = 1

map  f <Plug>(easymotion-bd-f)
nmap f <Plug>(easymotion-overwin-f)

let g:EasyMotion_startofline = 0 " keep cursor column when JK motion

" move by screen lines instead of real lines
nnoremap j gj
nnoremap k gk

" reformat file
noremap = mggg=G`gzz

" repeatable fix indent of selected fragment
vnoremap < <gv
vnoremap > >gv

" Selection
noremap <Leader>a ggVG

" fast escape to normal mode
inoremap jj <Esc>

" fix fast typing typos 
command W w
command WQ wq
command Wq wq
command Q q

" Yeld/Past to system buffer
vnoremap <C-S-y> "*y
nnoremap <C-S-y> V"*y
noremap <C-S-p> "*p
inoremap <C-S-p> <Esc>"*pa

