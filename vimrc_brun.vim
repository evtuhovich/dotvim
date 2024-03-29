set nocompatible

" source $VIMRUNTIME/vimrc_example.vim

set hlsearch
set incsearch

set t_Co=256
set ts=2
set sw=2
"Asdfasdf

" share clipboard with OSX
set clipboard=unnamed

filetype off

call plug#begin('~/.vim/bundle')
  Plug 'neoclide/coc.nvim', {'branch': 'release'}
  Plug 'othree/xml.vim'
  Plug 'chase/vim-ansible-yaml'
  Plug 'majutsushi/tagbar',
  Plug 'msanders/snipmate.vim'
  Plug 'scrooloose/nerdcommenter'
  Plug 'scrooloose/nerdtree'
  Plug 'timcharper/textile.vim'
  Plug 'tpope/vim-fugitive'
  Plug 'tpope/vim-git'
  Plug 'tpope/vim-repeat'
  Plug 'tpope/vim-surround'
  Plug 'tpope/vim-vividchalk'
  Plug 'tsaleh/vim-align'
  Plug 'vim-ruby/vim-ruby'
  Plug 'PProvost/vim-ps1'
  Plug 'elzr/vim-json'
  Plug 'jnwhiteh/vim-golang'
  Plug 'slim-template/vim-slim'
  Plug 'tpope/vim-unimpaired'
  Plug 'vim-scripts/matchit.zip'
  Plug 'Lokaltog/vim-easymotion'
  Plug 'Lokaltog/vim-powerline'
  Plug 'altercation/vim-colors-solarized'
  Plug 'gregsexton/gitv'
  Plug 'henrik/vim-indexed-search'
  Plug 'kchmck/vim-coffee-script'
  Plug 'kien/ctrlp.vim'
  Plug 'mileszs/ack.vim'
  Plug 'scrooloose/syntastic'
  Plug 'vim-scripts/Conque-Shell'
  Plug 'vim-scripts/tComment'
  Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
  Plug 'junegunn/fzf.vim'
  Plug 'hrsh7th/nvim-cmp'
  Plug 'ibhagwan/fzf-lua'
  Plug 'nvim-telescope/telescope.nvim'
  Plug 'nvim-treesitter/nvim-treesitter', {'do': ':TSUpdate'}
  Plug 'godlygeek/tabular'  " needed by 'preservim/vim-markdown'
  Plug 'nvim-lua/plenary.nvim' " needed by obsidian.nvim
  Plug 'epwalsh/obsidian.nvim'
call plug#end()

colorscheme solarized
set background=light

if has('gui_running')
  set guifont=Monaco:h16
  set guioptions-=T
  set guioptions-=r
  set guioptions+=c
  set visualbell
endif

set ignorecase
syntax on
set backspace=indent,eol,start

set noswapfile
"set backupdir=~/.vim/backup
set nobackup
set nowritebackup

if has("folding")
  set foldenable
  set foldmethod=syntax
  set foldlevel=5
" set foldnestmax=2
  set foldtext=strpart(getline(v:foldstart),0,50).'\ ...\ '.substitute(getline(v:foldend),'^[\ #]*','','g').'\ '
  highlight Folded  guifg=#FFFFFF
endif

set fileencodings=utf8

