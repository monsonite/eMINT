.org $00

;	RELEASE & VERSION NUMBERS
;
FIGREL	EQU	1	; FIG RELEASE #
FIGREV	EQU	1	; FIG REVISION #
USRVER	EQU	0	; USER VERSION #
;
;	ASCII CHARACTERS USED
;
ABL	EQU	20H	; SPACE
ACR	EQU	0DH	; CARRIAGE RETURN
ADOT	EQU	02EH	; PERIOD
BELL	EQU	07H	; (^G)
BSIN	EQU	7FH	; INPUT BACKSPACE CHR = RUBOUT
BSOUT	EQU	08H	; OUTPUT BACKSPACE (^H)
DLE	EQU	10H	; (^P)
LF	EQU	0AH	; LINE FEED
FF	EQU	0CH	; FORM FEED (^L)
;
;	MEMORY ALLOCATION
;
EM	EQU	4000H	; TOP OF MEMORY + 1 = LIMIT
NSCR	EQU	1	; NUMBER OF 1024 BYTE SCREENS
KBBUF	EQU	128	; DATA BYTES PER DISK BUFFER
US	EQU	40H	; USER VARIABLES SPACE
RTS	EQU	0A0H	; RETURN STACK & TERM BUFF SPACE
;
CO	EQU	KBBUF+4	; DISK BUFFER + 2 HEADER + 2 TAIL
NBUF	EQU	NSCR*400H/KBBUF	; NUMBER OF BUFFERS
BUF1	EQU	EM-CO*NBUF	; ADDR FIRST DISK BUFFER
INITR0	EQU	BUF1-US		; (R0)
INITS0	EQU	INITR0-RTS	; (S0)

	DW	INITS0	; INIT (S0)
	DW	INITR0	; INIT (R0)

UP	DW	INITR0	; USER AREA POINTER
RPP	DW	INITR0	; RETURN STACK POINTER


UpdatePage = 	1200h 					; code to do ld (hl),x goes here+misc
;	MUST BE IN SAME ORDER AS USER VARIABLES


       
   

       
		



EXEC:
    POP	HL						; (3t)	(HL) <- (S1) = CFA
	LD	E,(HL)				    ; (2t)	(PC) <- ((W))
	INC HL						; (1t)
	LD	D,(HL)					; (2t)
	EX DE,HL					; (1t)
	JP (HL)		    			; (3t)  NOTE: (DE) = CFA+1
	
	


	
BRAN1:	
    LD	H,B						; (1t)	(HL) <- (IP)
	LD	L,C						; (1t)
	LD	E,(HL)					; (2t)	(DE) <- ((IP)) = BRANCH OFFSET
	INC HL						; (1t)
	LD	D,(HL)					; (2t)
	DEC HL						; (1t)
	ADD HL,DE					; (1t)		(HL) <- (HL) + ((IP))
	LD	C,L						; (1t)		(IP) <- (HL)
	LD	B,H						; (1t)
	JR NEXT						; (3t)
	
ZBRAN:
    POP	HL						; (3t)
	LD	A,L						; (1t)
	OR	H						; (1t)
	JR Z, BRAN1					; (3t)		IF (S1)=0 THEN BRANCH
	INC BC						; (1t)		ELSE SKIP BRANCH OFFSET
	INC BC						; (1t)
	JR NEXT						; (3t)

LIT:
    LD A,(BC)	    			; (2t)	(HL) <- ((IP)) = LITERAL
	INC BC	        			; (1t)	(IP) <- (IP) + 2
	LD L,A	        			; (1t)		LB
	LD A,(BC)	    			; (2t)		HB
	INC BC						; (1t)
	LD	H,A						; (1t)
    JR HPUSH	        		; (3t) 	(S1) <- (HL)
	
	


SPSTO:

    LD	HL,(UP)	    ; (5t)	(HL) <- USER VAR BASE ADDR
	LD	DE,6		; (2t)
	ADD HL,DE       ; (1t)	(HL) <- S0
	LD	E,(HL)	    ; (2t)	(DE) <- (S0)
	INC HL			; (1t)
	LD	D,(HL)		; (2t)
	EX DE,HL		; (1t)	
	LD SP,HL		; (1t)	(SP) <- (S0)
	JR NEXT			; (3t)
;
	
RPAT:
    LD	HL,(RPP)	; (5t)(HL) <- USER VAR BASE ADDR
	JR HPUSH		; (3t)
	
;
RPSTO:

    LD  HL,	(UP)	; (5t)	(HL) <- USER VARIABLE BASE ADDR
	LD	DE,8		; (2t)
	ADD HL,DE	    ; (1t)	(HL) <- R0
	LD	E,(HL)	    ; (2t)	(DE) <- (R0)
	INC HL			; (1t)
	LD	D,(HL)		; (2t)
	EX DE,HL		; (1t)
	LD (RPP),HL	    ; (5t)	(RP) <- (R0)
	JR NEXT			; (3t)
;

