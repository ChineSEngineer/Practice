call plug#begin('~/.vim/plugged')

" Index
Plug 'ludovicchabant/vim-gutentags'
Plug 'skywind3000/gutentags_plus'
Plug 'skywind3000/vim-preview'

" Compile
Plug 'skywind3000/asyncrun.vim'

" Linter dynamic check
Plug 'dense-analysis/ale'

" Diff
Plug 'mhinz/vim-signify'

" Text object
Plug 'kana/vim-textobj-user'
Plug 'kana/vim-textobj-indent'
Plug 'kana/vim-textobj-syntax'
Plug 'kana/vim-textobj-function', { 'for':['c', 'cpp', 'vim', 'java'] }
Plug 'sgur/vim-textobj-parameter'

" Code Completion
Plug 'ycm-core/YouCompleteMe'

" Function list
Plug 'Yggdroot/LeaderF'

" Parameter prompt
Plug 'Shougo/echodoc.vim'

" Tools
Plug 'tpope/vim-unimpaired'
Plug 'vim-airline/vim-airline'
Plug 'octol/vim-cpp-enhanced-highlight'
Plug 'ChineSEngineer/a.vim'

call plug#end()



"-------------------------Gtags--------------------------
" gutentags 搜索工程目录的标志，当前文件路径向上递归直到碰到这些文件/目录名
let g:gutentags_project_root = ['.root', '.svn', '.git', '.hg', '.project']

" 所生成的数据文件的名称
let g:gutentags_ctags_tagfile = '.tags'

" 同时开启 ctags 和 gtags 支持：
let g:gutentags_modules = []
if executable('ctags')
	let g:gutentags_modules += ['ctags']
endif
if executable('gtags-cscope') && executable('gtags')
	let g:gutentags_modules += ['gtags_cscope']
endif

" 将自动生成的 ctags/gtags 文件全部放入 ~/.cache/tags 目录中，避免污染工程目录
let g:gutentags_cache_dir = expand('~/.cache/tags')

" 配置 ctags 的参数，老的 Exuberant-ctags 不能有 --extra=+q，注意
let g:gutentags_ctags_extra_args = ['--fields=+niazS', '--extra=+q']
let g:gutentags_ctags_extra_args += ['--c++-kinds=+px']
let g:gutentags_ctags_extra_args += ['--c-kinds=+px']

" 如果使用 universal ctags 需要增加下面一行，老的 Exuberant-ctags 不能加下一行
let g:gutentags_ctags_extra_args += ['--output-format=e-ctags']

" 禁用 gutentags 自动加载 gtags 数据库的行为
let g:gutentags_auto_add_gtags_cscope = 0


" set cscopetag " 使用 cscope 作为 tags 命令
set cscopeprg='gtags-cscope' " 使用 gtags-cscope 代替 cscope



"-------------------------vim-preview--------------------------
noremap <m-u> :PreviewScroll -1<cr>
noremap <m-d> :PreviewScroll +1<cr>
inoremap <m-u> <c-\><c-o>:PreviewScroll -1<cr>
inoremap <m-d> <c-\><c-o>:PreviewScroll +1<cr>

autocmd FileType qf nnoremap <silent><buffer> p :PreviewQuickfix<cr>
autocmd FileType qf nnoremap <silent><buffer> P :PreviewClose<cr>


"-------------------------asyncrun--------------------------
noremap <m-u> :PreviewScroll -1<cr>
" 自动打开 quickfix window ，高度为 6
let g:asyncrun_open = 6

" 任务结束时候响铃提醒
let g:asyncrun_bell = 1

" 设置根目录，如果没找到根目录，当前目录做为根目录
let g:asyncrun_rootmarks = ['.svn', '.git', '.root', '_darcs', 'build.xml']

" 设置 F10 打开/关闭 Quickfix 窗口
nnoremap <F10> :call asyncrun#quickfix_toggle(6)<cr>

" 设置F9编译单个文件
nnoremap <silent> <F9> :AsyncRun gcc -Wall -O2 "$(VIM_FILEPATH)" -o "$(VIM_FILEDIR)/$(VIM_FILENOEXT)" <cr>

" 设置F5运行单个文件
nnoremap <silent> <F5> :AsyncRun -raw -cwd=$(VIM_FILEDIR) "$(VIM_FILEDIR)/$(VIM_FILENOEXT)" <cr>

