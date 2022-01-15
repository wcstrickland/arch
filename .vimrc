"file explorer"
    let g:netrw_banner=0  "no banner"
    let g:netrw_altv=1  "split right"
    let g:netrw_liststyle=3  "tree view"
    let g:netrw_alto=0    "preview to right"
    let g:netrw_preview=1  "privew vert"

"highlighting"
    colorscheme desert
    syntax on
    filetype plugin indent on
    highlight Search cterm=None ctermfg=Black ctermbg=Yellow
    highlight Visual cterm=None ctermfg=Black ctermbg=Green
    highlight SignColumn ctermbg=Black
    highlight DiffAdd cterm=None ctermfg=Black ctermbg=Green
    highlight diffAdded ctermfg=Green
    highlight diffRemoved ctermfg=Red
    highlight DiffChange cterm=None ctermfg=Black ctermbg=DarkBlue
    highlight DiffDelete cterm=None ctermfg=Black ctermbg=Red
    highlight DiffText cterm=None ctermfg=Black ctermbg=Yellow
    highlight SpecialKey ctermfg=DarkGrey
    
"so good they should be defaults"
    setlocal omnifunc=syntaxcomplete#Complete
    set hlsearch incsearch smartcase noshowmatch
    set noswapfile hidden number relativenumber lazyredraw ttyfast
    set showcmd  wildmenu path+=** complete-=i completeopt=menuone,noselect,noinsert
    set wildignore=*/node_modules/*,*/.viminfo/*,*/.git/* "exclued from vimgrep"
    set noerrorbells novisualbell splitright splitbelow
    set laststatus=2 display=lastline scrolloff=3
    set foldcolumn=2 foldmethod=indent foldlevelstart=0 signcolumn=number
    set tabstop=4 shiftwidth=4 smarttab expandtab autoindent
    function Dashes()
        setlocal listchars=multispace:···\|,tab:\ \
        setlocal list
    endfunction
    command Dashes call Dashes()

"simple statusline"
    set statusline=  statusline+=\%#ModeMsg#%.20F\ %#Title#%m\ %#NonText#%y\ %#Question#[%c]\ %#LineNr#[%l\|%L]%#CursorLine#

"set 80char warning colum"
    autocmd VimEnter *.* :set cc=80
    highlight ColorColumn ctermbg=DarkGrey

"recursive rough spell check macro: requires turning spelling on first with :set spell"
    let @s="]s1z=@s"

"rebind esc and clear highlighting"
    inoremap jj <Esc>:nohls<cr>

"jumpt to bottom and center"
    nnoremap G Gzz

"single line up and down"
    nnoremap j gj
    nnoremap k gk
    nnoremap J }
    nnoremap K {
    nnoremap <expr> h (col('.') == 1) ? 'za' : 'h'

"SHORTCUTS"
    inoremap <leader>for for(let el of ){<CR>console.log(el);<CR>}<esc>k>>kf)i
    inoremap <leader>try try{<CR><CR>}catch(e){<CR>console.log(e);<CR>}<esc>k>>kki<tab>
    inoremap <leader>map map((x) => ())<Esc>hi
    inoremap <leader>main def<CR><cr>def main():<cr><tab>pass<cr><cr><esc>Iif __name__ == "__main__":<cr><tab>main()
    inoremap <leader>doc /**<cr><cr>@fucntion<cr>@param{type}[name]<cr>@return{type}<cr>/

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
    inoremap {<cr> {<cr><cr>}<esc>ki
    inoremap <silent>} <esc>:call PassOverClosing('}')<cr>a
    inoremap " ""<esc>i
    inoremap "" <esc>ls"
    inoremap ` ``<esc>i
    inoremap `` <esc>ls`
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
    inoremap kk <C-n>
    inoremap ;; <C-x><C-f>

"open a new split and read the current buffer into it"
    nnoremap <leader>s :vnew<cr>:0read #<cr>:close<cr>

"if not in diffmode diff the splits. if in diff mode exit diff "
    if has("patch-8.1.0360")
      set diffopt+=internal,algorithm:patience
    endif
    function! DiffThese()
        if &diff
            windo diffoff
        else
            windo diffthis
        endif
    endfunction
    command Diff call DiffThese()

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
    nnoremap } :cnext<cr>
    nnoremap { :cNext<cr>

"replace exact word under cursor"
    nnoremap <leader>r :%s/\<<c-r>=expand("<cword>")<cr>\>//gc<left><left><left>

"close and open"
    nnoremap <leader>q :bd<cr>
    nnoremap <leader>w :w<CR>
    nnoremap <leader>! :w !sudo tee %<CR>
    nnoremap zq ZQ

"surround"
    xnoremap s :call Surround("")<left><left>
    xnoremap S :call SurroundTag("")<left><left>
    function Surround(chars)
        execute 'normal gvd'
        execute 'normal i' . a:chars
        execute 'normal P'
    endfunction
    function SurroundTag(tag)
        execute 'normal "Zy'
        execute 'normal gvd'
        execute 'normal 0i<' . a:tag . '>'
        execute 'normal o'
        execute 'normal o'
        execute 'normal 0i</' . a:tag . '>'
        execute 'normal kP'
    endfunction

"nerdtree"
    nnoremap <leader>f :Vex 20<CR>
    autocmd VimResized * wincmd =

"commenting"
    xnoremap <expr> <leader>c getline('.')[col('1')] == "/" ? ':norm 0d2l<cr>' : ':norm 0i//<esc>'

"improved window nav"
    nnoremap <leader>h <c-w>h
    nnoremap <leader>j <c-w>j
    nnoremap <leader>k <c-w>k
    nnoremap <leader>l <c-w>l
    nnoremap <leader>< <c-w>5<
    nnoremap <leader>> <c-w>5>
    nnoremap <leader>+ <c-w>5+
    nnoremap <leader>- <c-w>5-

"change buffers"
    nnoremap <leader>b :ls<cr>:b<space>
    nnoremap - :bN<cr>

"marks"
    nnoremap <leader>m :marks abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ<cr>:normal '
    function Marks()
        let g:marks = getmarklist(bufname())
        for mark in g:marks
            "use regex to only do user defined marks"
            let g:user = matchstr(mark["mark"], '\v[[:alpha:]]')
            if empty(g:user)
                continue
            else
                call sign_define(mark["mark"], {"text":mark["mark"], "texthl": "DiffDelete"})
                call sign_place(0, 'marks', mark["mark"], bufname(), {'lnum': mark["pos"][1]})
            endif
        endfor
    endfunction
    command Marks call Marks()
    function Markit(char)
         call sign_define(a:char, {"text":a:char, "texthl": "DiffDelete"})
         call sign_place(0, 'marks', a:char, bufname(), {'lnum': line('.')})
         execute "normal m" . a:char . "<cr>"
    endfunction
    nnoremap M :call Markit("")<left><left>

"move highlighted blocks up and down"
    xnoremap J :m '>+1<CR>gv=gv
    xnoremap K :m '<-2<CR>gv=gv

"show registers and prompt for put and copy/paste from system clip"
    nnoremap <leader>P :reg<cr>:put
    nnoremap <leader>p "*p
    nnoremap <leader>y "*yy 
    nnoremap <leader>Y "+yy

"search stuff"
    nnoremap * *N
    nnoremap <leader>* [I :
    nnoremap <leader>/ :g/

"trim all trailing whitespace"
    function TrailWhite()
        execute '%s/\s\+$//e'
    endfunction
    nnoremap <leader>t :call TrailWhite()<cr>

"better bol/eol"
    nnoremap H ^
    nnoremap L $
    xnoremap H ^
    xnoremap L $h

"open a split with a diff of staged changes"
    function! Review()
        execute ":vertical new" 
        execute ":%!git diff --staged" 
        execute ":set filetype=diff"
    endfunction
    command Review call Review()

"todos"
    function Todos()
        execute "vim TODO ./%"
        execute ":norm Q"
    endfunction
    command Todos call Todos()
