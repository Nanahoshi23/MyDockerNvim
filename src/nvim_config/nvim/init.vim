" vim-plug
call plug#begin('~/.local/share/nvim/plugged')

Plug 'airblade/vim-gitgutter'
Plug 'tpope/vim-fugitive'
Plug 'cespare/vim-toml'
Plug 'cohama/lexima.vim'
Plug 'ctrlpvim/ctrlp.vim'
Plug 'easymotion/vim-easymotion'


" めっちゃ使ってる
Plug '/usr/bin/fzf'
Plug 'junegunn/fzf.vim'
"Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
" Plug 'yuki-ycino/fzf-preview.vim', { 'branch': 'release', 'do': ':UpdateRemotePlugins' }
Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
Plug 'yuki-ycino/fzf-preview.vim', { 'branch': 'release/rpc' }


Plug 'neoclide/coc.nvim', { 'branch': 'release' }
Plug 'mattn/emmet-vim'
Plug 'prabirshrestha/async.vim'
"Plug 'prabirshrestha/vim-lsp'
Plug 'prabirshrestha/asyncomplete.vim'
Plug 'prabirshrestha/asyncomplete-lsp.vim'
Plug 'scrooloose/nerdtree'
Plug 'ryanoasis/vim-devicons'

Plug 'sjl/badwolf'
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
Plug 'w0rp/ale'
Plug 'Shougo/vimproc.vim'

Plug 'roxma/nvim-yarp'
Plug 'roxma/vim-hug-neovim-rpc'

" 正直使ってるのか使ってないのかよく分かってない
Plug 'Shougo/neosnippet.vim'
Plug 'Shougo/neosnippet-snippets'

"Plug 'kannokanno/previm'
"Plug 'tyru/open-browser.vim'
Plug 'plasticboy/vim-markdown'
Plug 'godlygeek/tabular'
"Plug 'iamcco/markdown-preview.vim'
Plug 'iamcco/mathjax-support-for-mkdp'

Plug 'dhruvasagar/vim-table-mode'

Plug 'leafcage/yankround.vim'
" 検索番号を横に検索文字のよこに記述
Plug 'osyo-manga/vim-anzu'

" 選択範囲の拡張プラグイン
Plug 'terryma/vim-expand-region'
"Pulg 'skanehira/translate.vim'

call plug#end()

let g:coc_global_extensions = [
       \  'coc-lists'
       \, 'coc-json'
       \, 'coc-marketplace'
       \, 'coc-html'
       \, 'coc-css'
       \, 'coc-tsserver'
       \, 'coc-solargraph'
       \, 'coc-python'
       \, 'coc-tsserver'
       \, 'coc-vetur'
       \, 'coc-fzf-preview'
       \, 'coc-tsserver'
       \ ]
       "\, 'coc-snippets'


"---------------------ore
augroup TransparentBG
    autocmd!
    autocmd Colorscheme * highlight Normal ctermbg=none
    autocmd Colorscheme * highlight NonText ctermbg=none
    autocmd Colorscheme * highlight LineNr ctermbg=none
    autocmd Colorscheme * highlight Folded ctermbg=none
    autocmd Colorscheme * highlight EndOfBuffer ctermbg=none
augroup END

set t_Co=256

set encoding=UTF-8
set fileencoding=UTF-8
set termencoding=UTF-8
set backspace=indent,eol,start
set hidden
set showcmd
set cursorline
set number
set laststatus=2
set showmatch
set incsearch
set display+=lastline
set wildmenu
set ignorecase
set clipboard+=unnamedplus

set tabstop=4
set shiftwidth=4
set softtabstop=4
set expandtab
set smarttab
set autoindent
set smartindent


" imap
"imap <silent> <C-i> <Nop>
"imap <silent> <C-i>' ’
"imap <silent> <C-i><Space> 　
"imap <silent> <C-i>" “”<Left>
imap <C-a> <home>
imap <C-e> <End>
imap <C-f> <right>
imap <C-b> <left>
imap <C-h> <backspace>



nnoremap s <Nop>

