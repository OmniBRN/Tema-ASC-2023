.data    
    m: .space 4
    n: .space 4
    mOld: .space 4
    nOld: .space 4
    p: .space 4
    x: .space 4
    y: .space 4
    k: .space 4
    interatia: .long 0
    i: .long 1
    j: .long 1
    unu: .long 1
    doi: .long 2
    trei: .long 3
    viata: .space 4
    nrVecinii: .long 0
    indexCurent: .space 4
    matrix: .zero 1600
    matrixNew: .zero 1600
    ofile: .space 4
    ifile: .space 4
    ifilename: .asciz "in.txt"
    ofilename: .asciz "out.txt"
    write: .asciz "w"
    read: .asciz "r"
    formatScanf: .asciz "%d"
    formatPrintf: .asciz "%d "
    endl: .asciz "\n"
.text
.global main

str_to_long:

    push %ebp
    movl %esp, %ebp
    push %edi
    push %ebx
    
    
    movl 8(%ebp), %edi
    movl 12(%ebp), %ebx
    xor %eax, %eax
    xor %ecx, %ecx
    proc_for:
        cmp %ecx, %ebx
        je proc_cont
        push %ebx
        movl $10, %ebx
        mull %ebx
        movb (%edi, %ecx, 1), %bl
        subl $'0', %ebx
        addl %ebx, %eax
        pop %ebx
        incl %ecx
        jmp proc_for
    proc_cont:
    pop %ebx
    pop %edi
    pop %ebp
    ret 

main:

    push $read
    push $ifilename
    call fopen
    addl $8, %esp
    movl %eax, ifile

    
    push $m
    push $formatScanf
    push ifile

    call fscanf
    addl $8, %esp
    
    push $n
    push $formatScanf
    push ifile
    call fscanf
    addl $12, %esp

    movl m, %eax
    movl %eax, mOld
    incl mOld
    addl $2, m
    movl n, %eax
    movl %eax, nOld
    incl nOld
    addl $2, n

    
    push $p
    push $formatScanf
    push ifile
    call fscanf
    addl $12, %esp
    
    xor %ecx, %ecx

et_1:
    cmp %ecx, p
    je et_2

    push %ecx

    push $x
    push $formatScanf
    push ifile
    call fscanf
    addl $12, %esp
test1:
    
    push $y
    push $formatScanf
    push ifile
    call fscanf
    addl $12, %esp
test2:

    
    lea matrix, %edi

    incl x
    incl y
    movl x, %eax
    mull n
    addl y, %eax
    movl $1, (%edi, %eax, 4)    
    
    pop %ecx
    incl %ecx
    jmp et_1


et_calcVecinii:

    movl indexCurent, %eax

    subl n, %eax
    movl (%edi, %eax, 4), %ebx
    addl %ebx, nrVecinii

    subl $1, %eax
    movl (%edi, %eax, 4), %ebx
    addl %ebx, nrVecinii

    addl $2, %eax
    movl (%edi, %eax, 4), %ebx
    addl %ebx, nrVecinii

    addl n, %eax
    movl (%edi, %eax, 4), %ebx
    addl %ebx, nrVecinii

    subl $2, %eax
    movl (%edi, %eax, 4), %ebx
    addl %ebx, nrVecinii

    addl n, %eax
    movl (%edi, %eax, 4), %ebx
    addl %ebx, nrVecinii

    addl $2, %eax
    movl (%edi, %eax, 4), %ebx
    addl %ebx, nrVecinii

    subl $1, %eax
    movl (%edi, %eax, 4), %ebx
    addl %ebx, nrVecinii

    subl n, %eax

    jmp et_intoarcere_3_1

et_MN1:
    lea matrixNew, %edi
    movl indexCurent, %eax
    movl $1, (%edi, %eax, 4)
    jmp et_intoarcere_3_2

et_MN2:
    lea matrixNew, %edi
    movl indexCurent, %eax
    movl $0, (%edi, %eax, 4)
    jmp et_intoarcere_3_2

et_moarte:

    movl nrVecinii, %ebx
    cmp %ebx, trei
    je et_MN1
    jne et_MN2

et_viata:

    movl nrVecinii, %ebx
    cmp doi, %ebx
    jl et_MN2
    cmp trei, %ebx
    jg et_MN2
    jmp et_MN1

et_2:
    
    push $k
    push $formatScanf
    push ifile
    call fscanf 
    addl $12, %esp

    push ifile
    call fclose
    addl $4, %esp

    push $write
    push $ofilename
    call fopen
    addl $8, %esp

    movl %eax, ofile


et_3:
    movl interatia, %ecx
    cmp %ecx, k
    je et_bruh
    movl $1, i
    movl $1, j

        et_3_1:
            movl i, %ecx
            cmp %ecx, mOld
            je et_3_cont
                et_3_1_1:
                    movl j, %ecx
                    cmp %ecx, nOld
                    je et_3_1_cont
                    
                    movl n, %eax
                    mull i
                    addl j, %eax

                    movl %eax, indexCurent
                    movl (%edi, %eax, 4), %ebx
                    movl %ebx, viata

                    jmp et_calcVecinii

                    et_intoarcere_3_1:

                        movl viata, %eax
                        cmp %eax, unu
                        je et_viata
                        jne et_moarte

                    et_intoarcere_3_2:
                        lea matrix, %edi
                        incl j
                        movl $0, nrVecinii
                        jmp et_3_1_1
        et_3_1_cont:
            incl i
            movl $1, j
            jmp et_3_1


    et_3_cont:
        movl $1, i
        movl $1, j
            et_3_2:
                movl i, %ecx
                cmp %ecx, mOld
                je et_3_cont_cont
                    et_3_2_1:
                        movl j, %ecx
                        cmp %ecx, nOld
                        je et_3_2_cont
                        movl n, %eax
                        mull i
                        addl j, %eax

                        lea matrixNew, %edi
                        movl (%edi, %eax, 4), %ebx
                        lea matrix, %edi
                        movl %ebx, (%edi, %eax, 4)


                        incl j
                        jmp et_3_2_1
            et_3_2_cont:
                incl i
                movl $0, j
                jmp et_3_2
    et_3_cont_cont:
        incl interatia
        jmp et_3

et_bruh:
    movl $1, i
    movl $1, j

et_for:
    movl i, %ecx
    cmp %ecx, mOld
    je et_end
    et_for2:
        movl j, %ecx
        cmp %ecx, nOld
        je et_forcont
        movl n, %eax
        mull i
        addl j, %eax
        movl (%edi, %eax, 4), %eax

        push %eax
        push $formatPrintf
        push ofile
        call fprintf
        addl $12, %esp

        incl j
        jmp et_for2

et_forcont:

    push $endl
    push ofile
    call fprintf
    pop %ecx

    movl $1, j
    incl i
    jmp et_for

et_end:

    push ofile
    call fclose
    addl $4, %esp

    mov $1, %eax
    mov $0, %ebx
    int $0x80
