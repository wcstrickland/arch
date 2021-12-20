"headers"
set nocompatible
syntax on
colorscheme ron
filetype plugin on
packloadall

"PLUGIN SECTION"

"au VimEnter * RainbowParenthesesToggle"
"au Syntax * RainbowParenthesesLoadRound"
"au Syntax * RainbowParenthesesLoadSquare"
"au Syntax * RainbowParenthesesLoadBraces"

"file explorer"
let g:netrw_banner=0  "no banner"
let g:netrw_altv=1  "split right"
let g:netrw_liststyle=3  "tree view"
let g:netrw_alto=0    "preview to right"
let g:netrw_preview=1  "privew vert"

"default formatting"
set display=lastline
set hlsearch  "highlight search"
set hidden "allow buffer abandonment"
set laststatus=2   "always show status"
set splitright    "default vert split"
set splitbelow "causes splits below"
set path+=**    "fuzzy file finding"
set wildmenu  "better menu"
set number "default to numberd lines"
set relativenumber "default to numberd lines"
set termwinsize=10*0  "default terminal size"
set tabstop=4 "number of spaces per tab"
set shiftwidth=4 "indent size"
set expandtab "tabs are 4 spaces"
set showcmd "show leader key during timeout period"
set ignorecase 
set autoindent 
set noerrorbells
set novisualbell
"set clipboard^=unamed"
set clipboard=unnamedplus "allows pasting from OS clipboard"

"simple statusline"
set statusline=
set statusline+=\ %F
set statusline+=\ %M
set statusline+=\ %R
set statusline+=\ %L

"create and load views"
autocmd BufWinLeave *.* mkview
autocmd BufWinEnter *.* silent loadview 

"set 80char warning colum"
autocmd VimEnter *.* :set cc=80
highlight ColorColumn ctermbg=8

"recursive rough spell check macro: requires turning spelling on first with :set spell"
let @s="]s1z=@s"

"rebind esc and clear highlighting"
inoremap jj <Esc>:nohls<cr> 

"jumpt to bottom and center"
nnoremap G Gzz

"single line up and down"
nnoremap j gj
nnoremap k gk

"autocomplete"
set completeopt=longest,menuone
inoremap kk <C-n>

"SHORTCUTS"

"for loop"
inoremap <leader>for for(let i = 0; i<; i++){<CR>console.log();<CR>}<esc>k>>kf<a
"for of"
inoremap <leader>of for(let el of ){<CR>console.log(el);<CR>}<esc>k>>kf)i
"try catch block"
inoremap <leader>try try{<CR><CR>}catch(e){<CR>console.log(e);<CR>}<esc>k>>kki<tab>
"if else if else"
inoremap <leader>elif if(){<CR>console.log();<CR>}else if(){<CR>console.log();<CR>}else{<CR>console.log();<CR>}<esc>6kf)i
"map"
inoremap <leader>map map((x) => ())<Esc>hi
"function"
inoremap <leader>func function (){<cr>console.log();<cr>}<esc>k>>kf(i
"arrow function"
inoremap <leader>> ()=>{<cr>console.log();<cr>}<esc>k>>kf)i
"python main"
inoremap <leader>main def<CR><cr>def main():<cr><tab>pass<cr><cr><esc>Iif __name__ == "__main__":<cr><tab>main()

"basic pairs functionality with no Plugin"

function! PassOverClosing(char)
    let g:closers = [')', ']', '}']
    let g:curChar = getline('.')[col('.')-0]
    if index(g:closers, g:curChar) < 0
        execute "normal! a" . a:char
    else
        normal la
    endif
endfunction

function! PassOverQuotes(char)
    let g:singles = ''
    let g:doubles = ""
    let g:closers = [g:singles, g:doubles]
    let g:curChar = getline('.')[col('.')-0]
    if index(g:closers, g:curChar) >= 0
        execute "normal! i"a:char.a:char
        execute "normal! h"
    else
        normal la
    endif
endfunction


inoremap ( ()<esc>i
inoremap <silent>) <esc>:call PassOverClosing(')')<cr>a
inoremap [ []<esc>i
inoremap <silent>] <esc>:call PassOverClosing(']')<cr>a
inoremap { {}<esc>i
inoremap <silent>} <esc>:call PassOverClosing('}')<cr>a
inoremap {<cr> {<cr>}<esc>O<tab>
inoremap :<cr> :<cr><tab>
inoremap <silent>" <esc>:call PassOverQuotes('"')<cr>a
inoremap <silent>' <esc>:call PassOverQuotes('''')<cr>a

let mapleader = " "

"set linter and run with every save"
autocmd FileType python compiler pylint
autocmd FileType javascirpt compiler eslint
autocmd BufWritePost *.py,*.js silent make! <afile> | silent redraw!

"quickfix list"
function! ToggleQuickFix()
    if empty(filter(getwininfo(), 'v:val.quickfix'))
        copen
        wincmd k
    else
        cclose
    endif
endfunction
nnoremap <silent>Q :call ToggleQuickFix()<cr>
nnoremap J :cnext<cr>
nnoremap K :cNext<cr>

"replace exact word under cursor"
nnoremap R :%s/\<<c-r>=expand("<cword>")<cr>\>//gc<left><left><left>

"close and open"
nnoremap <leader>q ZQ
nnoremap <leader>w :w<CR>

"surround"
vnoremap <leader>( di()<esc>P
vnoremap <leader>[ di[]<esc>P
vnoremap <leader>{ di{}<esc>P
vnoremap <leader>' di''<esc>P
vnoremap <leader>" di""<esc>P

"nerd tree substitue"
nnoremap <leader>f :Vex 20<CR>
autocmd VimResized * wincmd =

"commenting"
vnoremap <C-_> :norm 0i//<esc>
vnoremap <leader>c :norm 0i#<esc>

"improved window nav"
nnoremap <leader>h <c-w>h
nnoremap <leader>j <c-w>j
nnoremap <leader>k <c-w>k
nnoremap <leader>l <c-w>l

"change buffers"
nnoremap H :bn<cr>
nnoremap L :bp<cr>

"jumplist"
nnoremap <leader>i <c-i>
nnoremap <leader>o <c-o>

 "marks"
 nnoremap M `

"move highlighted blocks up and down"
vnoremap J :m '>+1<CR>gv=gv
vnoremap K :m '<-2<CR>gv=gv

"dont select next on search under cursor"
nnoremap * *N

"register good stuff"
nnoremap <leader>y "
nnoremap <leader>p :reg<cr>:put 

"buffer good stuff"
nnoremap <leader>b :ls<cr>:


"search list for word under cursor"
nnoremap <leader>* [I:

"search list"
nnoremap <leader>/ :g/

"better bol/eol"
nnoremap - _
nnoremap + $
vnoremap - _
vnoremap + $h
