section .data
    blackCell    db 0xE2, 0xAC, 0x9B, 0x00 ; black square emoji 
    blackCellLen equ $ - blackCell
    whiteCell    db 0xE2, 0xAC, 0x9C, 0x00 ; white square emoji
    whiteCellLen equ $ - whiteCell
    newLine      db 0x0A, 0x00
    newLineLen   equ $ - newLine

    boardRows equ 20
    boardCols equ 20
    boardSize equ (boardRows * boardCols)

    aliveRepr equ 0x01 ; alive cell representation
    deadRepr  equ 0x00 ; dead cell representation

section .bss
    board resb boardSize
    board2 resb boardSize

section .text
    global _start

    _start:
        call printBoard
    exit:
        mov eax, 60
        xor edi, edi ; exit code 0
        syscall

printBoard: 

    ; print black square emoji
    mov rax, 1
    mov rdi, 1
    mov rsi, blackCell
    mov rdx, blackCellLen
    syscall

    ret 