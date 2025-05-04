# eMINT
An extendable, interpreted, bytecode language.

### <a name='list-of-operators'></a>List of operators

| Symbol | Description          | Effect   |		| Symbol | Description                               | Effect   |
| ------ | -------------------- | -------- |		| ------ | ----------------------------------------- | -------- |				
| >      | 16-bit comparison GT | n n -- b |		| -      | 16-bit integer subtraction SUB            | n n -- n |
| <      | 16-bit comparison LT | n n -- b |		| /      | 16-bit by 8-bit division DIV              | n n -- n |
| =      | 16 bit comparison EQ | n n -- b |		| +      | 16-bit integer addition ADD               | n n -- n |
| &      | 16-bit bitwise AND   | n n -- b |		| *      | 8-bit by 8-bit integer multiplication MUL | n n -- n |
| |      | 16-bit bitwise OR    | n n -- b |		
| ^      | 16-bit bitwise XOR   | n n -- b |		| Symbol | Description                            	 | Effect   |
| ~      | 16-bit NOT           | n -- n   |		| ------ | ----------------------------------------- | -------- |		
| {      | shift left           | n -- n   |		| (      | BEGIN a loop which will repeat n times    | n --     |		
| }      | shift right          | --       |		| )      | END a loop code block                     | --       |	

| Symbol | Description               | Effect |		| Symbol | Description               | Effect   |		
| ------ | ------------------------- | ------ |		| ------ | ------------------------- | -------- |
| a..z   | variable access           | -- n   |		| [      | begin an array definition | --       |
| @      | FETCH a value from memory | -- n	  |		| ]      | end an array definition   | -- a     | 
| !      | STORE a value to memory   | n a -- |		| ?      | get array item            | a n -- n |	

| Symbol | Description                                                          | Effect       |
| ------ | -------------------------------------------------------------------- | ------------ |
| '      | drop the top member of the stack DROP                                | m n -- m     |
| "      | duplicate the top member of the stack DUP                            | n -- n n     |
| %      | over - take the 2nd member of the stack and copy to top of the stack | m n -- m n m |
| $      | swap the top 2 members of the stack SWAP                             | m n -- n m   |

| Symbol | Description                                    | Effect |		| Symbol   | Description                     | Effect |
| ------ | ---------------------------------------------- | ------ |		| -------- | ------------------------------- | ------ |
| .      | print the number on the stack as a decimal     | n --   |		| :A ... ; | define a new command DEF        | --     |
| ,      | print the number on the stack as a hexadecimal | n --   |		| :@ ... ; | define an anonymous command DEF | -- a   |
																			  where "A" represents any uppcase letter




### <a name='list-of-operators'></a>List of operators

### <a name='maths-operators'></a>Maths Operators

| Symbol | Description                               | Effect   |
| ------ | ----------------------------------------- | -------- |
| -      | 16-bit integer subtraction SUB            | n n -- n |
| /      | 16-bit by 8-bit division DIV              | n n -- n |
| +      | 16-bit integer addition ADD               | n n -- n |
| \*     | 8-bit by 8-bit integer multiplication MUL | n n -- n |

### <a name='logical-operators-1'></a>Logical Operators

| Symbol | Description          | Effect   |
| ------ | -------------------- | -------- |
| >      | 16-bit comparison GT | n n -- b |
| <      | 16-bit comparison LT | n n -- b |
| =      | 16 bit comparison EQ | n n -- b |
| &      | 16-bit bitwise AND   | n n -- b |
| \|     | 16-bit bitwise OR    | n n -- b |
| ^      | 16-bit bitwise XOR   | n n -- b |
| ~      | 16-bit NOT           | n -- n   |
| {      | shift left           | n -- n   |
| }      | shift right          | --       |

### <a name='stack-operations'></a>Stack Operations

| Symbol | Description                                                          | Effect       |
| ------ | -------------------------------------------------------------------- | ------------ |
| '      | drop the top member of the stack DROP                                | m n -- m     |
| "      | duplicate the top member of the stack DUP                            | n -- n n     |
| %      | over - take the 2nd member of the stack and copy to top of the stack | m n -- m n m |
| $      | swap the top 2 members of the stack SWAP                             | m n -- n m   |


### <a name='input-&-output-operations'></a>Input & Output Operations

| Symbol | Description                                    | Effect |
| ------ | ---------------------------------------------- | ------ |
| .      | print the number on the stack as a decimal     | n --   |
| ,      | print the number on the stack as a hexadecimal | n --   |

### <a name='functions'></a>Functions

| Symbol   | Description                     | Effect |
| -------- | ------------------------------- | ------ |
| :A ... ; | define a new command DEF        | --     |
| :@ ... ; | define an anonymous command DEF | -- a   |


where "A" represents any uppcase letter

### <a name='loops-and-conditional-execution'></a>Loops and conditional execution

| Symbol | Description                            | Effect |
| ------ | -------------------------------------- | ------ |
| (      | BEGIN a loop which will repeat n times | n --   |
| )      | END a loop code block                  | --     |

### <a name='memory-and-variable-operations'></a>Memory and Variable Operations

| Symbol | Description             | Effect |
| ------ | ----------------------- | ------ |
| a..z   | variable access         | -- n   |
| !      | STORE a value to memory | n a -- |

### <a name='array-operations'></a>Array Operations

| Symbol | Description               | Effect   |
| ------ | ------------------------- | -------- |
| [      | begin an array definition | --       |
| ]      | end an array definition   | -- a     |
| ?      | get array item            | a n -- n |
