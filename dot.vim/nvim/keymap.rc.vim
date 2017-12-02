"-------------------------------------------------------------------------------
"" Key mappings
"-------------------------------------------------------------------------------
nnoremap j gj
nnoremap k gk
" Shift+hjkl で先頭や末尾とかに移動
noremap <S-h>   ^
noremap <S-j>   }
noremap <S-k>   {
noremap <S-l>   $
" ノーマルモードでも改行出来る
nnoremap <CR> A<CR><ESC>
" インデント調整
nnoremap == gg=G''
" プラグイン周りを簡単に起動
nnoremap <Space>n  :NERDTree<CR>
" 検索などで飛んだらそこを真ん中に
nmap n nzz
nmap N Nzz
nmap # #zz
nmap g* g*zz
nmap g# g#zz
nmap G Gzz

" CTRL-hjklでウィンドウ移動
nmap <C-j> <C-w>j
nmap <C-k> <C-w>k
nmap <C-l> <C-w>l
nmap <C-h> <C-w>h

" その他キーバインド
nmap <C-r> <C-r>
imap <C-r> <C-o><C-r>
imap <C-l> <Right>
vmap <C-r> <Esc><C-r>
nmap <silent> L :nohl<CR>

" qq でレジスタに記憶しないようにする
nmap qq <ESC>

" コマンドモードでの補完
cmap <C-p> <Up>
cmap <C-n> <Down>

" usキーボードで使いやすく
nmap ; :
vmap ; :

" 画面分割移動を簡単に
map <C-H> <C-W>h
map <C-J> <C-W>j
map <C-K> <C-W>k
map <C-L> <C-W>l
map <C-TAB> <C-W>w