" ウィンドウ操作系
nnoremap sh <C-w>h
nnoremap sj <C-w>j
nnoremap sk <C-w>k
nnoremap sl <C-w>l
nnoremap sH <C-w>H
nnoremap sJ <C-w>J
nnoremap sK <C-w>K
nnoremap sL <C-w>L
nnoremap s<Return> <C-w>x
nnoremap sq <C-w>c
nnoremap ss <C-w>s<C-w>j
nnoremap sv <C-w>v<C-w>l

" タブ操作
nnoremap tn :tabnew<CR>
nnoremap tl gt
nnoremap th gT

" 畳み込操作
nnoremap so zo
nnoremap sc zc
nnoremap sa za
nnoremap sr zr
nnoremap sm zm
nnoremap sO zO
nnoremap sC zC
nnoremap sA zA
nnoremap sR zR
nnoremap sM zM


" 普段遣い便利系スペースショートカット
" ウィンドウ移動系
"nnoremap <Space><Space> zz
"nnoremap <Space>h <C-w>h
"nnoremap <Space>j <C-w>j
"nnoremap <Space>k <C-w>k
"nnoremap <Space>l <C-w>l
"nnoremap <Space><Return> <C-w>x
"nnoremap <Space>q <C-w>c
"nnoremap <Space>s <C-w>s<C-w>j
"nnoremap <Space>v <C-w>v<C-w>l
nnoremap <C-l> <C-w>>
nnoremap <C-h> <C-w><
nnoremap <C-k> <C-w>+
nnoremap <C-j> <C-w>-

"スクローク系コマンドとジャンプ
"nnoremap <Space><Space> zz
"nnoremap <Space>t zt
"nnoremap <Space>b zb
"nnoremap <Space>u <C-u>
"nnoremap <Space>d <C-d>

" 畳み込操作
"nnoremap <Space>o zo
"nnoremap <Space>c zc
"nnoremap <Space>a za
"nnoremap <Space>r zr
"nnoremap <Space>. zm
"nnoremap <Space>O zO
"nnoremap <Space>C zC
"nnoremap <Space>A zA
"nnoremap <Space>R zR
"nnoremap <Space>. zm



set sh=bash

augroup fileTypeIndent
  autocmd!
  autocmd BufNewFile,BufRead *.py setlocal tabstop=4 softtabstop=4 shiftwidth=4
  autocmd BufNewFile,BufRead *.go setlocal tabstop=4 softtabstop=4 shiftwidth=4
augroup END


" カーソル移動
nnoremap j gj
nnoremap k gk
nnoremap <Down> gj
nnoremap <Up> gk

" ウィンドウ操作


nnoremap <ESC><ESC> :nohlsearch<CR>

set wildmode=list,full

set grepformat=%f:%l:%m,%f:%l%m,%f\ \ %l%m,%f
set grepprg=grep\ -nh


colorscheme badwolf
"set termguicolors
syntax on


" fzf.vim
" 候補移動とコマンドの見直し
nnoremap <Space> <Nop>
nnoremap <Space><Space> :FzfPreviewDirectoryFiles<CR>
nnoremap <Space>g :FzfPreviewProjectGrepRpc ""<CR>
nnoremap <C-g> :FzfPreviewProjectGrepRpc 
nnoremap <Space>b :FzfPreviewBuffersRpc<CR>
nnoremap <Space>l :FzfPreviewBufferLinesRpc<CR>
nnoremap <Space>j :FzfPreviewJumps<CR>
nnoremap <Space>r :FzfPreviewCommandPaletteRpc<CR>
nnoremap <Space>c :FzfPreviewChangesRpc<CR>
nnoremap <Space>y :FzfPreviewYankroundRpc<CR>

nnoremap <silent> <Space>/     :<C-u>FzfPreviewLinesRpc --add-fzf-arg=--no-sort --add-fzf-arg=--query=<CR>
nnoremap <silent> <Space>*     :<C-u>FzfPreviewLinesRpc --add-fzf-arg=--no-sort --add-fzf-arg=--query="'<C-r>=expand('<cword>')<CR>"<CR>

