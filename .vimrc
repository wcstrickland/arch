set nocompatible


syntax on
colorscheme ron

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
set clipboard=unnamedplus "allows pasting from OS clipboard"
"set clipboard^=unamed"

"normal mode + clear highlighting"
inoremap jj <Esc>:silent! nohls<cr> 
nnoremap G Gzz
nnoremap zq ZQ

"nerd tree substitue"
nnoremap <leader>f :Vex 23<CR>
nnoremap <leader>c :q<CR>


"autocomplete"
set completeopt=longest,menuone
inoremap <leader><leader> <C-n>


"a div and component shortcut""
inoremap <leader>div <div className=""><CR><CR></div><esc>kkf"a
"paragraph tag"
inoremap <leader>p <p><cr><cr></p><esc>ki
"react component tag"
"for loop"
inoremap <leader>for for(let i = 0; i<; i++){<CR>console.log();<CR>}<esc>kkf<a
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
inoremap <leader>main <CR><CR>def main():<CR><tab>pass<CR><CR><CR>if __name__ == "__main__":<CR><tab>main()
"java boiler"
inoremap <leader>java import java.util.*;<CR><CR>class xx {<CR><CR>}<esc>ka<CR><tab>public static void main(String[] args){<CR><CR><CR><esc>ki<tab>}<esc>k<esc>i<tab><tab>

"simple statusline"
set statusline=
set statusline+=\ %F
set statusline+=\ %M
set statusline+=\ %R
set statusline+=\ %L

"improved window nav"
nnoremap <c-h> <c-w>h
nnoremap <c-j> <c-w>j
nnoremap <c-k> <c-w>k
nnoremap <c-l> <c-w>l

vnoremap <c-_> :norm i//<esc>

"basic pairs functionality with no Plugin"
inoremap ( ()<esc>i
inoremap ) <esc>la
inoremap [ []<esc>i
inoremap ] <esc>la
inoremap { {}<esc>i
inoremap } <esc>la
inoremap " ""<esc>i
inoremap "" <C-o>a
inoremap ' ''<esc>i
inoremap '' <C-o>a


"preview markdown files on save"
"requires latex and pandoc"
"autocmd BufWritePost *.md !pandoc <afile> -o %.pdf"

autocmd BufWritePost *.java !javac <afile>

"save a session on save"
autocmd BufWritePost *.* :mks! %.vim
autocmd BufWinLeave *.* mkview
autocmd BufWinEnter *.* silent loadview 

"format go on save"

"load a docs file everytime a .js file is opened"
"au BufRead * :badd ~/.vim/git.md"
"au BufNewFile * :badd ~/.vim/git.md"

"run current js file in node"
autocmd BufWritePost *.py :!python3 <afile>
autocmd BufWritePost *.js :!node <afile>
autocmd BufWritePost *.java :!javac <afile>

"recursive rough spell check macro: requires turning spelling on first with :set spell"
let @s="]s1z=@s"
