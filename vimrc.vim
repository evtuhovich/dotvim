set nocompatible

source $VIMRUNTIME/vimrc_example.vim

set hlsearch
set incsearch

set t_Co=256
set ts=2
set sw=2

filetype off
call pathogen#helptags()
call pathogen#runtime_append_all_bundles()

"set background=dark
"colorscheme solarized
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
  " set foldnestmax=2
  set foldtext=strpart(getline(v:foldstart),0,50).'\ ...\ '.substitute(getline(v:foldend),'^[\ #]*','','g').'\ '
  highlight Folded  guifg=#FFFFFF
endif

set fileencodings=koi8-r,utf8,cp1251
autocmd BufRead *.xml,*.aspx,*.htm,*.html,*.config,*.ascx set ts=2 sw=2 ft=xml
autocmd BufRead *.php set ts=2 sw=2 fenc=cp1251
autocmd BufRead *.sql set ts=4 sw=4
autocmd BufRead *.rjs,*.rxml  set ts=2 sw=2 ft=ruby
autocmd BufRead Vagrantfile set ts=2 sw=2 ft=ruby expandtab
autocmd BufRead *.rb set expandtab
autocmd BufRead *.cs  set ts=4 sw=4 fenc=utf8
autocmd User Rails/config/locales/*.yml set ai
autocmd User Rails.javascript* set expandtab ts=4 sw=4 sts=4
autocmd User Rails/*.coffee set expandtab ts=2 sw=2 sts=2
autocmd User Rails/*.haml set foldmethod=indent

autocmd BufRead *.erl,*.hrl set expandtab ts=4 sw=4

autocmd FileType ruby set expandtab

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

" set grepprg=grep\ $*\ *\ -n\ -r\ --exclude=*.log\ --exclude=tags
" let g:git_diff_spawn_mode = 2

" trailing whitspaces
:highlight ExtraWhitespace ctermbg=red guibg=red
:autocmd BufWinEnter *.rb,*.js,*.haml,*.html match ExtraWhitespace /\s\+$/

set tw=78

"set list listchars=tab:Б√╦б╥,trail:б╥,eol:б╛
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

nmap <Leader>a :FufCoverageFile<CR>
let g:fuf_maxMenuWidth = 140

command Irb :ConqueTermSplit irb

map <silent> <F4> :call BufferList()<CR>
let g:BufferListWidth = 25
let g:BufferListMaxWidth = 50


let g:Gitv_OpenHorizontal = 1

let g:rails_ctags_arguments="--exclude=log --exclude=tmp --exclude=www --exclude=public"

let ruby_no_expensive = 1

" The following is used when vim ai an e-mail editor for use in Russia (I've
" inherited it from some famous Vim hacker...)

" Hайти все последовательности цитирования в письме и составить из них опцию
" comments для удобства форматирования
function! SetQuoteComments () range abort
  let word char = '[A-Za-zёЁю-Ъ]' " Sorry, for koi8-r
  let &comments = "n:>"
  let start line = a:firstline
  let end line = a:lastline
  let current line = start line
  while current line <= end line
    let test string = getline(current line)
    let maxlen = strlen(test string)
    let match end pos = matchend(test string,'^[\t>]*'.wordchar.'\{1,5}>')
    while match end pos > 0
      let prefix = matchstr(test string,word char.'\{1,5}>')
      let test string = strpart(test string,match endpos,maxlen)
      let match end pos = matchend(test string,'^[\s>]*'.wordchar.'\{1,5}>')
      if match(&comments,':'.prefix.'\($\|,\)') < 0
        let &comments = &comments.',n:'.prefix
      endif
    endwhile
    let current line = current line + 1
  endwhile
endfunction

" au BufNewFile,BufRead <тут варианты почты>  %call SetQuoteComments()

" (на самом деле у меня вызов чуть более навороченный:

" Опции, локальные для буфера, передёргиваем при загрузке или создании буфера
if &filetype == "mail" || &filetype == "news"
  %call SetQuoteComments()
  set tw=78
endif

" Turn off the toolbar
set go-=T

" Line numbering makes the thing quite stylish
set nu

" Line wrap and visual bell
set nowrap
set visualbell
set ai

