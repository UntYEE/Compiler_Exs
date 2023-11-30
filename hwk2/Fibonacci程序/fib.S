@ 数据段
.data
m:      .word 0
b:      .word 1
i:      .word 1
t:      .word 0
n:      .word 0

@ 代码段
.text
.align 4
res:    .asciz "fibonacci: %d\n"
info:   .asciz "Please input the number of Fibonacci: "
input_prompt:  .asciz "%d"
.align 4

@ 主函数
.global main
.type main, %function
main:
    @ mov r7, lr
    push {fp, lr}   @ 返回地址和栈基地址

input:
    adr r0, info     @ 读取字符串 info 地址
    bl printf        @ 调用 printf 函数
    mov r8, lr

    adr r0, input_prompt    @ 准备读取输入的格式化字符串
    sub sp, sp, #4   @ 留出一个4字节的空间，用于保存用户输入
    mov r1, sp
    bl scanf

    ldr r2, [sp, #0] @ 读取用户输入的整数 n
    ldr r1, addr_n
    str r2, [r1]     
    add sp, sp, #4
    mov lr, r8

.params:
    mov r0, r2       @ 设置函数参数为用户输入的 n
    ldr r4, addr_i
    ldr r4, [r4]     
    ldr r3, addr_b
    ldr r3, [r3]     
    ldr r6, addr_m
    ldr r6, [r6]     

.LOOP1:
    mov r5, r3       @ t = b
    add r3, r3, r6   @ b = m + b
    push {r0, r1, r2, r3}
    adr r0, res       @ 准备 printf 的参数
    mov r1, r3
    bl printf         @ 调用 printf 函数
    pop {r0, r1, r2, r3}

    mov r6, r5       @ m = t
    add r4, #1       @ i = i + 1
    cmp r4, r0       @ 判断 i 与 n 的大小关系，
                     @当 i < n 时跳转至.LOOP1 继续循环
    bne .LOOP1         




.end:
    @ mov lr, r7
    @ bx lr

@全局变量地址
addr_m: .word m
addr_b: .word b
addr_i: .word i
addr_t: .word t
addr_n: .word n

.section .note.GNU-stack, "", %progbits
