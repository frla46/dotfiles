" plugin manager
call plug#begin('~/.config/nvim/plugged')
Plug 'arcticicestudio/nord-vim'
Plug 'vim-jp/vimdoc-ja'
Plug 'easymotion/vim-easymotion'
Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }
Plug 'junegunn/fzf.vim'
Plug 'mbbill/undotree'
"Plug 'RRethy/vim-hexokinase', { 'do': 'make hexokinase' }
"Plug 'svermeulen/vimpeccable'
"Plug 'sheerun/vim-polyglot'
"Plug 'cocopon/iceberg.vim'
"Plug 'preservim/nerdtree'
"Plug 'tpope/vim-surround'
"Plug 'tpope/vim-commentary'
"Plug 'tpope/vim-repeat'
call plug#end()

" option
set autoindent
set autoread
set background=dark
set belloff=all
set clipboard+=unnamed,unnamedplus
set cursorline
set display+=lastline
set encoding=utf-8
set expandtab
set fileencoding=utf-8
set fileencodings=utf-8
set formatoptions-=ro
set gdefault
set hidden
set history=1000
set hlsearch
set ignorecase
set incsearch
set infercase
set laststatus=2
set linebreak
set matchpairs& matchpairs+=<:>
set matchtime=1
set novisualbell
set number
set pumheight=10
set scrolloff=5
set shiftround
set shiftwidth=2
set shortmess+=I
set showcmd
set showmatch
set smartcase
set smartindent
set smarttab
set statusline=%F%m%=%l/%L
set tabstop=2
set termencoding=utf-8
set termguicolors
set virtualedit+=block
set wildignorecase
set wildmenu
set wildmode=full
set wrap
set wrapscan

" other config
syntax enable
filetype plugin on

" disable auto commentout
autocmd FileType * setlocal formatoptions-=ro

" color
colorscheme iceberg

" ime
if executable('fcitx5')
   autocmd InsertLeave * :call system('fcitx5-remote -c')
   autocmd CmdlineLeave * :call system('fcitx5-remote -c')
endif

" Open read-only when swap file exists
augroup swapchoice-readonly
  autocmd!
  autocmd SwapExists * let v:swapchoice = 'o'
augroup end

" keys
nnoremap Q <nop>
vnoremap Q <nop>
nnoremap s <nop>
vnoremap s <nop>
nnoremap S <nop>
vnoremap S <nop>
nnoremap , <nop>
vnoremap , <nop>

let mapleader = "\ "
"nnoremap _ :
"vnoremap _ :
inoremap <silent><esc> <ESC>:<C-u>w<CR>
nnoremap <silent><esc><esc> :nohlsearch<CR>
nnoremap n nzz
nnoremap N Nzz
nnoremap * *zz
nnoremap # #zz
nnoremap Y y$
nnoremap <Down> gj
nnoremap <Up> gk
cnoremap w!! w !sudo tee > /dev/null %<CR>


" zsh emacs bindings inspire
inoremap <c-f> <right>
inoremap <c-b> <left>
inoremap <c-n> <down>
inoremap <c-p> <up>
inoremap <c-a> <home>
inoremap <c-e> <end>
inoremap <c-m> <CR>
inoremap <c-j> <CR>
inoremap <c-i> <tab>
inoremap <c-g> <esc>
inoremap <c-h> <bs>
inoremap <c-d> <del>
inoremap <c-u> <esc>^v$hdi
inoremap <c-k> <esc>ld$a

" spacemacs bindings inspire
nnoremap <silent><leader>- :
vnoremap <silent><leader>- :
nnoremap <silent><leader>; :
vnoremap <silent><leader>; :
nnoremap <silent><leader>qq :q<CR>
nnoremap <silent><leader>qQ :q!<CR>
nnoremap <silent><leader>qw :wq<CR>
nnoremap <silent><leader>qx :x<CR>
nnoremap <silent><leader>qa :qa<CR>
nnoremap <silent><leader>qA :qa!<CR>