" F7编译整个项目,F8运行项目,F6测试项目,F4运行cmake .
nnoremap <silent> <F7> :AsyncRun -cwd=<root> make <cr>
nnoremap <silent> <F8> :AsyncRun -cwd=<root> -raw make run <cr>
nnoremap <silent> <F6> :AsyncRun -cwd=<root> -raw make test <cr>
nnoremap <silent> <F4> :AsyncRun -cwd=<root> cmake . <cr>




"-------------------------ale--------------------------
let g:ale_linters_explicit = 1
let g:ale_completion_delay = 500
let g:ale_echo_delay = 20
let g:ale_lint_delay = 500
let g:ale_lint_on_text_changed = 'normal'
let g:ale_lint_on_insert_leave = 1
let g:airline#extensions#ale#enabled = 1

let g:ale_c_gcc_options = '-Wall -O2 -std=c99'
let g:ale_cpp_gcc_options = '-Wall -O2 -std=c++14'
let g:ale_c_cppcheck_options = ''
let g:ale_cpp_cppcheck_options = ''

"始终开启标志列
let g:ale_sign_column_always = 1
let g:ale_set_highlights = 1
"自定义error和warning图标
let g:ale_sign_error = '❌'
let g:ale_sign_warning = '⚠️'
"在vim自带的状态栏中整合ale
let g:ale_statusline_format = ['✗ %d', '⚡ %d', '✔ OK']
"显示Linter名称,出错或警告等相关信息
let g:ale_echo_msg_error_str = 'E'
let g:ale_echo_msg_warning_str = 'W'
let g:ale_echo_msg_format = '[%linter%] %code: %%s [%severity%]'


"普通模式下，sp前往上一个错误或警告，sn前往下一个错误或警告
"nmap sp <Plug>(ale_previous_wrap)
"nmap sn <Plug>(ale_next_wrap)
"<Leader>s触发/关闭语法检查
"nmap <Leader>s :ALEToggle<CR>
"<Leader>d查看错误或警告的详细信息
"nmap <Leader>d :ALEDetail<CR>
"set statusline=%F%m%r%h%w\ [FORMAT=%{&ff}]\ [TYPE=%Y]\ [POS=%l,%v][%p%%]\ %{strftime(\"%d/%m/%y\ -\ %H:%M\")}\ %{ALEGetStatusLine()}
"
let g:ale_linters = {
\   'cpp': ['gcc', 'cppcheck'],
\   'c': ['gcc'],
\   'python': ['pylint'],
\}

highlight clear ALEErrorSign
highlight clear ALEWarningSign
highlight SignColumn ctermbg=none

" highlight ALEWarning ctermbg=DarkMagenta
" highlight ALEError ctermbg=DarkMagenta
" highlight ALEError ctermbg=none cterm=underline
" highlight ALEWarning ctermbg=none cterm=underline
" highlight ALEError guibg=green ctermbg=green cterm=undercurl
" highlight ALEWarning guibg=green ctermbg=green cterm=undercurl




"-------------------------YouCompleteMe--------------------------
let g:ycm_add_preview_to_completeopt = 0 
let g:ycm_show_diagnostics_ui = 0 
let g:ycm_server_log_level = 'info'
let g:ycm_min_num_identifier_candidate_chars = 2 
let g:ycm_collect_identifiers_from_comments_and_strings = 1 
let g:ycm_complete_in_strings=1
"let g:ycm_key_invoke_completion = '<c-z>'
let g:ycm_disable_signature_help = 1 
let g:ycm_auto_hover = ''
let g:ycm_confirm_extra_conf = 0
let g:ycm_global_ycm_extra_conf = '~/.vim/.ycm_extra_conf.py'

set completeopt=menu,menuone

if has('patch-8.0.1000')
        set completeopt+=noselect
endif

if exists('+completepopup')
        set completepopup=align:menu,border:off,highlight:WildMenu
        set completepopup=align:menu,border:off,highlight:QuickPreview
        set completeopt+=popup
endif


let g:ycm_semantic_triggers =  {
                        \ 'c,cpp,python,java,go,erlang,perl': ['re!\w{2}'],
                        \ 'cs,lua,javascript': ['re!\w{2}'],
                        \ }

let g:ycm_goto_buffer_command = 'new-or-existing-tab'

