" --------------------------------------------------------------------------------------------
"  BASIC SETTING
" --------------------------------------------------------------------------------------------
set nocompatible		" Enable Vi IMproved enhancements
set backspace=indent,eol,start  " Make backspace key work the way it should

syntax on			" Turn syntax highlighting on by default
filetype indent on		" Detect type of file and load its indent file

set autoindent			" Enable autoindentation

set hlsearch			" Highlight searched word
set incsearch			" Allow incremental searching
set ignorecase          	" Ignore case when searching
set smartcase           	" No ignorecase if uppercase char present

set showcmd			" Show typed commands (e.g. `yiw`)

set belloff=all			" Turn off error beeps

set number
set numberwidth=2
set relativenumber

" highlight current line number, dim relative line numbers
set cursorline
hi! link CursorLine Normal
hi my_bg guibg=#000000
hi my_bg_cursor guifg=#fabd2f guibg=#3c3836
hi! link LineNr my_bg
hi! link CursorLineNr my_bg_cursor
highlight LineNr ctermfg=grey ctermbg=black

" set powerline color theme
let g:airline_theme='deus'

" screen splitting
set splitbelow
set splitright

"split navigations
nnoremap <C-J> <C-W><C-J>
nnoremap <C-K> <C-W><C-K>
nnoremap <C-L> <C-W><C-L>
nnoremap <C-H> <C-W><C-H>

" center cursor after moving half-page down/up
" nnoremap <C-d> <C-d>zz
" nnoremap <C-u> <C-u>zz

" center cursor when searching
nnoremap n nzz
nnoremap N Nzz

" make Y behave like D and C
nnoremap Y y$

" Change cursor between Normal and Insert modes
" https://stackoverflow.com/questions/6488683/how-to-change-the-cursor-between-normal-and-insert-modes-in-vim
let &t_SI = "\<Esc>]50;CursorShape=1\x7"
let &t_SR = "\<Esc>]50;CursorShape=2\x7"
let &t_EI = "\<Esc>]50;CursorShape=0\x7"
set ttimeout
set ttimeoutlen=1
set ttyfast

" --------------------------------------------------------------------------------------------
"  PYTHON
" --------------------------------------------------------------------------------------------
autocmd Filetype python set
     \ tabstop=4
     \ softtabstop=4
     \ shiftwidth=4
     \ textwidth=120
     \ formatoptions=q
     \ expandtab
     \ autoindent
     \ fileformat=unix
     \ encoding=utf-8

autocmd FileType python map <buffer> <F9> :w<CR>:exec '!python3' shellescape(@%, 1)<CR>
autocmd FileType python imap <buffer> <F9> <esc>:w<CR>:exec '!python3' shellescape(@%, 1)<CR>

" --------------------------------------------------------------------------------------------
"  PLUGINS (install via :PlugInstall)
" --------------------------------------------------------------------------------------------

" Automatically install `vim-plug`
let data_dir = has('nvim') ? stdpath('data') . '/site' : '~/.vim'
if empty(glob(data_dir . '/autoload/plug.vim'))
  silent execute '!curl -fLo '.data_dir.'/autoload/plug.vim --create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim'
  autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
endif

" Specify plugins
call plug#begin('~/.vim/plugged')
  Plug 'davidhalter/jedi-vim'  " Python auto-completion
  Plug 'itchyny/vim-cursorword'  " underline word under cursor
  Plug 'machakann/vim-highlightedyank'  " highlight yanked text (not needed in neovim)
  Plug 'tpope/vim-commentary'  " `gcc` commenting command
  Plug 'tpope/vim-fugitive'  " git integration
  Plug 'tpope/vim-repeat'  " enable `.` command after a plugin map
  Plug 'tpope/vim-surround'  " `cs([`, `ysiw'`, etc. surrounding commands
  Plug 'vim-airline/vim-airline'  " powerline
  Plug 'vim-airline/vim-airline-themes'  " powerline color theme
  Plug 'vim-scripts/indentpython.vim'  " PEP8 compliant indentation (autoindent does not always work)
call plug#end()
