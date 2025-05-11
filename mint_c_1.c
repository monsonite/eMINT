/* mint.c  Interpreter: ver: 1.0 May 2025 */
#include <stdio.h>
static int  i,v,m,r,p=0,n,mx,s,f,st[2000]; 
static char t=0,c,u,a,k=0,pr[2000];
/* Stack Operations */
f34(){s++; st[s]=st[s-1];}														// DUP	"
f39(){s--;} 																	// DROP	'
f36(){i=st[s]; st[s]=st[s-1]; st[s-1]=i;}										// SWAP	$
f37(){i=st[s];st[s]=st[s-2];st[s-2]=st[s-1];st[s-1]=i;}							// OVER	%
/* Logical  Operations */
//f37(){st[s-1]%=st[s]; s--; }													// MOD 
f38(){st[s-1]&=st[s]; s--; }													// AND	&
f94(){st[s-1]^=st[s]; s--; }													// XOR	^
f124(){st[s-1]|=st[s]; s--; }													// OR	|
f126(){st[s]=  ~st[s]; }														// NOT	~
f95(){st[s]=-st[s]; }															// NEG	_
f123(){}																		// SHL {
f125(){}																		// SHR }
/* Arithmetic Operations */
f43(){ if(k==0){st[s-1]+=st[s]; s--; }else{st[v]++;} }							// ADD INC 	+
f45(){ if(k==0){st[s-1]-=st[s]; s--; }else{st[v]--;} }							// SUB DEC	-	
f42(){st[s-1]*=st[s]; s--; }													// MUL	*
f47(){st[s-1]/=st[s]; s--; }													// DIV	/
/* Comparison Operations */
f60(){if(st[s]> st[s-1]){st[s]=-1;}else{st[s]=0;}}								// LT	<
f61(){if(st[s]==st[s-1]){st[s]=-1;}else {st[s]=0;}}								// EQ	=
f62(){if(st[s]< st[s-1]){st[s]=-1;}else{st[s]=0;}}								// GT	>
/* Conditional Execution, Loops and Flow Control Operations */
f40(){r++;st[r]=p;if(st[s]==0){p++;u=pr[p]; while(u!=')'){ p++; u=pr[p];}}}		// Begin Loop 
f41(){if(st[s]!=0) p=st[r]; else r--; s--; }									// End Loop
//f40(){if(st[s]==0){s--;p++;u=pr[p];while(u!=')'){p++;u=pr[p];}} else{s--;}}   // Execute (enclosed) if true (....)	
/* Memory and Variable Access */
f33(){st[st[v]]=st[s]; s--; }													// Store TOS at variable address	!
f64(){s++; st[s]=st[st[v]]; }													// Fetch TOS from variable address	@
//f58(){st[v]=st[s]; s--; } 													// Fetch from selected register
//f59(){s++; st[s]=st[v]; }														// Store into selected register
/* Input/Output Operations */
f46(){printf("%d",st[s]); s--;} 												// Print TOS as decimal .
f44(){printf("%c",st[s]); s--; }												// Emit TOS as ascii character ,
f34(){p++;u=pr[p];while(u!='\"'){putc(u,stdout);p++;u=pr[p];}}					// "Print as String"
f63(){if((c=getc(stdin))==EOF) { c=0; } s++; st[s]=c; }							// KEY ?
f96(){putc(u,stdout);} 															// TICK `
/* User Definitions */ 
f58()(){f=pr[p+1]-35;st[f]=p+2;while(u!='}'){p++;u=pr[p];}}						// Start function definition	:
f59(){p=st[r];r--;}																// End function definition		;	
/* Text Decode Operations */
N(){;} 																			// No Operation
fA(){r++; st[r]=p; p=st[u-35]; u=pr[p]; p--;}									// Execute User definition A-Z
fa(){k=1; v=u-97; }																// Handle variable a-z											
f9(){i=0;while((u>='0')&&(u<='9')){i=i*10+u-'0';p++;u=pr[p];}s++;st[s]=i;p--;}	// Interpret Decimal Number
//f39(){p++;u=pr[p];while(u!='\''){s++;st[s]=u;p++;u=pr[p];}}					// 
/* Decode Character - Jump to Function */
int (*q[127])()={
N,N,N,N,N,N,N,N,N,N,N,N,N,N,N,N,N,N,N,N,N,N,N,N,N,N,N,N,N,N,N,N,N,				// ascii 0-31 No Ops
f33,f34,f35,f36,f37,f38,f39,f40,N,f42,f43,f44,f45,f46,f47,						// ascii 33-47 functions
f9,f9,f9,f9,f9,f9,f9,f9,f9,f9,													// ascii 48-57 numbers
f58,f59,f60,f61,f62,f63,f64,													// ascii 58-64 functions
fA,fA,fA,fA,fA,fA,fA,fA,fA,fA,fA,fA,fA,fA,fA,fA,fA,fA,fA,fA,fA,fA,fA,fA,fA,fA,	// User Functions A-Z
f91,f92,f93,f94,f95,f96,														// ascii 91-96 functions
fa,fa,fa,fa,fa,fa,fa,fa,fa,fa,fa,fa,fa,fa,fa,fa,fa,fa,fa,fa,fa,fa,fa,fa,fa,fa,	// Variables a-z
f123,f124,f125,f126};															// ascii 123-126 functions
/* Load and Execute */
int main(int argc,char *argv[]){ FILE *be; 
 if (!(be=fopen(argv[1],"rb"))) {printf("pr?\n"); return 0;}
 while((c=fgetc(be))!=EOF){ pr[p++]=c; } 										// Store the file to memory
 fclose(be); mx=p; i=1999; while(i--){ st[i]=0;}  
 for(i=0;i<argc;i++) if(i>1) st[i-2]=atoi(argv[i]);
 p=0; s=100; r=60; 																// Initialise pc, sp and rp
 while(p<=mx){ u=pr[p]; q[u](); if(u<'a')k=0; else if(u>'z')k=0; p++;}
 return 0;}












