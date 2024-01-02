section .data
    blackCell    db 'x', 0x00
    blackCellLen equ $ - blackCell
    whiteCell    db ' '
    whiteCellLen equ $ - whiteCell
    newLine      db 0x0A, 0x00
    newLineLen   equ $ - newLine
    endLine      db 10, 0x00 ; end of line
    endLineLen   equ $ - endLine

    boardRows equ 5
    boardCols equ 5
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
    xor rcx, rcx
    mov cx, boardRows
    ; push stack frame
    rowLoop:
        push rcx 
        mov cx, boardCols
        colLoop:
            push rcx

            mov al, [rbx]
            cmp al, aliveRepr
            je alive
            jmp dead

            alive: 
                mov rax, 1
                mov rdi, 1 ; stdout
                mov rsi, whiteCell
                mov rdx, whiteCellLen
                syscall
                jmp next

            dead: 
                mov rax, 1
                mov rdi, 1
                mov rsi, blackCell
                mov rdx, blackCellLen
                syscall
                jmp next


            next:
                inc rbx ; next cell
                pop rcx
        loop colLoop 
        mov rax, 1
        mov rdi, 1
        mov rsi, endLine
        mov rdx, endLineLen
        syscall

        pop rcx
    loop rowLoop
    ret