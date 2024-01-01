section .data
    blackCell    db ' ', 0x00
    blackCellLen equ $ - blackCell
    whiteCell    db '█', 0x00
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
        mov eax, 0x3C ; exit syscall
        xor edi, edi ; exit code 0
        syscall

printBoard: 
    lea rbx, [board]
    mov cx, boardRows
    ; push stack frame
    rowLoop:
        push cx 
        mov cx, boardCols
        colLoop:
            push cx

            mov al, [rbx]
            cmp al, aliveRepr
            je alive
            jmp dead

            alive: 
                mov rax, 1
                mov rdi, 1 ; stdout
                mov rsi, whiteCell
                mov rdx, whiteCellLen
                ;syscall
                jmp next

            dead: 
                mov rax, 1
                mov rdi, 1
                mov rsi, whiteCell
                mov rdx, whiteCellLen
                ;syscall
                jmp next


            next:
                inc rbx ; next cell
                pop cx
        loop colLoop 

        pop cx
    loop rowLoop
    ret