augroup ruby
	autocmd!
	autocmd BufRead,BufNewFile *.rb set expandtab
	autocmd User Rails/config/locales/*.yml set ai
	autocmd User Rails.javascript* set expandtab ts=4 sw=4 sts=4
	autocmd User Rails/*.coffee set expandtab ts=2 sw=2 sts=2
	autocmd User Rails/*.haml set foldmethod=indent
	autocmd BufRead Vagrantfile set ts=2 sw=2 ft=ruby expandtab
	let g:syntastic_ruby_checkers = ['rubocop', 'mri']
augroup END

autocmd BufRead *.xml,*.aspx,*.htm,*.html,*.config,*.ascx set ts=4 sw=4 expandtab ft=xml
autocmd BufRead *.php set ts=2 sw=2
autocmd BufRead *.sql set ts=4 sw=4

autocmd BufRead *.erl,*.hrl set expandtab ts=4 sw=4


autocmd BufNewFile,BufRead *.markdown setfiletype octopress

set wildmenu
set wildmode=list:longest
set wcm=<Tab>

" added by AV
filetype plugin on
filetype plugin indent on
""""

set viminfo='20,<50,s10,h,rA:,rB:

set autowriteall
set autowrite

set statusline=%<%f\ %h%m%r%{fugitive#statusline()}%=%-14.(%l,%c%V%)\ %P
set guitablabel=%-200.400f

" avoid hit enter stupud messages
set cmdheight=2

" show status always
set laststatus=2

let g:rails_dbext=0
let g:omni_sql_no_default_maps=1

let NERDTreeWinSize=50
nmap <F2> :NERDTreeToggle <CR>

nmap <F3> :FZF <CR>

vmap <D-C> :CopyRTF <CR>
" set grepprg=grep\ $*\ *\ -n\ -r\ --exclude=*.log\ --exclude=tags
" let g:git_diff_spawn_mode = 2

" trailing whitspaces
highlight ExtraWhitespace ctermbg=red guibg=red
autocmd BufWinEnter *.rb,*.js,*.haml,*.html,*.otl,*.txt match ExtraWhitespace /\s\+$/

set tw=120

" set list listchars=tab:▸·,trail:·,eol:¬
set list listchars=tab:▸·,trail:·
highlight SpecialKey guifg=#839496 ctermfg=DarkGray guibg=#404040


language C

" let g:git_no_map_default = 0
set tags=./tags,tags,/home/brun/.vim/tags

let g:rsenseHome="$RSENSE_HOME"

" ruby.vim configuration
let g:rubycomplete_buffer_loading = 1
let g:rubycomplete_classes_in_global = 1
let g:rubycomplete_rails = 1


let g:kb_notes_path=expand('~/Projects/evtuhovich/dendron/vault')
" unimpaired plugin need for text bubbling
vmap <C-j> ]egv
vmap <C-k> [egv

vmap <C-l> >gv
vmap <C-h> <gv
"
augroup reread_vimrc
  autocmd!
  autocmd bufwritepost .vimrc source $MYVIMRC
  autocmd bufwritepost vimrc_brun.vim source $MYVIMRC
augroup END


let g:fuf_maxMenuWidth = 140

command! Irb :ConqueTermSplit irb

nmap <silent> <F4> :CtrlPBuffer<CR>
nmap <silent> <F5> :CtrlP<CR>

let g:Gitv_OpenHorizontal = 1

let g:rails_ctags_arguments="--exclude=log --exclude=tmp --exclude=www --exclude=public"

let ruby_no_expensive = 1

" store ctrlp cache
let g:ctrlp_clear_cache_on_exit = 0
let g:ctrlp_cache_dir = $HOME.'/.vim/.ctrlp_cache'
let g:ctrlp_match_window_bottom = 0
let g:ctrlp_match_window_reversed = 0
let g:ctrlp_dotfiles = 0
let g:ctrlp_custom_ignore = {
    \ 'dir':  '\(tmp/sass-cache\)\|\(public/assets\)\|\(tmp/cache\)',
    \ }



let g:Powerline_symbols = 'unicode'

" tagbar config
let g:tagbar_autoclose = 0
let g:tagbar_left = 1
let g:tagbar_autoshowtag = 1
let g:tagbar_updateonsave_maxlines = 10000
set updatetime=500

" vim-json
let g:vim_json_syntax_conceal = 0


" chef-vim
nnoremap <C-a>      :<C-u>ChefFindAny<CR>

if filereadable(".vim")
    so .vim
endif

set exrc

luafile /Users/brun/.config/nvim/luainit.lua
