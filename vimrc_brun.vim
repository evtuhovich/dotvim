set nocompatible

source $VIMRUNTIME/vimrc_example.vim

set hlsearch
set incsearch

set t_Co=256
set ts=2
set sw=2
"Asdfasdf

filetype off
call pathogen#helptags()
call pathogen#runtime_append_all_bundles()

"colorscheme solarized
set background=dark
colorscheme vividchalk

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
"	set foldnestmax=2
	set foldtext=strpart(getline(v:foldstart),0,50).'\ ...\ '.substitute(getline(v:foldend),'^[\ #]*','','g').'\ '
	highlight Folded  guifg=#FFFFFF
endif

set fileencodings=utf8,cp1251
autocmd	BufRead	*.xml,*.aspx,*.htm,*.html,*.config,*.ascx	set ts=2 sw=2 ft=xml
autocmd	BufRead	*.php	set ts=2 sw=2 fenc=cp1251
autocmd	BufRead	*.sql	set ts=4 sw=4
autocmd	BufRead	*.rjs,*.rxml	set ts=2 sw=2 ft=ruby
autocmd	BufRead	Vagrantfile	set ts=2 sw=2 ft=ruby expandtab
autocmd BufRead	*.rb set expandtab
autocmd	BufRead	*.cs	set ts=4 sw=4 fenc=utf8
autocmd User Rails/config/locales/*.yml set ai
autocmd User Rails.javascript* set expandtab ts=4 sw=4 sts=4
autocmd User Rails/*.coffee set expandtab ts=2 sw=2 sts=2
autocmd User Rails/*.haml set foldmethod=indent

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

let Tlist_WinWidth = 50
nmap <F3> :TlistToggle <CR>

vmap <D-C> :CopyRTF <CR>
" set grepprg=grep\ $*\ *\ -n\ -r\ --exclude=*.log\ --exclude=tags
" let g:git_diff_spawn_mode = 2

" trailing whitspaces
:highlight ExtraWhitespace ctermbg=red guibg=red
:autocmd BufWinEnter *.rb,*.js,*.haml,*.html,*.otl,*.txt match ExtraWhitespace /\s\+$/

set tw=120

set list listchars=tab:▸·,trail:·,eol:¬
highlight SpecialKey guifg=#333333 ctermfg=DarkGray

language C

" let g:git_no_map_default = 0
set tags=./tags,tags,/home/brun/.vim/tags

let g:rsenseHome="$RSENSE_HOME"

" ruby.vim configuration
let g:rubycomplete_buffer_loading = 1
let g:rubycomplete_classes_in_global = 1
let g:rubycomplete_rails = 1

" unimpaired plugin need for text bubbling
vmap <C-j> ]egv
vmap <C-k> [egv

vmap <C-l> >gv
vmap <C-h> <gv
" Source the vimrc file after saving it
if has("autocmd")
  autocmd bufwritepost .vimrc source $MYVIMRC
  autocmd bufwritepost vimrc_brun.vim source $MYVIMRC
endif

let g:fuf_maxMenuWidth = 140

command Irb :ConqueTermSplit irb

nmap <silent> <F4> :FufBuffer<CR>
nmap <silent> <F5> :FufCoverageFile<CR>

let g:Gitv_OpenHorizontal = 1

let g:rails_ctags_arguments="--exclude=log --exclude=tmp --exclude=www --exclude=public"

let ruby_no_expensive = 1
