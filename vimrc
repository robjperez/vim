" Vundle configuration ----------------------------------------------

set nocompatible              " be iMproved, required
filetype off                  " required

" set the runtime path to include Vundle and initialize
set rtp+=~/.vim/bundle/Vundle.vim
if has('win32') || has('win64')
  set rtp+=~/vimfiles/bundle/Vundle.vim
endif

call vundle#begin()
" alternatively, pass a path where Vundle should install plugins
"call vundle#begin('~/some/path/here')

" let Vundle manage Vundle, required
Plugin 'VundleVim/Vundle.vim'

" All of your Plugins must be added before the following line
" Mis plugins

Plugin 'tpope/vim-fugitive'
Plugin 'vim-airline/vim-airline'
Plugin 'ctrlpvim/ctrlp.vim'


call vundle#end()            " required
filetype plugin indent on    " required
" To ignore plugin indent changes, instead use:
"filetype plugin on
"
" Brief help
" :PluginList       - lists configured plugins
" :PluginInstall    - installs plugins; append `!` to update or just :PluginUpdate
" :PluginSearch foo - searches for foo; append `!` to refresh local cache
" :PluginClean      - confirms removal of unused plugins; append `!` to auto-approve removal
"
" see :h vundle for more details or wiki for FAQ
" Put your non-Plugin stuff after this line
"
" -------------------------------------------------------------------

function! s:ConfigureFont()
  if has("gui_running")
    if has("gui_gtk3")
      set guifont=Fira\ Code\ 12
      colorscheme evening
    endif
    if has("gui_macvim")
      set guifont=Fira\ Code:h12
      colorscheme macvim
    endif
    if has("win32") || has("win64")
      set guifont=Fira\ Code:h12
      colorscheme evening
    endif
    set linespace=2
  endif
endfunction

function! s:ConfigureEditorSettings()
  set nu " Set line numbers
  set tabstop=2
  set showmatch " Show matching brackets
  set mat=5 " Show bracket blinking

  " Set tab to use 2 spaces
  set expandtab " Use spaces instead of TABS to indent
  set tabstop=2 " Show tabs as 2 spaces
  set softtabstop=2
  set shiftwidth=2 "When using > to indent use 2 spaces

  set noeb vb t_vb= "No error bells

  if has("win32") || has("win64")
    set backspace=indent,eol,start
    set guioptions=
    autocmd GUIEnter * set vb t_vb= "Only on windows
  endif

  " Trim spaces on save
  autocmd BufWritePre *.* %s/\s\+$//e
endfunction

function! s:ConfigureVisualElements()
  set fillchars+=vert:\ "Set vertical split bar theme

  " These two lines does not work in this file. Investigate
  hi VertSplit guifg=fg guibg=bg
  hi EndOfBuffer guifg=bg " hide ~ chars at the end of the buffer
endfunction

function! s:ConfigureFileExplorer()
  let g:netrw_banner = 0
  let g:netrw_liststyle = 3
  let g:netrw_browse_split = 4
  let g:netrw_altv = 1
  let g:netrw_winsize = 25
endfunction

" ----------------
call s:ConfigureFont()
call s:ConfigureEditorSettings()
call s:ConfigureFileExplorer()
call s:ConfigureVisualElements()
