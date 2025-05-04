### <a name='list-of-MINT-operators'></a>List of MINT operators

| Symbol | Description                               | Effect       |	Symbol | Description                               | Effect       |
| ------ | ----------------------------------------- | ------------ |	------ | ----------------------------------------- | ------------ |
| a...z  | variable access                           | -- n         |	A...Z  | User Functions        	                   | --           |
| '      | DROP top of stack                         | m n -- m     | %      | OVER			                                 | m n -- m n m |
| "      | DUP top of stack                          | n -- n n     | $      | SWAP                                      | m n -- n m   |
| >      | 16-bit comparison GT                      | n n -- b     |	-      | 16-bit integer subtraction SUB            | n n -- n     |
| <      | 16-bit comparison LT                      | n n -- b     |	/      | 16-bit by 8-bit division DIV              | n n -- n     |
| =      | 16 bit comparison EQ                      | n n -- b     |	+      | 16-bit integer addition ADD               | n n -- n     |
| &      | 16-bit bitwise AND                        | n n -- b     |	*      | 8-bit by 8-bit integer multiplication MUL | n n -- n     |
| \|     | 16-bit bitwise OR                         | n n -- b     | ^      | 16-bit bitwise XOR                        | n n -- b     |   
| ~      | 16-bit NOT                                | n -- n       | _      | 16-bit 2's complement                     | n -- n       |
| {      | shift left                                | n -- n       | }      | shift right                               | --           |
| (      | Begin a loop which will repeat n times    | n --         | )      | End a loop code block                     | --           |
| [	     | Begin an array definition 		             | --	          | ]      | End an array definition   		             | -- a         |
|	?      | get array item            		             | a n -- n     | ,      | Separator for array items                 | --           |
|	:      | Begin Colon Definition      	             | -- a         |	;      | End Colon Definition                      |              |
| @      | FETCH a value from memory                 | -- n	        | !      | STORE a value to memory                   | n a --       |    
| .      | print TOS as number in current base       | n --         | #      | Toggle base between decimal and hex       | n --         |
|	`      | Print string between ticks                |              | \      | Use extended function table	             | --           |