xnoremap <silent> <Space>g :FzfPreviewProjectGrepRpcV <CR>
xnoremap <silent> <Space>l :FzfPreviewBufferLinesRpcV <CR>
xnoremap <silent> <Space>/ :FzfPreviewLinesRpcV <CR>

xnoremap <silent> <Space>e :TransE <CR>
xnoremap <silent> <Space>j :TransJ <CR>

" git操作
nnoremap ga :Gwrite<CR>
nnoremap gc :Gcommit<CR><CR>
nnoremap gs :Gstatus<CR>
nnoremap gp :Gpush<CR>
nnoremap gd :Gdiff<CR>
nnoremap gl :Glog<CR>
nnoremap gb :Gblame<CR>

" nerdtree
let g:NERDTreeShowHidden = 1
let g:NERDTreeMapActivateNode = "<CR>"
let file_name = expand("%:p")


"" vim-airline
" パワーラインでかっこよく
let g:airline_powerline_fonts = 1
" カラーテーマ指定してかっこよく
" タブバーをかっこよく
let g:airline#extensions#tabline#enabled = 1
" 選択行列の表示をカスタム(デフォルトだと長くて横幅を圧迫するので最小限に)
let g:airline_section_z = airline#section#create(['windowswap', '%3p%% ', 'linenr', ':%3v'])

" virtulenvを認識しているか確認用に、現在activateされているvirtualenvを表示(vim-virtualenvの拡張)
let g:airline#extensions#virtualenv#enabled = 1

" gitのHEADから変更した行の+-を非表示(vim-gitgutterの拡張)
let g:airline#extensions#hunks#enabled = 0

" Lintツールによるエラー、警告を表示(ALEの拡張)
let g:airline#extensions#ale#enabled = 1
let g:airline#extensions#ale#error_symbol = 'E:'
let g:airline#extensions#ale#warning_symbol = 'W:'
"let g:airline_theme = 'powerlineish theme'



" vim-lsp
let g:lsp_diagnostics_enabled = 0
if executable('solargraph')
  au User lsp_setup call lsp#register_server({
    \ 'name': 'solargraph',
    \ 'cmd': {server_info->[&shell, &shellcmdflag, 'solargraph stdio']},
    \ 'initialization_options': {"diagnostics": "true"},
    \ 'whitelist': ['ruby'],
    \ })
endif
if executable('gopls')
  au User lsp_setup call lsp#register_server({
    \ 'name': 'gopls',
    \ 'cmd': {server_info->['gopls', '-mode', 'stdio']},
    \ 'whitelist': ['go'],
    \ })
endif
if executable('pyls')
  au User lsp_setup call lsp#register_server({
    \ 'name': 'pyls',
    \ 'cmd': {server_info->['pyls']},
    \ 'whitelist': ['python'],
    \ })
endif
if executable('typescript-language-server')
  au User lsp_setup call lsp#register_server({
    \ 'name': 'javascript support using typescript-language-server',
    \ 'cmd': {server_info->[&shell, &shellcmdflag, 'typescript-language-server --stdio']},
    \ 'root_uri': {server_info->lsp#utils#path_to_uri(lsp#utils#find_nearest_parent_file_directory(lsp#utils#get_buffer_path(), 'package.json'))},
    \ 'whitelist': ['javascript', 'javascript.jsx'],
    \ })
endif
if executable('typescript-language-server')
  au User lsp_setup call lsp#register_server({
    \ 'name': 'typescript-language-server',
    \ 'cmd': {server_info->[&shell, &shellcmdflag, 'typescript-language-server --stdio']},
    \ 'root_uri': {server_info->lsp#utils#path_to_uri(lsp#utils#find_nearest_parent_file_directory(lsp#utils#get_buffer_path(), 'tsconfig.json'))},
    \ 'whitelist': ['typescript', 'typescript.tsx'],
    \ })
endif
if executable('docker-langserver')
  au User lsp_setup call lsp#register_server({
    \ 'name': 'docker-langserver',
    \ 'cmd': {server_info->[&shell, &shellcmdflag, 'docker-langserver --stdio']},
    \ 'whitelist': ['dockerfile'],
    \ })
