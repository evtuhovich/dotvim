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

set background=light
colorscheme solarized
set ignorecase
syntax on
set backspace=indent,eol,start

set directory=~/.vim/swap
set backupdir=~/.vim/backup

set fileencodings=utf8,cp1251
autocmd	BufRead	*.xml,*.aspx,*.htm,*.html,*.config,*.ascx	set ts=2 sw=2 ft=xml
autocmd	BufRead	*.php	set ts=2 sw=2 fenc=cp1251
autocmd	BufRead	*.sql	set ts=4 sw=4
autocmd	BufRead	*.rjs,*.rxml	set ts=2 sw=2 ft=ruby
autocmd	BufRead	Vagrantfile	set ts=2 sw=2 ft=ruby expandtab
autocmd BufRead	*.rb set expandtab
autocmd	BufRead	*.cs	set ts=4 sw=4 fenc=utf8
autocmd User Rails/config/locales/*.yml set ai
autocmd User Rails.javascript* set noexpandtab

autocmd BufRead *.erl,*.hrl set expandtab ts=4 sw=4

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

set statusline=%<%f%h%m%r%=%{&ff}\ %l,%c%V\ %P
set statusline=%<%f\ %h%m%r%{fugitive#statusline()}%=%-14.(%l,%c%V%)\ %P
set guitablabel=%-200.400f

" avoid hit enter stupud messages
set cmdheight=2

" show status always
set laststatus=2

if has("folding")
	set foldenable
	set foldmethod=syntax
	set foldlevel=5
"	set foldnestmax=2
	set foldtext=strpart(getline(v:foldstart),0,50).'\ ...\ '.substitute(getline(v:foldend),'^[\ #]*','','g').'\ '
	highlight Folded  guifg=#FFFFFF
endif

let g:rails_dbext=0
let g:omni_sql_no_default_maps=1

let NERDTreeWinSize=50
nmap <F2> :NERDTreeToggle <CR>

let Tlist_WinWidth = 50
nmap <F3> :TlistToggle <CR>

" set grepprg=grep\ $*\ *\ -n\ -r\ --exclude=*.log\ --exclude=tags
" let g:git_diff_spawn_mode = 2

" trailing whitspaces
:highlight ExtraWhitespace ctermbg=red guibg=red
:autocmd BufWinEnter * match ExtraWhitespace /\s\+$/

set tw=120

set list listchars=tab:▸·,trail:·,eol:¬
highlight SpecialKey guifg=#333333

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

nmap <Leader>f :FufCoverageFile<CR>

command Irb :ConqueTermSplit irb
