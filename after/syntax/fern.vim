" Vim syntax file
" Language: fern

"------------------------------------------------------
" syntax
"------------------------------------------------------
syn match  fernCPP          ".*.cpp\ze.*$"
syn match  fernC            ".*.c\ze.*$"
syn match  fernH            ".*.h\ze.*$"
syn match  fernPY           ".*.py\ze.*$"
syn match  fernSH           ".*.sh\ze.*$"
syn match  fernVIM          ".*.vim\ze.*$"
syn match  fernHTML         ".*.html\ze.*$"
syn match  fernMD           ".*.md.html\ze.*$"
syn match  fernMD           ".*.md\ze.*$"
syn match  fernGLB          ".*.glb\ze.*$"
syn match  fernCMakeLists   ".*CMakeLists.txt\ze.*$"
syn match  fernMakefile     ".*Makefile\ze.*$"
syn match  fernMakeSH       ".*make.*.sh\ze.*$"

syn match  fernPNG          ".*.png\ze.*$"
syn match  fernJPG          ".*.jpg\ze.*$"
syn match  fernBMP          ".*.bmp\ze.*$"
syn match  fernTIF          ".*.tif\ze.*$"
syn match  fernHDR          ".*.hdr\ze.*$"
syn match  fernEXR          ".*.exr\ze.*$"

"------------------------------------------------------
" highlight link
"------------------------------------------------------
hi link fernCPP             VisGreen
hi link fernC               VisGreen
hi link fernH               VisAqua
hi link fernPY              VisYellow
hi link fernSH              VisPurple
"hi link fernVIM             VisGreen
hi link fernHTML            VisPurple
hi link fernMD              VisYellow
hi link fernGLB             VisAqua
hi link fernCMakeLists      VisOrange
hi link fernMakefile        VisOrange
hi link fernMakeSH          VisOrange

hi link fernPNG             VisBlue
hi link fernJPG             VisBlue
hi link fernBMP             VisBlue
hi link fernTIF             VisBlue
hi link fernHDR             VisBlue
hi link fernEXR             VisBlue

hi link FernRootSymbol      VisRed
hi link FernRootText        VisRed
hi link FernBranchSymbol    VisRed
hi link FernBranchText      VisRed

