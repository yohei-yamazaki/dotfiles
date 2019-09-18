" 行数
set number
set noswapfile

" 検索時に大文字小文字を無視
set ignorecase

" ;が:に変わる
noremap ; :

" insertモードから抜ける
inoremap <silent> jj <ESC>
inoremap <silent> <C-j> j

" マウス設定
set mouse=a
set clipboard=unnamed

" 画面分割, タブページの設定
nnoremap s <Nop>
nnoremap sj <C-w>j
nnoremap sk <C-w>k
nnoremap sl <C-w>l
nnoremap sh <C-w>h
nnoremap sJ <C-w>J
nnoremap sK <C-w>K
nnoremap sL <C-w>L
nnoremap sH <C-w>H
nnoremap sn gt
nnoremap sp gT<Paste>
nnoremap ss :<C-u>sp<CR>
nnoremap sv :<C-u>vs<CR>
nnoremap sr <C-w>r
nnoremap s= <C-w>=
nnoremap sw <C-w>w
nnoremap so <C-w>_<C-w>|
nnoremap sO <C-w>=

" auto comment off
augroup auto_comment_off
    autocmd!
    autocmd BufEnter * setlocal formatoptions-=r
    autocmd BufEnter * setlocal formatoptions-=o
  augroup END

" 各種indent
set tabstop=2
set shiftwidth=2
set expandtab

nnoremap <silent> mp :bprevious<CR>
nnoremap <silent> mn :bnext<CR>

" 文字コード、改行コード自動判別
:set encoding=utf-8
:set fileencodings=utj-8,iso-2022-jp,euc-jp,sjis
:set fileformats=unix,dos,mac

" 普通にペーストできる
if &term =~ "xterm"
    let &t_SI .= "\e[?2004h"
    let &t_EI .= "\e[?2004l"
    let &pastetoggle = "\e[201~"

    function XTermPasteBegin(ret)
        set paste
        return a:ret
    endfunction

    inoremap <special> <expr> <Esc>[200~ XTermPasteBegin("")
endif

" NERDTree settings
  " show dot file
  let NERDTreeShowHidden = 1

  " show default nerdtree
  autocmd VimEnter * execute 'NERDTree'

" markdown settings
set nofoldenable

" ale settings
  " rubyではrubocop
let g:ale_linters = {'ruby': ['rubocop']}
let g:ale_fix_on_save = 1
let g:ale_ruby_rubocop_executable = '/usr/local/bin/rubocop'
  " 画面が動かないように
let g:ale_sign_column_always = 1
  " シンボル設定
let g:ale_sign_error = '!!'
let g:ale_sign_warning = '▲'
  " エラー、警告の総数表示
let g:lightline = {'colorscheme': 'tender'}
let g:tender_lightline = 1

let g:lightline.component_expand = {
      \  'linter_checking': 'lightline#ale#checking',
      \  'linter_warnings': 'lightline#ale#warnings',
      \  'linter_errors': 'lightline#ale#errors',
      \  'linter_ok': 'lightline#ale#ok',
      \ }

let g:lightline.component_type = {
      \     'linter_checking': 'left',
      \     'linter_warnings': 'warning',
      \     'linter_errors': 'error',
      \     'linter_ok': 'left',
      \ }

let g:lightline.active = { 'right': [[ 'linter_checking', 'linter_errors', 'linter_warnings', 'linter_ok' ]] }

" エラー間移動
nmap <silent> <C-k> <Plug>(ale_previous_wrap)
nmap <silent> <C-j> <Plug>(ale_next_wrap)

" markdown settings
let g:vim_markdown_new_list_item_indent=2

" unite settings
nnoremap fd :Unite file_rec

" プラグインがインストールされるディレクトリ
let s:dein_dir = expand('~/.cache/dein')
" dein.vim 本体
let s:dein_repo_dir = s:dein_dir . '/repos/github.com/Shougo/dein.vim'

" dein.vim がなければ github から落としてくる
if &runtimepath !~# '/dein.vim'
  if !isdirectory(s:dein_repo_dir)
    execute '!git clone https://github.com/Shougo/dein.vim' s:dein_repo_dir
  endif
  execute 'set runtimepath^=' . fnamemodify(s:dein_repo_dir, ':p')
endif

" 設定開始
if dein#load_state(s:dein_dir)
  call dein#begin(s:dein_dir)

  " プラグインリストを収めた TOML ファイル
  " 予め TOML ファイルを用意しておく
  let g:rc_dir    = expand("~/.config/nvim/")
  let s:toml      = g:rc_dir . '/dein.toml'
  let s:lazy_toml = g:rc_dir . '/dein_lazy.toml'

  " TOML を読み込み、キャッシュしておく
  call dein#load_toml(s:toml,      {'lazy': 0})
  call dein#load_toml(s:lazy_toml, {'lazy': 1})

  " 設定終了
  call dein#end()
  call dein#save_state()
endif

" もし、未インストールものものがあったらインストール
if dein#check_install()
  call dein#install()
endif

function! s:deinClean()
  if len(dein#check_clean())
    call map(dein#check_clean(), 'delete(v:val, "rf")')
  else
    echo '[ERR] no disabled plugins'
  endif
endfunction
command! DeinClean :call s:deinClean()