endif
if executable('html-languageserver')
  au User lsp_setup call lsp#register_server({
    \ 'name': 'html-languageserver',
    \ 'cmd': {server_info->[&shell, &shellcmdflag, 'html-languageserver --stdio']},
    \ 'whitelist': ['html'],
    \ })
endif

" debug
let g:lsp_log_verbose = 1
let g:lsp_log_file = expand('~/vim-lsp.log')
let g:asyncomplete_log_file = expand('~/asyncomplete.log')


"------------------------------------------------------------------------------------------------------------
" Nerdtreeのショートカット
nnoremap <silent> <C-n> :NERDTreeToggle<CR>
" VisualMode で選択中の文字列を/で検索
vnoremap <silent> / "vy/\V<C-r>=substitute(escape(@v,'\/'),"\n",'\\n','g')<CR><CR>



" スニペット

"imap <C-j> <Plug>(coc-snippets-expand)
"" Use <Cj> for select text for visual placeholder of snippet.
"vmap <C-k> <Plug>(coc-snippets-select)
"" Use <C-j> for jump to next placeholder, it's default of coc.nvim
"let g:coc_snippet_next = '<c-n>'
"" Use <C-k> for jump to previous placeholder, it's default of coc.nvim
"let g:coc_snippet_prev = '<c-p>'
"" Use <C-j> for both expand and jump (make expand higher priority.)
"imap <C-k> <Plug>(coc-snippets-expand-jump)
"" Use <leader>x for convert visual selected code to snippet
"xmap <C-i> <Plug>(coc-convert-snippet)
"
"
"inoremap <silent><expr> <TAB>
"      \ pumvisible() ? coc#_select_confirm() :
"      \ coc#expandableOrJumpable() ? "\<C-r>=coc#rpc#request('doKeymap', ['snippets-expand-jump',''])\<CR>" :
"      \ <SID>check_back_space() ? "\<TAB>" :
"      \ coc#refresh()
"
"function! s:check_back_space() abort
"  let col = col('.') - 1
"  return !col || getline('.')[col - 1]  =~# '\s'
"endfunction
"
"let g:coc_snippet_next = '<tab>'

hi Pmenu guifg=#f8f6f2 ctermfg=15 guibg=#35322d ctermbg=236
hi PmenuSel guifg=#000000 ctermfg=16 gui=bold cterm=bold
hi PmenuSbar guibg=#35322d ctermbg=236
hi PmenuThumb guifg=#d9cec3 ctermfg=252



" Plugin key-mappings.
" Note: It must be "imap" and "smap".  It uses <Plug> mappings.
imap <C-k>     <Plug>(neosnippet_expand_or_jump)
smap <C-k>     <Plug>(neosnippet_expand_or_jump)
xmap <C-k>     <Plug>(neosnippet_expand_target)

" SuperTab like snippets behavior.
" Note: It must be "imap" and "smap".  It uses <Plug> mappings.
"imap <expr><TAB>
" \ pumvisible() ? "\<C-n>" :
" \ neosnippet#expandable_or_jumpable() ?
 \    "\<Plug>(neosnippet_expand_or_jump)" : "\<TAB>"
smap <expr><TAB> neosnippet#expandable_or_jumpable() ?
\ "\<Plug>(neosnippet_expand_or_jump)" : "\<TAB>"




" For conceal markers.
if has('conceal')
  set conceallevel=2 concealcursor=niv
endif








""コマンドラインモードの設定---------------
set wildmenu
set wildmode=longest:full,full
cnoremap <C-b> <Left>
cnoremap <C-f> <Right>
cnoremap <C-p> <Up>
cnoremap <C-n> <Down>
cnoremap <C-a> <Home>
cnoremap <C-e> <End>
cnoremap <C-d> <Del>

" sudoで保存
function! s:sudo_write_current_buffer() abort
  write ! sudo tee % > /dev/null
endfunction
command! SudoWriteCurrentBuffer call s:sudo_write_current_buffer()

" Rg
"nnoremap <C-g> :Rg<Space>


"nnoremap <C-i> :! firefox & <Return>

