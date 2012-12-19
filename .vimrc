syntax enable
colorscheme slate

" Show line numbers
set number
highlight LineNr term=bold cterm=NONE ctermfg=DarkGrey ctermbg=NONE gui=NONE guifg=DarkGrey guibg=NONE

" Show whitespaces
set list listchars=tab:\|\ 
highlight Whitespace cterm=underline gui=underline ctermbg=NONE guibg=NONE ctermfg=grey guifg=grey
autocmd ColorScheme * highlight Whitespace gui=underline ctermbg=NONE guibg=NONE ctermfg=grey guifg=grey
match Whitespace /  \+/

" Paste copied text without auto-formatting
set paste

" Enable mouse scrolling

" General options
set mouse=a
set linebreak
set showcmd
set ruler
set showmatch
set showtabline=2
set title
set titlestring=%t%(\ %m%)%(\ %r%)%(\ %h%)%(\ %w%)%(\ (%{expand(\»%:p:~:h\»)})%)\ -\ VIM
set statusline=%<%f%h%m%r%=format=%{&fileformat}\ file=%{&fileencoding}\ enc=%{&encoding}\ %b\ 0x%B\ %l,%c%V\ %P
"set statusline=%F%m%r%h%w\ [%{&ff}]\ %=\ %l,%v\ %P
set visualbell
set hidden
set t_Co=256
set cursorline
set autoread
set completeopt=longest,menuone
set nocp
set redraw
set showcmd
set laststatus=2

" Set a latin keyboard layout by default
set iminsert=0
set imsearch=0

"Search
set ignorecase
set nowrapscan
set hlsearch
set smartcase
set incsearch
set imsearch=-1
set history=128
set undolevels=1000
set infercase


"Encoding
set encoding=utf-8
set termencoding=utf-8
set fileformat=unix
set ffs=mac,unix,dos
set fileencodings=utf-8,koi8-r,cp1251


" Enable russian layout
set iskeyword=@,48-57,_,192-255

"set guifont=courier_new:h10:cRUSSIAN


" Set tabulation
"set ts=4
set tabstop=4
set softtabstop=4
set smarttab
set expandtab
set smartindent
set autoindent
set shiftwidth=4
set backspace=indent,eol,start
set noet|retab!


" save file
imap <F2> <Esc>:w<CR>
map <F2> <Esc>:w<CR>


" open new tab
imap <F4> <Esc>:browse tabnew<CR> 
map <F4> <Esc>:browse tabnew<CR>


" close vim
set wildmenu
set wcm=<Tab>
menu Exit.quit     :quit<CR>
menu Exit.quit!    :quit!<CR>
menu Exit.save     :exit<CR>
map <F10> :emenu Exit.<Tab>


" enable russian keys

" window / linux
" set langmap=ёйцукенгшщзхъфывапролджэячсмитьбю;`qwertyuiop[]asdfghjkl\;'zxcvbnm\,.,ЙЦУКЕHГШЩЗХЪФЫВjАПРОЛДЖЭЯЧСМИТЬБЮ;QWERTYUIOP{}ASDFGHJKL:\"ZXCVBNM<>

" mac os
set langmap=йцукенгшщзхъфывапролджэячсмитьбю/ЙЦУКЕHГШЩЗХЪФЫВАПРОЛДЖЭЯЧСМИТЬБЮ/;qwertyuiop[]asdfghjkl;'zxcvbnm,./QWERTYUIOP[]ASDFGHJKL:'ZXCVBNM,./


" autocomplete
function! InsertTabWrapper(direction)
    let col = col('.') - 1
    
    if !col || getline('.')[col - 1] !~ '\k'
         return "\<tab>"
    elseif "backward" == a:direction
        return "\<c-p>"
    else
        return "\<c-n>"
    endif
endfunction 

inoremap <tab> <c-r>=InsertTabWrapper ("forward")<cr>
inoremap <s-tab> <c-r>=InsertTabWrapper ("backward")<cr>