CSTOR:							;((S1))LB <- (S2)LB
	    POP	HL						; (3t) (HL) <- (S1) = ADDR
	    POP	DE						; (3t) (DE) <- (S2) = BYTE
	    LD	(HL),E					; (2t) ((HL))LB <- (E)
	    JR   NEXT					; (3t)     

SEMIS:
    LD HL,(RPP)		; (5t)
	LD	C,(HL)	    ; (2t)	(BC) <- (R1)
	INC HL			; (1t)
	LD	B,(HL)		; (2t)
	INC HL			; (1t)
	LD (RPP),HL	    ; (5t)	(RP) <- (RP) + 2
	JR NEXT			; (3t)

TOR:

    POP	DE	        ; (3t) (DE) <- (S1)
	LD HL,(RPP)		; (5t)
	DEC HL	        ; (1t) (RP) <- (RP) - 2
	DEC HL			; (1t)
	LD (RPP),HL		; (5t)	 	
	LD	(HL),E	    ; (2t)	((HL)) <- (DE)
	INC HL			; (1t)
	LD	(HL),D		; (2t)
	JR NEXT			; (3t)
;
FROMR:

    LD HL,(RPP)		; (5t)		
	LD	E,(HL)		; (2t)	(DE) <- (R1)
	INC HL			; (1t)
	LD	D,(HL)		; (2t)
	INC HL			; (1t)
	LD (RPP),HL		; (5t)	(RP) <- (RP) + 2
	PUSH	DE		; (3t)	(S1) <- (DE)
	JR NEXT			; (3t)
;


ZEQU:
	POP	HL	    	; (3t)	(HL) <- (S1)
	LD	A,L			; (1t)
	OR	H	    	; (1t)	IF (HL) = 0
	LD	HL,0		; (3t)	THEN (HL) <- FALSE
	JR NZ,ZEQU1		; (3t)
	INC HL	    	; (1t)	ELSE (HL) <- TRUE
ZEQU1:	
    JR HPUSH	    ; (3t)	(S1) <- (HL)
;

ZLESS:
	POP	HL	    	; (3t)	(HL) <- (S1)
	ADD HL,DE		; (1t)	IF (HL) >= 0
	LD HL,0	    	; (3t)	THEN (HL) <- FALSE
	JR NC,	ZLES1	; (3t)
	INC HL	    	; (1t)	ELSE (HL) <- TRUE
ZLES1:	
    JR HPUSH	    ; (3t)	(S1) <- (HL)
   
        
    
    OVER:
	POP	DE						; (3t) 	10t
	POP	HL						; (3t) 	10t
	PUSH HL						; (3t) 	11t
	
								; (9t)	31t	
;

DPUSH:	PUSH	DE				; (3t)
HPUSH:	PUSH	HL				; (3t)	
		

; *********************************************************************************
;
  NEXT:                               ; 9 
       INC BC                      ; (1t)	6t    Increment the IP
       LD A, (BC)                  ; (2t)	7t    Get the next character and dispatch
       LD L,A                      ; (1t)	4t    Index into table
       LD H,01h           ; (2t)	7t    Start address of jump table         
       LD L,(HL)                   ; (2t)	7t    get low jump address
       LD H,04h           ; (2t)	7t    Load H with the 1st page address       
       JP (HL)                     ; (3t)	4t    Jump to routine
									; (13t) 42t

; ********************************************************************************* 
   SPAT:

	LD	HL,0					; (2t)
	ADD HL,SP	    			; (1t)	(HL) <- (SP)
	JR HPUSH         			; (3t)  (S1) <- (HL)
;     
  		

; ********************************************************************************* 


PLUS:
	POP	DE      	; (3t)	(S1) <- (S1) + (S2)
	POP	HL			; (3t)
	ADD HL,DE		; (1t)
	JR HPUSH		; (3t)
;

