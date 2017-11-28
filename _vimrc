filetype on
set shortmess=atI "去掉欢迎界面（帮助乌干达儿童。。。）
colorscheme  monokai     "配色方案 
set guifont=Liberation\Mono\ 11     "字体与字号
set tabstop=4                " 设置tab键的宽度
set shiftwidth=4             " 换行时行间交错使用4个空格
set softtabstop=4
set backspace=indent,eol,start              " 设置退格键可用
set showmatch 
set number                   " 显示行号
set mouse=a                  " 启用鼠标
set ruler                    " 右下角显示光标位置的状态行
set incsearch                " 查找book时，当输入/b时会自动找到
set hlsearch                 " 开启高亮显示结果
set incsearch                " 开启实时搜索功能
set nowrapscan               " 搜索到文件两端时不重新搜索
set nocompatible             " 关闭兼容模式
set vb t_vb=                 " 关闭提示音
set hidden                   " 允许在有未保存的修改时切换缓冲区
set listchars=tab:\|\ ,
set nobackup
syntax enable                " 打开语法高亮
syntax on                    " 开启文件类型侦测
filetype indent on           " 针对不同的文件类型采用不同的缩进格式
filetype plugin on           " 针对不同的文件类型加载对应的插件
filetype plugin indent on    " 启用自动补全

"设置文件检测编码
set fileencodings=utf-8,gbk,gb2312,ucs-bom,chinese,cp936,gb18030,big5,euc-jp,euc-kr,latin1
""设置内部编码
set encoding=utf-8
"设置新建文件保存编码
"set fileencoding=utf-8

set termencoding=utf-8
set fileformats=unix,dos

set ts=4 
set expandtab
map <C-A> ggVG  
map! <C-A> <Esc>ggVGY  
map <F12> gg=G  

"autocmd VimEnter * NERDTree
map <F2> :NERDTreeToggle<CR>

set guioptions-=T " 隐藏工具栏
set guioptions-=m " 隐藏菜单栏

set rtp+=~/.vim/bundle/Vundle.vim
"vundle 管理的插件列表必须位于 vundle#begin() 和 vundle#end() 之间
call vundle#begin()
Plugin 'VundleVim/Vundle.vim'
Plugin 'altercation/vim-colors-solarized'
Plugin 'tomasr/molokai'
Plugin 'vim-scripts/phd'
Plugin 'Lokaltog/vim-powerline'
Plugin 'octol/vim-cpp-enhanced-highlight'
Plugin 'nathanaelkane/vim-indent-guides'
Plugin 'derekwyatt/vim-fswitch'
Plugin 'kshenoy/vim-signature'
Plugin 'vim-scripts/BOOKMARKS--Mark-and-Highlight-Full-Lines'
Plugin 'majutsushi/tagbar'
Plugin 'vim-scripts/indexer.tar.gz'
Plugin 'vim-scripts/DfrankUtil'
Plugin 'vim-scripts/vimprj'
Plugin 'dyng/ctrlsf.vim'
Plugin 'terryma/vim-multiple-cursors'
Plugin 'scrooloose/nerdcommenter'
Plugin 'vim-scripts/DrawIt'
Plugin 'SirVer/ultisnips'
Plugin 'derekwyatt/vim-protodef'
Plugin 'scrooloose/nerdtree'
Plugin 'fholgado/minibufexpl.vim'
Plugin 'gcmt/wildfire.vim'
Plugin 'sjl/gundo.vim'
Plugin 'Lokaltog/vim-easymotion'
Plugin 'suan/vim-instant-markdown'
Plugin 'lilydjwg/fcitx.vim'
" 插件列表结束
call vundle#end()
	    
"map <F2> :NERDTree<CR>
" 没有文件时自动关闭NERDTree
"autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTreeType") &&b:NERDTreeType == "primary") | q | endif
	    
" 当新建 .h .c .hpp .cpp .mk .sh等文件时自动调用SetTitle 函数
autocmd BufNewFile *.[ch],*.hpp,*.cpp,*.cc,Makefile,*.mk,*.sh exec ":call SetTitle()" 

func! SetComment()
	call setline(1,"/*================================================================") 
	call append(line("."),   "*   Copyright (C) Baidu Map Ltd. All rights reserved.")
	call append(line(".")+1, "*   ") 
	call append(line(".")+2, "*   文件名称：".expand("%:t")) 
	call append(line(".")+3, "*   创 建 者：wudonglin@baidu.com")
	call append(line(".")+4, "*   创建日期：".strftime("%Y年%m月%d日")) 
	call append(line(".")+5, "*   描    述：") 
	call append(line(".")+6, "*")
	call append(line(".")+7, "================================================================*/") 
	call append(line(".")+8, "")
	call append(line(".")+9, "")
	endfunc


func! SetComment_sh()
	call setline(3, "#================================================================") 
	call setline(4, "#   Copyright (C) ".strftime("%Y")." Baidu Map Ltd. All rights reserved.")
	call setline(5, "#   ") 
	call setline(6, "#   文件名称：".expand("%:t")) 
	call setline(7, "#   创 建 者：wudonglin@baidu.com")
	call setline(8, "#   创建日期：".strftime("%Y年%m月%d日")) 
	call setline(9, "#   描    述：") 
	call setline(10, "#")
	call setline(11, "#================================================================")
	call setline(12, "")
	call setline(13, "")
	endfunc 

func! SetTitle()
    if &filetype == 'make' 
        call setline(1,"") 
        call setline(2,"")
        call SetComment_sh()
    elseif &filetype == 'sh' 
        call setline(1,"#!/system/bin/sh") 
        call setline(2,"")
        call SetComment_sh()

    else
        call SetComment()
        if expand("%:e") == 'hpp'
            call append(line(".")+10, "#ifndef _".toupper(expand("%:t:r"))."_H") 
            call append(line(".")+11, "#define _".toupper(expand("%:t:r"))."_H") 
            call append(line(".")+12, "#ifdef __cplusplus") 
            call append(line(".")+13, "extern \"C\"") 
            call append(line(".")+14, "{") 
            call append(line(".")+15, "#endif") 
            call append(line(".")+16, "") 
            call append(line(".")+17, "#ifdef __cplusplus") 
            call append(line(".")+18, "}") 
            call append(line(".")+19, "#endif") 
            call append(line(".")+20, "#endif //".toupper(expand("%:t:r"))."_H") 

        elseif expand("%:e") == 'h'
            call append(line(".")+10, "#ifndef _".toupper(expand("%:t:r"))."_H") 
            call append(line(".")+11, "#define _".toupper(expand("%:t:r"))."_H") 
            call append(line(".")+12, "") 
            call append(line(".")+13, "#endif //".toupper(expand("%:t:r"))."_H") 
            
        endif
    endif
endfunc
