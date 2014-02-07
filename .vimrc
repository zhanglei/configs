"" Automatically reload .vimrc whenever it's edited
au! BufWritePost $MYVIMRC source $MYVIMRC

"" Basics
set nocompatible
set textwidth=80
set number
set showcmd
set cursorline

"" Syntax highlighting
syntax on

"" Searching
set ignorecase
set hlsearch
set incsearch

"" Editing behavior
set tabstop=4
set smarttab
set softtabstop=4
set shiftwidth=4
set expandtab
set autoindent
set nowrap
set scrolloff=3
set visualbell
set whichwrap=b,s,h,l,<,>,[,]

" Filetype based auto indenting
filetype indent on

"" Newline shortcut
nnoremap <S-J> o<Esc>

"" Turn off search highlight
nnoremap <CR> :noh<CR><CR>

"" Change comment color
hi comment ctermfg=green

"" Word processing
func! WordProcessorMode()
        setlocal formatoptions=t1
        setlocal textwidth=140
        map j gj
        map k gk
        setlocal smartindent
        setlocal spell spelllang=en_us
        setlocal noexpandtab
        endfu
com! WP call WordProcessorMode()

"" Highlight long lines
highlight LongLine ctermbg=darkblue guibg=darkblue

"" Highlight lines over 80 characters
function! LongLines()
    if exists('+colorcolumn')
        setlocal colorcolumn=80
    else
        " au BufWinEnter * let w:m2=matchadd('LongLine', '\%>80v.\+', -1)
        au BufEnter,BufWinEnter,StdinReadPost *.py,*.sh match LongLine /\%>80v.\+/
    endif
endfunction

au BufEnter,BufWinEnter * call LongLines()

" Use below to highlight group for bad whitespace matching in Python
highlight BadWhitespace ctermbg=red guibg=red

" Match all tabs at the begging of a line as bad
" Match trailing whitespace as bad
" Match lines containing only whitespace as bad
" In diff_mode, ignore lines containing just a single space (diff adds these)
let diff_mode=0
au FileType diff let diff_mode=1
function! MatchWhitespace()
    if !g:diff_mode
        match BadWhitespace /^\t\+/
        match BadWhitespace /\s\+$/
        match BadWhitespace /\S\s\+$/
        match BadWhitespace /^ \+$/
        match BadWhitespace / \+$/
    else
        match BadWhitespace /^\t\+/
        match BadWhitespace /\s\{2,\}$/
        match BadWhitespace /\S\s\+$/
        match BadWhitespace /^ \{2,\}$/
        match BadWhitespace / \{2,\}$/
    endif
endfunction

" Highlight trailing whitespace
au BufEnter,BufWinEnter,StdinReadPost *.py call MatchWhitespace()
