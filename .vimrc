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
highlight ColorColumn ctermbg=8
"set clipboard^=unamed"
set clipboard=unnamedplus "allows pasting from OS clipboard"
"simple statusline"
set statusline=
set statusline+=\ %F
set statusline+=\ %M
set statusline+=\ %R
set statusline+=\ %L
"save a session on save"
"autocmd BufWritePost *.* :mks! %.vim"
"create and load views"
autocmd BufWinLeave *.* mkview
autocmd BufWinEnter *.* silent loadview 
autocmd VimEnter *.* :set cc=80
"run current file"
autocmd BufWritePost *.py :vnew | r !python3 #
autocmd BufWritePost *.js :vnew | r !node #
autocmd BufWritePost *.java :!javac <afile>
"recursive rough spell check macro: requires turning spelling on first with :set spell"
let @s="]s1z=@s"

"rebind esc and clear highlighting"
inoremap jj <Esc>:silent! nohls<cr> 
"jumpt to bottom and center"
nnoremap G Gzz
"easier close"
nnoremap zq ZQ
"single line up and down"
nnoremap j gj
nnoremap k gk
"better bol"
nnoremap 0 ^


"autocomplete"
set completeopt=longest,menuone
inoremap kk <C-n>


"SHORTCUTS"

"a div and component shortcut""
inoremap <leader>div <div className=""><CR><CR></div><esc>kkf"a
"paragraph tag"
inoremap <leader>p <p><cr><cr></p><esc>ki
"for loop"
inoremap <leader>for for(let i = 0; i<; i++){<CR><tab>console.log();<CR>}<esc>kkf<a
"try catch block"
inoremap <leader>try try{<CR><CR>}catch(e){<CR>console.log(e);<CR>}<esc>kkki<tab>
"if else if else"
inoremap <leader>elif if(){<CR>console.log();<CR>}else if(){<CR>console.log();<CR>}else{<CR>console.log();<CR>}<esc>6kf)i
"map"
inoremap <leader>map map((x) => ())<Esc>hi
"function"
inoremap <leader>func function (){<cr>console.log();<cr>}<esc>kkf(i
"arrow function"
inoremap <leader>> ()=>{<cr>console.log();<cr>}<esc>kkf)i
"go boiler"
inoremap <leader>go package main<cr><cr>import (<cr><tab>"fmt"<cr>)<cr>func main(){<cr><tab>fmt.Println("helloworld")<cr>}
"go errorcheck"
inoremap <leader>err if err != nil {<cr><tab>fmt.Println("error:", err)<cr>}
"python main"
inoremap <leader>main def<CR><cr>def main():<cr><tab>pass<cr><cr><esc>Iif __name__ == "__main__":<cr><tab>main()
"java boiler"
inoremap <leader>java import java.util.*;<CR><CR>class xx {<CR><CR>}<esc>ka<CR><tab>public static void main(String[] args){<CR><CR><CR><esc>ki<tab>}<esc>k<esc>i<tab><tab>


"basic pairs functionality with no Plugin"
inoremap ( ()<esc>i
inoremap ) <esc>la
inoremap [ []<esc>i
inoremap ] <esc>la
inoremap { {}<esc>i
inoremap {<cr> {<cr>}<esc>O<tab>
inoremap :<cr> :<cr><tab>
inoremap } <esc>la
inoremap " ""<esc>i
inoremap "" <C-o>a
inoremap ' ''<esc>i
inoremap '' <C-o>a

let mapleader = " "
"surround"
vnoremap <leader>( di()<esc>P
vnoremap <leader>[ di[]<esc>P
vnoremap <leader>{ di{}<esc>P
vnoremap <leader>' di''<esc>P
vnoremap <leader>" di""<esc>P

nnoremap <leader>( diwi()<esc>P
nnoremap <leader>[ diwi[]<esc>P
nnoremap <leader>{ diwi{}<esc>P
nnoremap <leader>' diwi''<esc>P
nnoremap <leader>" diwi""<esc>P

"nerd tree substitue"
nnoremap <leader>f :Vex 20<CR>
nnoremap <leader>q ZQ
nnoremap <leader>w :w<CR>

"commenting"
vnoremap <C-_> :norm 0i//<esc>
vnoremap <leader>c :norm 0i#<esc>

"improved window nav"
nnoremap <leader>h <c-w>h
nnoremap <leader>j <c-w>j
nnoremap <leader>k <c-w>k
nnoremap <leader>l <c-w>l

"change tabs"
nnoremap H gT
nnoremap L gt

"move highlighted blocks up and down"
vnoremap J :m '>+1<CR>gv=gv
vnoremap K :m '<-2<CR>gv=gv
