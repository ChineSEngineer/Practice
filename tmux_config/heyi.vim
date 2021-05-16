let g:airline#themes#heyi#palette = {}

let g:airline#themes#heyi#palette.accents = {
      \ 'red': [ '#66d9ef' , '' , 81 , '' , '' ],
      \ }

" Normal Mode:
let s:N1 = [ '#585858' , '#e4e4e4' , 0 , 231 ] " Mode
let s:N2 = [ '#e4e4e4' , '#0087af' , 255 , 237 ] " Info
let s:N3 = [ '#eeeeee' , '#005f87' , 255 , 235 ] " StatusLine


let g:airline#themes#heyi#palette.normal = airline#themes#generate_color_map(s:N1, s:N2, s:N3)
let g:airline#themes#heyi#palette.normal_modified = {
      \ 'airline_c': [ '#eeeeee' , '#005f87' , 255 , 235 , '' ] ,
      \ }


" Insert Mode:
let s:I1 = [ '#585858' , '#e4e4e4' , 0 , 231 ] " Mode
let s:I2 = [ '#e4e4e4' , '#0087af' , 255 , 237 ] " Info
let s:I3 = [ '#eeeeee' , '#005f87' , 255 , 235 ] " StatusLine


let g:airline#themes#heyi#palette.insert = airline#themes#generate_color_map(s:I1, s:I2, s:I3)
let g:airline#themes#heyi#palette.insert_modified = {
      \ 'airline_c': [ '#eeeeee' , '#005f87' , 255 , 235 , '' ] ,
      \ }


" Replace Mode:
let g:airline#themes#heyi#palette.replace = copy(g:airline#themes#heyi#palette.insert)
let g:airline#themes#heyi#palette.replace.airline_a = [ '#d7005f'   , '#e4e4e4' , 161 , 231, ''     ]
let g:airline#themes#heyi#palette.replace_modified = {
      \ 'airline_c': [ '#eeeeee' , '#005f87' , 255 , 235 , '' ] ,
      \ }


" Visual Mode:
let s:V1 = [ '#005f87', '#e4e4e4', 0,  231 ]
let s:V2 = [ '',        '#0087af', 255, 237 ]
let s:V3 = [ '#e4e4e4', '#005f87', 255, 235 ]

let g:airline#themes#heyi#palette.visual = airline#themes#generate_color_map(s:V1, s:V2, s:V3)
let g:airline#themes#heyi#palette.visual_modified = {
      \ 'airline_c': [ '#e4e4e4', '#005f87', 255, 235  ] ,
      \ }

" Inactive:
let s:IA = [ '#585858' , '#e4e4e4' , 240 , 247 , '' ]
let g:airline#themes#heyi#palette.inactive = airline#themes#generate_color_map(s:IA, s:IA, s:IA)
let g:airline#themes#heyi#palette.inactive.airline_c = s:N2
let g:airline#themes#heyi#palette.inactive_modified = {
      \ 'airline_c': [ '#585858' , '#e4e4e4' , 240 , 247 , '' ] ,
      \ }


" CtrlP:
if !get(g:, 'loaded_ctrlp', 0)
  finish
endif
let g:airline#themes#heyi#palette.ctrlp = airline#extensions#ctrlp#generate_color_map(
      \ [ '#e4e4e4' , '#005f87' , 0 , 231  , ''     ] ,
      \ [ '#e4e4e4' , '#0087af' , 255 , 237  , ''     ] ,
      \ [ '#585858' , '#e4e4e4' , 240 , 231 , 'bold' ] )