let g:ycm_filetype_whitelist = {
                        \ "c":1,
                        \ "cpp":1,
                        \ "objc":1,
                        \ "objcpp":1,
                        \ "python":1,
                        \ "java":1,
                        \ "javascript":1,
                        \ "coffee":1,
                        \ "vim":1,
                        \ "go":1,
                        \ "cs":1,
                        \ "lua":1,
                        \ "perl":1,
                        \ "perl6":1,
                        \ "php":1,
                        \ "ruby":1,
                        \ "rust":1,
                        \ "erlang":1,
                        \ "asm":1,
                        \ "nasm":1,
                        \ "masm":1,
                        \ "tasm":1,
                        \ "asm68k":1,
                        \ "asmh8300":1,
                        \ "asciidoc":1,
                        \ "basic":1,
                        \ "vb":1,
                        \ "make":1,
                        \ "cmake":1,
                        \ "html":1,
                        \ "css":1,
                        \ "less":1,
                        \ "json":1,
                        \ "cson":1,
                        \ "typedscript":1,
                        \ "haskell":1,
                        \ "lhaskell":1,
                        \ "lisp":1,
                        \ "scheme":1,
                        \ "sdl":1,
                        \ "sh":1,
                        \ "zsh":1,
                        \ "bash":1,
                        \ "man":1,
                        \ "markdown":1,
                        \ "matlab":1,
                        \ "maxima":1,
                        \ "dosini":1,
                        \ "conf":1,
                        \ "config":1,
                        \ "zimbu":1,
                        \ "ps1":1,
                        \ }




"-------------------------LeaderF--------------------------
noremap <m-p> :cclose<cr>:Leaderf! --nowrap function<cr>
 



"-------------------------echodoc--------------------------
set noshowmode
let g:echodoc_enable_at_startup = 1



"-------------------------vim-cpp-enhanced-highlight--------------------------
let g:cpp_class_scope_highlight = 1
let g:cpp_member_variable_highlight = 1
let g:cpp_concepts_highlight = 1
let g:cpp_experimental_simple_template_highlight = 1
"文件较大时使用下面的设置高亮模板速度较快，但会有一些小错误
"let g:cpp_experimental_template_highlight = 1






"-------------------------functions--------------------------
" Enable ALT
function! Terminal_MetaMode(mode)
    set ttimeout
    if $TMUX != ''
        set ttimeoutlen=30
    elseif &ttimeoutlen > 80 || &ttimeoutlen <= 0
        set ttimeoutlen=80
    endif
    if has('nvim') || has('gui_running')
        return
    endif
    function! s:metacode(mode, key)
        if a:mode == 0
            exec "set <M-".a:key.">=\e".a:key
        else
            exec "set <M-".a:key.">=\e]{0}".a:key."~"
        endif
    endfunc
    for i in range(10)
        call s:metacode(a:mode, nr2char(char2nr('0') + i))
    endfor
    for i in range(26)
        call s:metacode(a:mode, nr2char(char2nr('a') + i))
        call s:metacode(a:mode, nr2char(char2nr('A') + i))
    endfor
    if a:mode != 0
        for c in [',', '.', '/', ';', '[', ']', '{', '}']
            call s:metacode(a:mode, c)
        endfor
        for c in ['?', ':', '-', '_']
            call s:metacode(a:mode, c)
        endfor
    else
        for c in [',', '.', '/', ';', '{', '}']
            call s:metacode(a:mode, c)
        endfor
        for c in ['?', ':', '-', '_']
            call s:metacode(a:mode, c)
        endfor
    endif
endfunc

call Terminal_MetaMode(0)




"-------------------------regular--------------------------
" quickfix窗口跳转，如果该文件已经打开，切换到其窗口，否则新窗口显示
set switchbuf=useopen,usetab,newtab
set number
"set ruler
set hlsearch
syntax on

" Tab长度是4
set tabstop=4
" 括号后的自动缩进是四格
set shiftwidth=4
" 缩进用空格表示
set expandtab
" 具体见:https://segmentfault.com/a/1190000021133524 这里使用它，让BS可以一次删除shiftwidth个空格
set softtabstop=-1


hi CursorLine term=bold cterm=bold guibg=Grey40
let &t_ti.="\e[1 q"
let &t_SI.="\e[5 q"
let &t_EI.="\e[1 q"
let &t_te.="\e[0 q"

set tags=./.tags;,.tags

colorscheme molokai