neg_:   LD HL, 0    		    ; (3t)	10t NEGate the value on top of stack (2's complement)
        POP DE                  ; (3t)	10t
        JR sub_2                ; (2t)	use the SUBtract routine

sub_:	
	
	    POP     DE              ; (3t) 	10t
sub_1:  POP     HL              ; (3t) 	10t  Entry point for INVert
sub_2:  AND     A               ; (1t)  4t  Entry point for NEGate
        SBC     HL,DE           ; (2t)	15t
        PUSH    HL              ; (3t)	11t
        JR HPUSH                ; (3t)	11t
                                ; (15t) 61t
;





DROP:
	POP	HL						; (3t) 	 10t
	JR NEXT						; (3t)	 11t
								; (6t)	 21t
	
SWAP:
	POP	HL						; (3t) 	 10t
	EX (SP),HL					; (5t)	 19t
	JR HPUSH					; (3t)	 11t
								; (11t)	 40t	 
	
DUP:
	POP		HL					; (3t)
	PUSH	HL					; (3t)
	JR HPUSH					; (3t)
								; (9t)

AT:	
	POP	HL						; (3t) (HL) <- ADDR
	LD	E,(HL)					; (2t) (DE) <- (ADDR)
	INC HL						; (1t)
	LD	D,(HL)					; (2t)
	PUSH	DE					; (3t) (S1) <- (DE)
	JR NEXT						; (3t)
								; (14t)

CAT:            				;(S1) <- ((S1))LB
	POP	HL						; (3t)(HL) <- ADDR
	LD	L,(HL)					; (2t)(HL) <- (ADDR)LB
	XOR A						; (1t)
	LD H,A						; (1t)
	JR HPUSH					; (3t)
;

STORE:							;((S1)) <- (S2)
	POP	HL						; (3t) (HL) <- (S1) = ADDR
	POP	DE						; (3t) (DE) <- (S2) = VALUE
	LD	(HL),E					; (2t)((HL)) <- (DE)
	INC HL						; (1t)
	LD	(HL),D					; (2t)
	JR NEXT						; (3t)
;


and_:        
        POP     DE             	; (3t)Pop DE and HL for logic ops
        POP     HL				; (3t)
        LD      A,E				; (1t)
        AND     L           	; (1t) 	4t
        LD      L,A         	; (1t) 	4t
        LD      A,D         	; (1t) 	4t
        AND     H           	; (1t) 	4t
and1:
        LD      H,A         	; (1t) 	4t
        JR HPUSH             	; (3t)	11t
        
								; (15t) 42t
or_: 		 
        POP     DE             	; (3t)Pop DE and HL for logic ops
        POP     HL				; (3t)
        LD      A,E				; (1t)
        OR      L				; (1t) 	4t
        LD      L,A				; (1t) 	4t
        LD      A,D				; (1t) 	4t
        OR      H				; (1t) 	4t
        LD      H,A         	; (1t) 	4t
        JR HPUSH             	; (3t)	11t

xor_:		 
        POP     DE              ; Bitwise XOR the top 2 elements of the stack
xor1:
        POP     HL
        LD      A,E
        XOR     L
        LD      L,A
        LD      A,D
        XOR     H
        LD      H,A         	; (1t) 	4t
        JR HPUSH             	; (3t)	11t
        


inv_:						    ; Bitwise INVert the top member of the stack
        LD DE, $FFFF            ; (3t) by xoring with $FFFF
        JR xor1 				; (3t) 
        
eq_:    POP      HL				; (3t)
        POP      DE				; (3t)
        AND      A              ; (1t) reset the carry flag
        SBC      HL,DE          ; (2t) only equality sets HL=0 here
        JR       Z, equal		; (3t)
        SBC      HL,HL			; (2t) 
HP:     JR       HPUSH          ; (3t) HL = 1    


gt_:    POP      DE				; (3t)
        POP      HL				; (3t)
        JR       cmp_			; (3t)
        
lt_:    POP      HL				; (3t)
        POP      DE				; (3t)
cmp_:   AND      A              ; (1t)	reset the carry flag
        SBC      HL,DE          ; (2t)	only equality sets HL=0 here
		JR       Z,less         ; (3t) 	equality returns 0  KB 25/11/21
        SBC      HL,HL			; (2t)  HL = 0
        JP       M,less			; (3t)
equal:  INC      L              ; (1t) 	HL = 1    
less:     
        JR HP                   ; (3t) PUSH HL and drop into NEXT
        
         
   
;        
        
; ******************************************************************************
; ******************************************************************************
;
;									if <expr><compare><expr>
;
; ******************************************************************************
; ******************************************************************************

COMMAND_If:
		rst 038h						; evaluate left expression into B
		rst 10h		            		; get comparison character.
		ld 	c,-1 						; C will be -1,0,1 depending on character
		cp 	'<'
		jr z, 		fCI_FoundCompare
		inc c
		cp 	'='
		jr z, 		fCI_FoundCompare
		inc c
		cp 	'>'
		

fCI_FoundCompare:						; B left expr C -1 0 1 for < = >
		ld 	d,h 						; save HL in DE
		ld 	e,l
		ld 	h,UpdatePage/256 			; set HL to point to write area
		ld 	l,h
		ld 	(hl),c 						; save comparator
		inc l
		ld 	(hl),b 						; save LHExpr
		ld 	h,d 						; copy DE to HL
		ld 	l,e
		rst 038h						; get the right hand side.

		ld 	d,h 						; save HL in DE
		ld 	e,l 	
		ld 	h,UpdatePage/256 			; set HL to point to write area
		ld 	l,h
		ld 	c,(hl) 						; read comparator into C
		inc l
		ld 	a,(hl) 						; read left
		sub b 							; subtract right
		jr z, 	fCI_TestOver 			; if equal, if comparator zero its okay.
		dec c
		jr  nc, fCI_TestOver
		inc c
		inc c
fCI_TestOver: 							; DE is code, if C is zero test passed.
		ld 	l,e 						; put DE into HL
		ld 	h,d
		ld 	a,c 						; check if test passed.
		or 	a
		jr z, Command_Exe_z 			; if so, then execute the command


; fCI_EndLine:
;		ld 	a,(hl) 						; else skip to end of line.
;		or 	a
;		jr z, Command_Exe_z
;		inc l
;		jp 	fCI_EndLine
		
		
Command_Exe_z:

        rst 30h

   

;
	