" 対話形式でコマンドを実行
function! SelectInteractive(question, candidates) " \{\{\{
  try
    let a:candidates[0] = toupper(a:candidates[0])
    let l:select = 0
    while index(a:candidates, l:select, 0, 1) == -1
      let l:select = input(a:question . ' [' . join(a:candidates, '/') . '] ')
      if l:select == ''
        let l:select = a:candidates[0]
      endif
    endwhile
    return tolower(l:select)
  finally
    redraw!
  endtry
endfunction " \}\}\}

" 外部ツールtransコマンドが必要
" 英語翻訳English->Japanese
function! TransE() range
    let tmp = @@
    silent normal gvy
    let selected_string = @@
    let @@ = tmp
    let cmd0 = 'trans en:ja -b '.'"' .selected_string.'"'
    echo system(cmd0)
    let l:selected = SelectInteractive('*yank -> [y]  *info -> [i]  *exit -> [enter]',['y','i'])
    if l:selected == 'i'
      let cmd0 = 'trans en:ja '.'"' .selected_string.'"' "より詳しく表示
      echo system(cmd0)
    elseif l:selected == 'y'
      let @0 = system(cmd0)
    else
      echo 'exit'
    endif
endfunction

:command! -range TransE :call TransE()

" 外部ツールtransコマンドが必要
" 英語翻訳Japanese->English
function! TransJ() range
    let tmp = @@
    silent normal gvy
    let selected_string = @@
    let @@ = tmp
    let cmd0 = 'trans ja:en -b '.'"' .selected_string.'"'
    echo system(cmd0)
    let l:selected = SelectInteractive('*yank -> [y]  *info -> [i]  *exit -> [enter]',['y','i'])
    if l:selected == 'i'
      let cmd0 = 'trans ja:en '.'"' .selected_string.'"' "より詳しく表示
      echo system(cmd0)
    elseif l:selected == 'y'
      let @0 = system(cmd0)
    else
      echo 'exit'
    endif
endfunction

:command! -range TransJ :call TransJ()

function! SpeakE() range
    let tmp = @@
    silent normal gvy
    let selected_string = @@
    let @@ = tmp
    let cmd0 = 'trans en:en -p -b '.'"' .selected_string.'" > /dev/null 2>&1 </dev/null &'
    echo system(cmd0)
endfunction

:command! -range SpeakE :call SpeakE()

function! SpeakJ() range
    let tmp = @@
    silent normal gvy
    let selected_string = @@
    let @@ = tmp
    let cmd0 = 'trans ja:ja -p -b '.'"' .selected_string.'" > /dev/null 2>&1 </dev/null &'
    echo system(cmd0)
endfunction

:command! -range SpeakJ :call SpeakJ()



function! Test() range
    let tmp = @@
    silent normal gvy
    let selected_string = @@
    let @@ = tmp


    if selected_string == "\n"
      echo 'no word >'
      let selected_string = input('>>')
      echo selected_string
    else
      echo 'Input string'
      echo selected_string
    endif

    echo selected_string
    echo "end"
endfunction



:command! -range Test :call Test()


" 外部ツール　imagemagick(スクショ) tesseract(英文抽出)
"カメラ画像から英文を抽出
function! ScreenShotEinglish()
    echo "import english"
    let cmd0 = 'import ~/screen_shot_image.png'
    let cmd1 = 'tesseract ~/screen_shot_image.png stdout -l eng'
    echo system(cmd0)
    let @0  = system(cmd1)
endfunction
:command! -range ScreenShotEinglish : call ScreenShotEinglish()
"echo english_string
"let @0 = english_string


"set encoding=utf-8
"set fileencodings=iso-2022-jp,euc-jp,sjis,utf-8
"set fileformats=unix,dos,mac

autocmd BufNewFile,BufRead *.{md,mdwn,mkd,mkdn,mark*} set filetype=markdown
"let g:vim_markdown_folding_disabled=1
"let g:previm_enable_realtime=1
let g:markdown_folding = 1
let g:markdown_enable_folding = 1
let g:markdown_fenced_languages = ['html', 'python', 'bash=sh']
set conceallevel=0
set concealcursor=nc
let g:markdown_syntax_conceal = 0


