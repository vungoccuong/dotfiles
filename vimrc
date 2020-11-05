" Leader
let mapleader = " "

set backspace=2   " Backspace deletes like most programs in insert mode
set nobackup
set nowritebackup
set noswapfile
set history=50
set ruler         " show the cursor position all the time
set showcmd       " display incomplete commands
set incsearch     " do incremental searching
set laststatus=2  " Always display the status line
set autowrite     " Automatically :write before running commands

set autoindent
set smartindent

set autoread
set autowrite

" Softtabs, 2 spaces
set tabstop=2
set shiftwidth=2
set shiftround
set expandtab

" Make it obvious where 80 characters is
set textwidth=120
set colorcolumn=+1

" Having longer updatetime (default is 4000 ms = 4 s) leads to noticeable
" delays and poor user experience.
set updatetime=301

" Display extra whitespace
" set list listchars=tab:»·,trail:·,nbsp:·

" Use one space, not two, after punctuation.
set nojoinspaces

" Numbers
set relativenumber
set number
set numberwidth=5

" Open new split panes to right and bottom, which feels more natural
set splitbelow
set splitright

" Autocomplete with dictionary words when spell check is on
set complete+=kspell

" Always use vertical diffs
" catalina not support diffopt=internal
if &diff
    set diffopt-=internal
    set diffopt+=vertical
endif

" Copy to clipboard
"set clipboard=unnamed
set clipboard+=unnamedplus

set lazyredraw
set termguicolors

set background=dark


filetype plugin indent on

" Switch syntax highlighting on, when the terminal has colors
" Also switch on highlighting the last used search pattern.
if (&t_Co > 2 || has("gui_running")) && !exists("syntax_on")
  syntax on
endif

if filereadable(expand("~/.vimrc.bundles"))
  source ~/.vimrc.bundles
endif

colorscheme gruvbox


augroup vimrcEx
  autocmd!
  " When editing a file, always jump to the last known cursor position.
  " Don't do it for commit messages, when the position is invalid, or when
  " inside an event handler (happens when dropping a file on gvim).
  autocmd BufReadPost *
        \ if &ft != 'gitcommit' && line("'\"") > 0 && line("'\"") <= line("$") |
        \   exe "normal g`\"" |
        \ endif
augroup END

" Go file config
au FileType go set noexpandtab
au FileType go set shiftwidth=4
au FileType go set softtabstop=4
au FileType go set tabstop=4

au BufRead,BufNewFile .eslintrc.json setlocal filetype=json
au BufRead,BufNewFile .babelrc setlocal filetype=json
au BufRead,BufNewFile .prettierrc setlocal filetype=json

au BufRead,BufNewFile .babelrc.js setlocal filetype=javascript
au BufRead,BufNewFile .sequelizerc setlocal filetype=javascript
au BufRead,BufNewFile *.hbs setlocal filetype=html

" When the type of shell script is /bin/sh, assume a POSIX-compatible
" shell for syntax highlighting purposes.
let g:is_posix = 1

" Use tab with text block
vmap <Tab> >gv
vmap <S-Tab> <gv

" Get off my lawn
nnoremap <Left> :echoe "Use h"<CR>
nnoremap <Right> :echoe "Use l"<CR>
nnoremap <Up> :echoe "Use k"<CR>
nnoremap <Down> :echoe "Use j"<CR>

nnoremap <Leader>\ :vsplit<CR>
nnoremap <Leader>/ :split<CR>

" Remove highlight
"map <C-h> :nohl<CR>

" NERD tree configuration
noremap <C-d> :NERDTreeToggle<CR>
nnoremap F :NERDTreeFind<CR>

let NERDTreeShowHidden=1

