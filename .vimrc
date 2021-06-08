call plug#begin('~/.vim/plugged')

Plug 'liuchengxu/space-vim-dark'
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
Plug 'vim-syntastic/syntastic'
Plug 'scrooloose/nerdtree'
Plug 'pandark/42header.vim'
Plug 'othree/vim-autocomplpop'
Plug 'vim-scripts/L9'
Plug 'tikhomirov/vim-glsl'
Plug 'gcmt/taboo.vim'

call plug#end()

colorscheme space-vim-dark
let g:airline_theme='deus'

" status line
set laststatus=2                 " always display the status line
set shortmess=atI                " short messages to avoid scrolling
set ruler                        " show the cursor position all the time
set showcmd                      " display incomplete commands

"Set number line
set number

"AutoIndent
set autoindent      "Keep indentation from previous line

" for insert mode
inoremap <S-Tab> <C-d>

"for visual mode
vnoremap <Tab> >gV
vnoremap <S-Tab> <gV

"Show all command
set showcmd
set showmode

"Show Title
set title
set titleold=

"Hightlight line cursor
set cursorline

set novisualbell

"Speed Redraw
set lazyredraw
set wildmenu                            " Use wildmenu auto completion
set wildmode=list:longest       " Set options for auto completion
set complete=.,w,b,t,u
set showfulltag                         " Show whole tag, not just function name, when
" autocompleting by tag
"One clipboard
set clipboard=unnamed

"Set mouse
set mouse=a

"AutoCompletMenu
set completeopt=longest,menuone

"Syntastic
let g:syntastic_check_on_open = 1
let g:syntastic_check_on_wq = 0
let g:syntastic_c_config_file = '.syntastic_c_config'
let g:syntastic_c_compiler_options = '-Werror -Wextra -Wall'

"NerdTree
map <C-g> :NERDTreeToggle<CR>
autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTree") && b:NERDTree.isTabTree()) | q | endi
autocmd BufEnter * lcd %:p:h

nmap <f1> :FortyTwoHeader<CR>
set backspace=2
nmap <bs> <bs>

filetype plugin indent on
" show existing tab with 4 spaces width
set tabstop=4
set noexpandtab
" when indenting with '>', use 4 spaces width
set shiftwidth=4
set softtabstop=4
set smartindent
set cindent


" Search settings.
" Highlight search results.
set hlsearch
" Incremental search: find as you type.
set incsearch


" Tab utils
nnoremap <tab><Up> :tabedit<cr>
nnoremap <tab><Right> :tabnext<cr>
nnoremap <tab><Left> :tabprevious<cr>

" The Gray Colomn of Death
set cc=80
highlight ColorColumn ctermbg=0*

highlight NERDTreeUp ctermfg=6
highlight NERDTreeDir ctermfg=6
highlight NERDTreeDirSlash ctermfg=6

highlight VertSplit ctermfg=0

syntax on

set showtabline=2

let g:taboo_tab_format="  %f  "

augroup project
	autocmd!
	autocmd BufRead,BufNewFile *.h,*.c set filetype=c
augroup END

set directory^=$HOME/.vim/tmp//

" help for generating C++ file

function! s:insert_gates()
  let gatename = substitute(toupper(expand("%:t")), "\\.", "_", "g")
  execute "normal! i#ifndef " . gatename
  execute "normal! o# define " . gatename . "\n"
  execute "normal! o#endif"
  execute "normal! kO\n"
endfunction

function! s:insert_class()
  let gatename = substitute(expand("%:r"), "\\.class", "", "g")
  execute "normal! iclass " . gatename
  execute "normal! o{"
  execute "normal! opublic:"
  execute "normal! o\t" . gatename . "(void);"
  execute "normal! o\t" . gatename . "(const " . gatename . " & src);"
  execute "normal! o\tvirtual\t~" . gatename . "();"
  execute "normal! o"
  execute "normal! o\t" . gatename . " &\toperator=(const " . gatename . " & rhs);"
  execute "normal! oprivate:"
  execute "normal! o};"
endfunction

augroup CFile
	autocmd!
	autocmd BufNewFile *.h call <SID>insert_gates()
	autocmd BufNewFile *.hpp call <SID>insert_gates()
	autocmd BufNewFile *.hpp call <SID>insert_class()
augroup END

" Comments for C++
iabbrev <c>		/*<enter><space>Constructors/Desctructors<enter>/
iabbrev <o>		/*<enter><space>Operators<enter>/
iabbrev <a>		/*<enter><space>Accessors<enter>/
iabbrev <u>		/*<enter><space>Utilities<enter>/
iabbrev <e>		/*<enter><space>Exception<enter>/
iabbrev <s>		/*<enter><space>Static<enter>/