" フローティングウィンドウサイズ比
let g:fzf_preview_floating_window_rate = 0.7

" fzfウィンドウ位置設定
let g:fzf_preview_direct_window_option = ''

" fzfコマンドのデフォルトオプション
let g:fzf_preview_default_fzf_options = { '--reverse': v:true, '--preview-window': 'wrap'}

" fzfquitマッピングを追加します
let g:fzf_preview_quit_map = 1

" 可能であれば、デフォルトでバッファにジャンプします
let g:fzf_preview_buffers_jump = 0

" fzfプレビューに使用されるコマンド。
" fzfで選択したファイル名は{}になります
let g:fzf_preview_command = 'bat --color=always --plain {-1}' " Installed bat

" このコマンドが成功した場合はg：fzf_binary_preview_commandが実行され、失敗した場合はg：fzf_preview_commandが実行されます。
let g:fzf_preview_if_binary_command = '[[ "$(file --mime {})" =~ binary ]]'

" バイナリファイルに使用されるコマンド
let g:fzf_binary_preview_command = 'echo "{} is a binary file"'

" プロジェクトからファイルリストを取得するために使用されるコマンド
" let g:fzf_preview_filelist_command = 'git ls-files --exclude-standard'               " Not Installed ripgrep
let g:fzf_preview_filelist_command = 'rg --files --hidden --follow --no-messages -g \!"* *"' " Installed ripgrep

" gitリポジトリからファイルリストを取得するために使用されるコマンド
let g:fzf_preview_git_files_command = 'git ls-files --exclude-standard'

" 現在のディレクトリからファイルリストを取得するために使用されるコマンド
let g:fzf_preview_directory_files_command = 'rg --files --hidden --follow --no-messages -g \!"* *"'

" gitステータスファイルリストを取得するために使用されるコマンド
let g:fzf_preview_git_status_command = 'git -c color.status=always status --short --untracked-files=all'

" gitステータスプレビューに使用されるコマンド。
let g:fzf_preview_git_status_preview_command =  "[[ $(git diff --cached -- {-1}) != \"\" ]] && git diff --cached --color=always -- {-1} || " .
\ "[[ $(git diff -- {-1}) != \"\" ]] && git diff --color=always -- {-1} || " .
\ g:fzf_preview_command

" プロジェクトgrepに使用されるコマンド
"let g:fzf_preview_grep_cmd = 'rg --line-number --no-heading --color=never'
let g:fzf_preview_grep_cmd = 'rg --column --line-number --no-heading --color=never'
 

" MRUおよびMRWキャッシュディレクトリ
let g:fzf_preview_cache_directory = expand('~/.cache/vim/fzf_preview')

" この値が0でない場合は、mruとmrwを無効にします
let g:fzf_preview_disable_mru = 1

" mruによって保存されるファイルの数の制限
let g:fzf_preview_mru_limit = 1000

" 現在のファイル行に使用されるコマンド
" let g:fzf_preview_lines_command = 'cat -n'                                " Not Installed bat
let g:fzf_preview_lines_command = 'bat --color=always --plain --number' " Installed bat

" grep結果のプレビューに使用されるコマンド
" let g:fzf_preview_grep_preview_cmd = expand('<sfile>:h:h') . '/bin/preview_fzf_grep'

" mruおよびmrwのキャッシュディレクトリ
let g:fzf_preview_cache_directory = expand('~/.cache/vim/fzf_preview')

" fzfプレビューがアクティブなときのキーボードショートカット
let g:fzf_preview_preview_key_bindings = 'ctrl-d:preview-page-down,ctrl-u:preview-page-up,?:toggle-preview'

" fzfの色を指定します
let g:fzf_preview_fzf_color_option = ''

