.MODEL SMALL
.STACK 100H
.DATA

TEMP DW ?
N1 DW ?
N2 DW ?
F DW ?

.CODE

MAIN PROC
    MOV AX, @DATA
    MOV DS, AX 
    
    XOR AX,AX
    XOR BX,BX 
    
    
INPUT1:
    MOV AH,1
    INT 21H    
    MOV AH, 0    
    
    CMP AL," "
    JE INPUT2 
    
    SUB AL, '0'
    
    MOV TEMP, BX
    MOV CX,9 
    
    A:
    ADD BX,TEMP
    LOOP A
    
    ADD BX, AX  
    
    MOV N1,BX
    JMP INPUT1 
    
    
    
INPUT2:
    XOR BX,BX
    
    I2:
    
    MOV AH,1
    INT 21H    
    MOV AH, 0    
    
    CMP AL," "
    JE L 
    
    SUB AL, '0'
    
    MOV TEMP, BX
    MOV CX,9 
    
    B:
    ADD BX,TEMP
    LOOP B
    
    ADD BX, AX  
    
    MOV N2,BX
    JMP I2 
    

 
L:  
 
    WHILE_LOOP:
    
	CMP N1, BX 
	JG END_WHILE
	
	XOR AX,AX
	XOR DX,DX
	
	MOV AX,N1
	MOV DX,1
	
	INNERLOOP:
	 
	CMP AX, 1
	JZ L2
	 
	TEST AX,1 
	JZ EVEN   ;EVEN
	JNZ ODD  ;ODD
		
	
L2:	
    ;INC DX
	INC N1
	
	CMP DX, F
	JG UPDATE
	
	JMP WHILE_LOOP
	
	
EVEN:

       ;AX = AX/2
    MOV CL,1       
    SHR AX,CL
    INC DX
    JMP INNERLOOP


ODD:

    MOV TEMP,AX
             ;AX = 3AX+1
    ADD AX,TEMP
    ADD AX,TEMP 
    ;ADD AX,TEMP
    ADD AX,1

    INC DX
    JMP INNERLOOP


UPDATE:

    MOV F,DX
    JMP WHILE_LOOP
	


	
END_WHILE:


    MOV AX,F
	PUSH AX
    PUSH BX
    PUSH CX
    PUSH DX

	XOR CX,CX
    MOV BX,10D

 L3:
    
    XOR DX,DX
    DIV BX
    PUSH DX
    INC CX

    OR AX,AX
    JNE L3

    MOV AH,2

 PRINT:
    POP DX
    OR DL,30H
    INT 21H
    LOOP PRINT

    POP DX
    POP CX
    POP BX
    POP AX
 
    
    MOV AH,4CH
    INT 21H
    MAIN ENDP
END MAIN