" file
nnoremap <silent><leader>fs :w<CR>
nnoremap <silent><leader>fz :x<CR>
nnoremap <silent><leader>ft :e .<CR>
nnoremap <silent><leader>fr :source %<CR>

" buffer
nnoremap <silent><leader>bn :bn<CR>
nnoremap <silent><leader>bp :bp<CR>
nnoremap <silent><leader>bd :bd<CR>
nnoremap <silent><leader>bN :enew<CR>
nnoremap <silent><leader>bl :ls<CR>
nnoremap <silent><leader>bT :tab ba<CR> 

" window
nnoremap <silent><leader>wp <c-w>s<CR>
nnoremap <silent><leader>wv <c-w>v<CR>
nnoremap <silent><leader>wd <c-w>c<CR>
"nnoremap <silent><leader>wq <c-w>c<CR>
"nnoremap <silent><leader>wc <c-w>c<CR>
nnoremap <silent><leader>wj <c-w>j<CR>
nnoremap <silent><leader>wk <c-w>k<CR>
nnoremap <silent><leader>wh <c-w>h<CR>
nnoremap <silent><leader>wl <c-w>l<CR>
nnoremap <silent><leader>wJ <c-w>J<CR>
nnoremap <silent><leader>wK <c-w>K<CR>
nnoremap <silent><leader>wH <c-w>H<CR>
nnoremap <silent><leader>wL <c-w>L<CR>
nnoremap <silent><leader>wn <c-w>n<CR>
nnoremap <silent><leader>w= <c-w>=<CR>

" tab
nnoremap <silent><leader>tn gt<CR>
nnoremap <silent><leader>tp gT<CR>
nnoremap <silent><leader>tN :tabe new<CR>
nnoremap <silent><leader>td :tabclose<CR>
nnoremap <silent><leader>to :tabonly<CR>

" edit file
nnoremap <silent><leader>fez :e ~/.zshrc<CR>
nnoremap <silent><leader>fev :e $MYVIMRC<CR>
nnoremap <silent><leader>few :e ~/.config/i3/config<CR>
nnoremap <silent><leader>fec :e ~/.Xresource<CR>

" script
function! Scouter(file, ...)
  let pat = '^\s*$\|^\s*"'
  let lines = readfile(a:file)
  if !a:0 || !a:1
    let lines = split(substitute(join(lines, "\n"), '\n\s*\\', '', 'g'), "\n")
  endif
  return len(filter(lines,'v:val !~ pat'))
endfunction
command! -bar -bang -nargs=? -complete=file Scouter
\        echo Scouter(empty(<q-args>) ? $MYVIMRC : expand(<q-args>), <bang>0)
command! -bar -bang -nargs=? -complete=file GScouter
\        echo Scouter(empty(<q-args>) ? $MYGVIMRC : expand(<q-args>), <bang>0)

" plugins config
" netrw
let g:netrw_liststyle=1
let g:netrw_banner=0
let g:netrw_sizestyle="H"
let g:netrw_timefmt="%Y/%m/%d(%a) %H:%M:%S"
let g:netrw_preview=1

" vim-easymotion
let g:EasyMotion_enter_jump_first = 1
map s <Plug>(easymotion-overwin-f2)
map f <Plug>(easymotion-fl)
map t <Plug>(easymotion-tl)
map F <Plug>(easymotion-Fl)
map T <Plug>(easymotion-Tl)

" undotree
nnoremap <leader>u :UndotreeToggle<CR>

" nerdtree
"nnoremap <leader>e :NERDTreeToggle<CR>
"let g:NERDTreeWinSize=50
"let g:NERDTreeShowHidden=1
"let g:NERDTreeQuitOnOpen=1

" fzf
nnoremap <leader>ff :Files<CR>
nnoremap <leader>fh :History<CR>
nnoremap <leader>fb :Buffers<CR>
"nnoremap <leader>g :GFiles<CR>
"nnoremap <leader>G :GFiles?<CR>
"nnoremap <leader>r :Rg<CR>

" hexokinase
let g:Hexokinase_highlighters = [ 'virtual' ]
let g:Hexokinase_optInPatterns = 'full_hex,rgb,rgba,hsl,hsla'

