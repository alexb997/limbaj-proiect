%{
#include <stdio.h>
%}
cifre [1-9][0-9]{3}
cuvinte [A-Za-z]*aab[A-za-z]*
liste ([1-9][0-9];)$[1-9][0-9]
%option noyywrap
%%
\<{cifre}\> {printf("[cifre:%s]\n",yytext);}
\"{cuvinte}\"  {printf ("[cuvant:%s]\n", yytext);}
\[{liste}\]  {printf ("[lista:%s]\n", yytext);}
.|\n ;  
%%
int main(int argc, char** argv){
FILE *g;
if(argc>0)
 yyin = fopen(argv[1],"r");

if(!(g = fopen("out.txt","w")))
    fprintf(stderr,"eroare creare fisier!");
else
 yyout=g; 

yylex();

}



