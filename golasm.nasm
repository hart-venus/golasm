section .data
    boardRows equ 20
    boardCols equ 20
    boardSize equ (boardRows * boardCols)

section .bss
    board resb boardSize
    board2 resb boardSize

section .text
    global _start

    _start:


    exit:
        mov eax, 60
        xor edi, edi ; exit code 0
        syscall