.data
n:      .word 0
result: .word 0

.text
.align 4
res:    .asciz "Fibonacci(%d) = %d\n"
input_prompt:  .asciz "Enter the value of n: "
.align 4

.global main
.type main, %function
main:
    push {fp, lr}   @ 保存返回地址和栈基地址

input:
    adr r0, input_prompt    @ 读取输入提示字符串地址
    bl printf              @ 调用 printf 函数输出提示消息

    sub sp, sp, #4   @ 留出一个4字节的空间，用于保存用户输入
    mov r1, sp
    bl scanf

    ldr r2, [sp]     @ 读取用户输入的整数 n
    str r2, [n]      @ 将 n 保存到对应的地址中

    mov r0, r2       @ 设置函数参数为用户输入的 n
    bl fibonacci     @ 调用计算斐波那契数列的函数

    ldr r1, [result] @ 读取计算结果
    adr r0, res      @ 准备 printf 的参数
    bl printf         @ 调用 printf 函数

    mov r0, #0       @ return 0; r0 存储函数返回值

    pop {fp, pc}     @ 返回

fibonacci:
    push {fp, lr}    @ 保存返回地址和栈基地址

    ldr r1, [n]      @ 读取 n 的值
    mov r2, #0       @ 初始化斐波那契数列的第0项
    mov r3, #1       @ 初始化斐波那契数列的第1项

    cmp r1, #0       @ 如果 n <= 0，则直接返回0
    ble .end

.loop:
    add r4, r2, r3   @ 计算下一项斐波那契数
    mov r2, r3       @ 更新前两项的值
    mov r3, r4
    subs r1, r1, #1  @ 减少 n 的值
    bne .loop

.end:
    str r2, [result] @ 将计算结果保存到 result
    pop {fp, pc}     @ 返回

.section .note.GNU-stack, "", %progbits