" fzf
noremap ` :Files<CR>
noremap ; :Buffers<CR>

" bind \ (backward slash) to grep shortcut
nnoremap KK :Ag <C-R><C-W><CR>
nnoremap <C-k> /<C-R><C-W><CR>
nnoremap \ :Ag<SPACE>

" coc.vim config
" Remap keys for gotos
nmap <silent> gd <Plug>(coc-definition)
nmap <silent> gy <Plug>(coc-type-definition)
nmap <silent> gi <Plug>(coc-implementation)
nmap <silent> gr <Plug>(coc-references)
"nmap <leader> rn <Plug>(coc-rename)
nmap <F2> <Plug>(coc-rename)

" Use `:Format` to format current buffer
command! -nargs=0 Format :call CocAction('format')

nmap <Leader>f :Format <CR>

" Easymotion
" s{char}{char} to move to {char}{char} over windows
nmap <Leader>F <Plug>(easymotion-overwin-f)
" Move to line over windows
nmap <Leader>L <Plug>(easymotion-overwin-line)
" Search n-chars
map / <Plug>(easymotion-sn)

" Lightline
let g:lightline = {
      \ 'colorscheme': 'seoul256',
      \ 'active': {
      \   'left': [ [ 'mode', 'paste' ],
      \             [ 'gitbranch', 'cocstatus', 'readonly', 'filename', 'modified' ] ],
      \   'right': [ [ 'lineinfo', 'percent' ],
      \              [ 'fileformat', 'fileencoding', 'filetype' ] ]
      \ },
      \ 'separator': { 'left': '', 'right': '' },
      \ 'subseparator': { 'left': '', 'right': '' },
      \ 'component_function': {
      \   'gitbranch': 'fugitive#head',
      \   'cocstatus': 'coc#status'
      \ },
      \ }

" Multi select
let g:multi_cursor_next_key='<C-n>'
let g:multi_cursor_prev_key='<C-p>'
let g:multi_cursor_skip_key='<C-x>'

" fzf.vim
" Customize fzf colors to match your color scheme
let g:fzf_colors =
\ { 'fg':      ['fg', 'Normal'],
  \ 'bg':      ['bg', 'Normal'],
  \ 'hl':      ['fg', 'Comment'],
  \ 'fg+':     ['fg', 'CursorLine', 'CursorColumn', 'Normal'],
  \ 'bg+':     ['bg', 'CursorLine', 'CursorColumn'],
  \ 'hl+':     ['fg', 'Statement'],
  \ 'info':    ['fg', 'PreProc'],
  \ 'border':  ['fg', 'Ignore'],
  \ 'prompt':  ['fg', 'Conditional'],
  \ 'pointer': ['fg', 'Exception'],
  \ 'marker':  ['fg', 'Keyword'],
  \ 'spinner': ['fg', 'Label'],
  \ 'header':  ['fg', 'Comment'] }

" Auto close tag
let g:closetag_filenames = '*.html,*.js,*.jsx,*.vue'
let g:closetag_emptyTags_caseSensitive = 1
let g:jsx_ext_required = 0

" Local config
if filereadable($HOME . "/.vimrc.local")
  source ~/.vimrc.local
endif


let g:go_metalinter_autosave=1
let g:go_metalinter_autosave_enabled=['vet', 'golint']
let g:go_metalinter_deadline = "10s"
let g:go_def_mode='gopls'
let g:go_info_mode='gopls'
" use go imports when saving file
let g:go_fmt_command = "goimports"
" coloring syntax
let g:go_highlight_types = 1
let g:no_highlight_fields = 1
let g:go_highlight_functions = 1
let g:go_highlight_function_calls = 1
let g:go_highlight_operators = 1
let g:go_highlight_extra_types = 1
"auto open nerdtree when vim startup on open directory
autocmd StdinReadPre * let s:std_in=1
autocmd VimEnter * if argc() == 1 && isdirectory(argv()[0]) && !exists("s:std_in") | exe 'NERDTree' argv()[0] | wincmd p | ene | exe 'cd '.argv()[0] | endif
"auto close nerdtree if the only nerdtree window is open
autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTree") && b:NERDTree.isTabTree()) | q | endif

let g:coc_global_extensions = [
      \ 'coc-tsserver',
      \ 'coc-pairs',
      \ 'coc-go',
      \ 'coc-json',
      \ 'coc-css',
      \ 'coc-prettier',
      \ 'coc-snippets'
      \]
" autocomplete css
autocmd FileType css set omnifunc=csscomplete#CompleteCSS
autocmd BufEnter *.{js,jsx,ts,tsx} :syntax sync fromstart
autocmd BufLeave *.{js,jsx,ts,tsx} :syntax sync clear

nnoremap Gr :GoRun <CR>
" save and reload buffer
nnoremap <Leader>e :w \| :e <CR>
nmap <F8> :TagbarToggle<CR>

let g:rainbow_active = 1

let g:rainbow_load_separately = [
    \ [ '*' , [['(', ')'], ['\[', '\]'], ['{', '}']] ],
    \ [ '*.tex' , [['(', ')'], ['\[', '\]']] ],
    \ [ '*.cpp' , [['(', ')'], ['\[', '\]'], ['{', '}']] ],
    \ [ '*.{html,htm}' , [['(', ')'], ['\[', '\]'], ['{', '}'], ['<\a[^>]*>', '</[^>]*>']] ],
    \ ]