" fzfで要素を選択するときのプロセスを設定します
let g:fzf_preview_custom_processes = {}
" For example, set split to ctrl-s
" let g:fzf_preview_custom_processes['open-file'] = fzf_preview#remote#process#get_default_processes('open-file')
" on coc extensions
" let g:fzf_preview_custom_processes['open-file'] = fzf_preview#remote#process#get_default_processes('open-file', 'coc')
" let g:fzf_preview_custom_processes['open-file']['ctrl-s'] = g:fzf_preview_custom_processes['open-file']['ctrl-x']
" call remove(g:fzf_preview_custom_processes['open-file'], 'ctrl-x')

" fzfプレビューウィンドウオプションとして使用
" let g:fzf_preview_fzf_preview_window_option = ''
let g:fzf_preview_fzf_preview_window_option = 'up:40%'

" vim-deviconsを使用する
let g:fzf_preview_use_dev_icons = 0

" デビコン文字幅
let g:fzf_preview_dev_icon_prefix_string_length = 3

" 結果の数が多い場合、デバイスはfzf-previewを遅くする可能性があります
" 結果の数が5000を超えると、デフォルトでアイコンは無効になります
let g:fzf_preview_dev_icons_limit = 5000

" バットプレビューで使用されるテーマ
" $FZF_PREVIEW_PREVIEW_BAT_THEME = 'ansi-dark'

" ripgrep
" Similarly, we can apply it to fzf#vim#grep. To use ripgrep instead of ag:
command! -bang -nargs=* Rg
  \ call fzf#vim#grep(
  \   'rg --column --line-number --no-heading --color=always '.shellescape(<q-args>), 1,
  \   <bang>0 ? fzf#vim#with_preview('up:60%')
  \           : fzf#vim#with_preview('right:50%:hidden', '?'),
  \   <bang>0)



function! FzfPreviewProjectGrepRpcV() range
    let tmp = @@
    silent normal gvy
    let selected_string = @@
    let @@ = tmp
    execute 'FzfPreviewProjectGrepRpc' selected_string
endfunctio
:command! -range FzfPreviewProjectGrepRpcV :call FzfPreviewProjectGrepRpcV()

function! FzfPreviewBufferLinesRpcV() range
    let tmp = @@
    silent normal gvy
    let selected_string = @@
    let @@ = tmp
    "let cmd = '--add-fzf-arg=--query='.'"'''.'<C-r>=expand('.''''.selected_string.''''.')<CR>"'
    let cmd = '--add-fzf-arg=--query='.'"'.selected_string.'"'
    execute 'FzfPreviewBufferLinesRpc' '--add-fzf-arg=--no-sort' cmd
    " execute <C-u>FzfPreviewLinesRpc --add-fzf-arg=--no-sort <CR>
endfunctio
:command! -range FzfPreviewBufferLinesRpcV :call FzfPreviewBufferLinesRpcV()

function! FzfPreviewLinesRpcV() range
    let tmp = @@
    silent normal gvy
    let selected_string = @@
    let @@ = tmp
    "let cmd = '--add-fzf-arg=--query='.'"'''.'<C-r>=expand('.''''.selected_string.''''.')<CR>"'
    let cmd = '--add-fzf-arg=--query='.'"'.selected_string.'"'
    execute 'FzfPreviewLinesRpc' '--add-fzf-arg=--no-sort' cmd
    " execute <C-u>FzfPreviewLinesRpc --add-fzf-arg=--no-sort <CR>
endfunctio
:command! -range FzfPreviewLinesRpcV :call FzfPreviewLinesRpcV()



" 検索時に番号を表示する
" mapping
nmap n <Plug>(anzu-n-with-echo)
nmap N <Plug>(anzu-N-with-echo)
nmap * <Plug>(anzu-star-with-echo)
nmap # <Plug>(anzu-sharp-with-echo)
" clear status
"nmap <Esc><Esc> <Plug>(anzu-clear-search-status)
" statusline
" nmap n <Plug>(anzu-n-with-echo)
" nmap N <Plug>(anzu-N-with-echo)
" nmap <Esc><Esc> <Plug>(anzu-clear-search-status)
nmap n <Plug>(anzu-mode-n)
nmap N <Plug>(anzu-mode-N)

" 選択範囲の拡張
vmap v <Plug>(expand_region_expand)
vmap <C-[> <Plug>(expand_region_shrink)


