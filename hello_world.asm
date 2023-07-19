bits 64
default rel

segment .data
    msg db "Hello world!", 0xd, 0xa, 0 ; Message to print
    numbers dq 1, 2, 3, 4, 5   ; Array of numbers
    numbers_format db "%d", 0xd, 0xa, 0 ; Format string for printf

segment .text
global main

extern ExitProcess
extern printf

print_number:
    mov    rdx, rax           ; Move the value to rdx for printf
    mov    rcx, numbers_format ; Load the format string into rcx
    mov    rax, 0              ; Clear rax before calling printf
    call   printf
    ret

main:
    push    rbp
    mov     rbp, rsp
    sub     rsp, 32

    lea     rcx, [msg]
    call    printf

    mov     rcx, 0              ; Initialize the loop counter to 0
    mov     rdi, numbers        ; Load address of the array into rdi
    mov     rsi, 5              ; Set the number of elements in the array

loop_start:
    cmp     rcx, rsi            ; Compare loop counter with the number of elements
    jge     loop_end            ; If the loop counter is greater or equal, exit the loop

    mov     rax, qword [rdi + rcx * 8] ; Load the value at the current index (rcx * 8 because each element is 8 bytes)

    mov rbx, rcx                ; Move the value of rcx to rbx, preserving the loop counter

    ; Process the value here
    mov    rdx, rax            ; Move the value to rdx for printf
    mov    rcx, numbers_format ; Load the format string into rcx
    mov    rax, 0              ; Clear rax before calling printf
    call   printf
    ; End of processing

    mov rcx, rbx               ; Move the value of rbx to rcx, restoring the loop counter

    inc     rcx                 ; Increment the loop counter
    jmp     loop_start          ; Jump back to the loop start

loop_end:
    mov rax, 0
    call    ExitProcess