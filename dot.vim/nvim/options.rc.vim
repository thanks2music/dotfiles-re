" =========================================================
" カラースキーマ設定	
" =========================================================

filetype plugin indent on
syntax enable

" ==========================================================
" 基本設定
" ==========================================================

let mapleader = "," " キーマップリーダー
set scrolloff=5     " スクロール時の余白確保
set nobackup        " バックアップ取らない
set autoread        " 他で書き換えられたら自動で読み直す
set noswapfile      " スワップファイル作らない
set noundofile      " undofileを作らない
set hidden          " 編集中でも他のファイルを開けるようにする
set backspace=indent,eol,start  " バックスペースでなんでも消せるように
set formatoptions=lmoq  " テキスト整形オプション，マルチバイト系を追加
set vb t_vb=        " ビープをならさない
set browsedir=buffer    " Exploreの初期ディレクトリ
set whichwrap=b,s,h,l,<,>,[,]   " カーソルを行頭、行末で止まらないようにする
set showcmd         " コマンドをステータス行に表示
set cmdheight=2   " 画面最下部のメッセージ表示欄の行数
set magic           " 正規表現に使われる記号を有効にする
set showcmd         " 入力中のコマンドを表示
set number          " 行番号表示
set numberwidth=4   " 行番号の幅
set ruler           " ルーラーの表示
set list            " 不可視文字表示

" ==========================================================
" インデント
" ==========================================================
set autoindent
set smartindent
set cindent
set expandtab
set tabstop=2
set shiftwidth=2
set softtabstop=2