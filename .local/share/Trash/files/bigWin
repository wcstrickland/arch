"headers"
set nocompatible
filetype plugin indent on
setlocal omnifunc=syntaxcomplete#Complete
"file explorer"
let g:netrw_banner=0  "no banner"
let g:netrw_altv=1  "split right"
let g:netrw_liststyle=3  "tree view"
let g:netrw_alto=0    "preview to right"
let g:netrw_preview=1  "privew vert"
"default formatting"
syntax on
colorscheme desert
set hlsearch  "highlight search"
set incsearch
highlight Search cterm=None ctermfg=Black ctermbg=Yellow
highlight Visual cterm=None ctermfg=Black ctermbg=Green
highlight DiffAdd cterm=None ctermfg=Black ctermbg=Green
highlight DiffChange cterm=None ctermfg=Black ctermbg=DarkBlue
highlight DiffDelete cterm=None ctermfg=Black ctermbg=Red
highlight DiffText cterm=None ctermfg=Black ctermbg=Yellow
set display=lastline
set hidden
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
set ruler
set statusline=
set statusline+=\%#ModeMsg#%.20F\ %#Title#%m\ %#NonText#%y\ %#Question#[%c]\ %#LineNr#[%l\|%L]%#CursorLine#
"create and load views"
autocmd BufWinLeave *.* mkview
autocmd BufWinEnter *.* silent loadview
"set 80char warning colum"
autocmd VimEnter *.* :set cc=80,100
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
nnoremap <expr> h (col('.') == 1) ? 'za' : 'h'
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
inoremap ( ()<esc>i
inoremap <silent>) <esc>:call PassOverClosing(')')<cr>a
inoremap [ []<esc>i
inoremap <silent>] <esc>:call PassOverClosing(']')<cr>a
inoremap { {}<esc>i
inoremap <silent>} <esc>:call PassOverClosing('}')<cr>a
inoremap {<cr> {<cr>}<esc>O<tab>
inoremap :<cr> :<cr><tab>
inoremap " ""<esc>i
inoremap "" <esc>ls"
inoremap ' ''<esc>i
inoremap '' <esc>ls'
let mapleader = " "
"autocomplete"
"keep autocomplete up sub <C-N> for <C-O> for less problems"
function! ToggleComplete()
    if !exists('#ToggleComplete#CursorMovedI')
        augroup ToggleComplete
            autocmd!
            autocmd CursorMovedI * if pumvisible()==0 | silent call  feedkeys("\<C-X>\<C-N>", 'n')
        augroup END
    else 
        augroup ToggleComplete
            autocmd! 
        augroup END 
    endif 
endfunction
function! ToggleOmni()
    if !exists('#ToggleOmni#CursorMovedI')
        augroup ToggleOmni
            autocmd!
            autocmd CursorMovedI * if pumvisible()==0 | silent call  feedkeys("\<C-X>\<C-O>", 'n')
        augroup END
    else 
        augroup ToggleOmni
            autocmd! 
        augroup END 
    endif 
endfunction
nnoremap <leader>a :call ToggleComplete()<CR>
nnoremap <leader>o :call ToggleOmni()<CR>
set complete-=i
set completeopt=menuone,noselect,noinsert
inoremap kk <C-n>
"filepath complete"
inoremap ;; <C-x><C-f>
"open a new split and read the current buffer into it"
nnoremap <leader>y :vnew<cr>:0read #<cr>:close<cr>
"if not in diffmode diff the splits. if in diff mode exit diff "
nnoremap <expr> <leader>d &diff ? ':diffoff<cr>' : ':diffthis<cr><c-w>w:diffthis<cr>'
"projects set .viminfo at project level"
function! SetProject()
    let path = expand('%:p')
    let g:stub = matchstr(path, '\v\/home\/bill\/[a-z]*[A-Z]*[0-9]*\/')
    let g:full =  "'100,<50,s10,h,n" . g:stub .  '.viminfo'
    let &viminfo = g:full
endfunction
autocmd BufRead *.* :call SetProject()
"set linter and run with every save"
autocmd FileType python compiler pylint
autocmd FileType javascript compiler eslint
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
nnoremap <leader>q :bd<cr>
nnoremap <leader>w :w<CR>
nnoremap <leader>! :w !sudo tee %<CR>
nnoremap zq ZQ
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
nnoremap <leader>b :ls<cr>:b<space>
"marks"
nnoremap <leader>m :marks abcdefghijklmnopqrstuvwxyz<cr>:normal `
nnoremap M :marks ABCDEFGHIJKLMNOPQRSTUVWXYZ<cr>:normal `
"move highlighted blocks up and down"
vnoremap J :m '>+1<CR>gv=gv
vnoremap K :m '<-2<CR>gv=gv
"dont select next on search under cursor"
nnoremap * *N
"show registers and prompt for put"
nnoremap <leader>p :reg<cr>:put
"search list for word under cursor"
nnoremap <leader>* [I :
"search list"
nnoremap <leader>/ :g/
"trim all trailing whitespace"
function TrailWhite()
    execute '%s/\s\+$//e'
endfunction
nnoremap <leader>t :call TrailWhite()<cr>
"better bol/eol"
nnoremap - _
nnoremap + $
vnoremap - _
vnoremap + $h
