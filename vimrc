let mapleader=" " "Map leader ASAP so it does not interfere with other things

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
Plugin 'airblade/vim-gitgutter'
Plugin 'neoclide/coc.nvim'
Plugin 'vim-airline/vim-airline-themes'
Plugin 'rafi/awesome-vim-colorschemes'
Plugin 'jremmen/vim-ripgrep'

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
      colorscheme atom
    endif
    if has("gui_macvim")
      set guifont=Iosevka:h13
      colorscheme atom
    endif
    if has("win32") || has("win64")
      set guifont=Fira\ Code:h12
      colorscheme desert
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

  syntax on
  set hlsearch "Highlight search result
  set incsearch "Incremental searching

  if has("win32") || has("win64")
    set backspace=indent,eol,start
    set guioptions=
    autocmd GUIEnter * set vb t_vb= "Only on windows
  elseif has("gui_gtk3")
    set guioptions=r "Just right scroll bar
  endif

  let g:airline_theme='violet'
  let g:airline_powerline_fonts=1

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

function! s:ConfigureRemaps()
  nnoremap <Leader>p :bn<cr>
  nnoremap <Leader>o :bp<cr>
  nnoremap <Leader>x :bd<cr>
  nnoremap <S-Left> :tabprevious<cr>
  nnoremap <S-Right> :tabnext<cr>
  nnoremap ; :
  inoremap <C-s> <C-o>:w<cr>
  nnoremap <C-s> :w<cr>
  nnoremap \ :Rg<Space>
endfunction

function! s:ConfigureCommands()
  command Bd bp\|bd \# "Close buffer without closing the split
endfunction

function! s:ConfigureCocNvim()
  " You will have bad experience for diagnostic messages when it's default 4000.
  set updatetime=300

  " don't give |ins-completion-menu| messages.
  set shortmess+=c

  " Use tab for trigger completion with characters ahead and navigate.
  " Use command ':verbose imap <tab>' to make sure tab is not mapped by other plugin.
  inoremap <silent><expr> <TAB>
        \ pumvisible() ? "\<C-n>" :
        \ <SID>check_back_space() ? "\<TAB>" :
        \ coc#refresh()
  inoremap <expr><S-TAB> pumvisible() ? "\<C-p>" : "\<C-h>"

  function! s:check_back_space() abort
    let col = col('.') - 1
    return !col || getline('.')[col - 1]  =~# '\s'
  endfunction

  " Use <c-space> to trigger completion.
  inoremap <silent><expr> <c-space> coc#refresh()

  " Use <cr> to confirm completion, `<C-g>u` means break undo chain at current position.
  " Coc only does snippet and additional edit on confirm.
  inoremap <expr> <cr> pumvisible() ? "\<C-y>" : "\<C-g>u\<CR>"

  " Use `<space>c` to navigate diagnostics
  nmap <silent> <Leader>c <Plug>(coc-diagnostic-next)

  " Remap keys for gotos
  nmap <silent> gd <Plug>(coc-definition)
  nmap <silent> gy <Plug>(coc-type-definition)
  nmap <silent> gi <Plug>(coc-implementation)
  nmap <silent> gr <Plug>(coc-references)
  " Highlight symbol under cursor on CursorHold
  autocmd CursorHold * silent call CocActionAsync('highlight')

  set statusline^=%{coc#status()}%{get(b:,'coc_current_function','')}

  " Using CocList
  " Show all diagnostics
  nnoremap <silent> ca  :<C-u>CocList diagnostics<cr>
  " Manage extensions
  nnoremap <silent> ce  :<C-u>CocList extensions<cr>
  " Show commands
  nnoremap <silent> cc  :<C-u>CocList commands<cr>
  " Find symbol of current document
  nnoremap <silent> co  :<C-u>CocList outline<cr>
  " Search workspace symbols
  nnoremap <silent> cs  :<C-u>CocList -I symbols<cr>
  " Do default action for next item.
  nnoremap <silent> cj  :<C-u>CocNext<CR>
  " Do default action for previous item.
  nnoremap <silent> ck  :<C-u>CocPrev<CR>
  " Resume latest coc list
  nnoremap <silent> cp  :<C-u>CocListResume<CR>
endfunction

" ----------------
call s:ConfigureFont()
call s:ConfigureEditorSettings()
call s:ConfigureFileExplorer()
call s:ConfigureVisualElements()
call s:ConfigureRemaps()
call s:ConfigureCocNvim()
call s:ConfigureCommands()
