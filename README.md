### <a name='list-of-MINT-operators'></a>List of MINT operators

| Symbol | Description                               | Effect       |	Symbol | Description                               | Effect       |
| ------ | ----------------------------------------- | ------------ |	------ | ----------------------------------------- | ------------ |
| >      | 16-bit comparison GT                      | n n -- b     |	-      | 16-bit integer subtraction SUB            | n n -- n     |
| <      | 16-bit comparison LT                      | n n -- b     |	/      | 16-bit by 8-bit division DIV              | n n -- n     |
| =      | 16 bit comparison EQ                      | n n -- b     |	+      | 16-bit integer addition ADD               | n n -- n     |
| &      | 16-bit bitwise AND                        | n n -- b     |	*      | 8-bit by 8-bit integer multiplication MUL | n n -- n     |
| \|     | 16-bit bitwise OR                         | n n -- b     |	(      | Begin a loop which will repeat n times    | n --         |
| ^      | 16-bit bitwise XOR                        | n n -- b     |	)      | End a loop code block                     | --           |
| ~      | 16-bit NOT                                | n -- n       |	[	     | Begin an array definition 		             | --	          |
| _      | 16-bit 2's complement                     | n -- n       |        |                                           | --           |
| {      | shift left                                | n -- n       |	]      | End an array definition   		             | -- a         |
| }      | shift right                               | --           |	?      | get array item            		             | a n -- n     |
| a...z  | variable access                           | -- n         |	A...Z  | User Functions        	                   | --           |
| @      | FETCH a value from memory                 | -- n	        |	:      | Begin Colon Definition      	             | -- a         |
| !      | STORE a value to memory                   | n a --       |	;      | End Colon Definition                      |              |
| .      | print TOS as decimal                      | n --         | ,      | print TOS as hexadecimal  		             | n --         |
|	`      | Print string between ticks                |              | \      | Extended function table		               |              |
| '      | DROP top of stack                         | m n -- m     | %      | OVER			                                 | m n -- m n m |
| "      | DUP  top of stack                         | n -- n n     | $      | SWAP                                      | m n -- n m   |
