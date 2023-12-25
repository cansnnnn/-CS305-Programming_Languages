%{
#include <stdio.h>
void yyerror (const char *msg){
return; }
%}

%token tMAIL tENDMAIL tSCHEDULE tENDSCHEDULE tSEND tSET tTO tFROM tAT tCOMMA tCOLON tLPR tRPR tLBR tRBR tIDENT tSTRING tADDRESS tDATE tTIME

%%

program	: components
		| 
;

components	: mail_block 
			| set 
			| mail_block components
			| set components
;

mail_block	: tMAIL tFROM tADDRESS tCOLON tENDMAIL
			| tMAIL tFROM tADDRESS tCOLON statement tENDMAIL
			
;

statement	: set
			| send
			| schedule
			| set statement
			| send statement
			| schedule statement
;

set	: tSET tIDENT tLPR tSTRING tRPR
;

send	: tSEND tLBR tIDENT tRBR tTO recipient_list
		| tSEND tLBR tSTRING tRBR tTO recipient_list
;

schedule	: tSCHEDULE tAT tLBR tDATE tCOMMA tTIME tRBR tCOLON send_list tENDSCHEDULE
;

send_list	: send send_list
			| send
;

recipient	: tLPR tADDRESS tRPR
			| tLPR tIDENT tCOMMA tADDRESS tRPR
			| tLPR tSTRING tCOMMA tADDRESS tRPR
;

recipients	: recipient tCOMMA recipients
			| recipient
;

recipient_list	: tLBR recipients tRBR
;

%%

int main ()
{
	if (yyparse())
	{
		printf("ERROR\n");
		return 1;
	}
	else
	{
		printf("OK\n");
		return 0;
	}
}