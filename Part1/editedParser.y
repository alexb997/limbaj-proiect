%{
#include "calc3.h"
#include <stdio.h>
#include <stdlib.h>
#include <stdarg.h>

int yylex();
void yyerror(char *s);
nodeType *con(int value);
nodeType *id(int i);
nodeType *opr(int oper, int nops, ...);
void freeNode(nodeType *p);
int ex(nodeType *p);

%}

%union {
    int iValue;
    char sIndex;
    nodeType *nPtr;
}

%token <iValue> INTEGER
%token <sIndex> VARIABLE
%left '+' '-'
%left '*' '/'
%nonassoc UMINUS
%type <nPtr> expr

%%

program:
    expr { printf("Result: %d\n", ex($1)); freeNode($1); }
    | /* empty */
    ;

expr:
    INTEGER          { $$ = con($1); }
    | VARIABLE       { $$ = id($1); }
    | expr '+' expr  { $$ = opr('+', 2, $1, $3); }
    | expr '-' expr  { $$ = opr('-', 2, $1, $3); }
    | expr '*' expr  { $$ = opr('*', 2, $1, $3); }
    | expr '/' expr  { $$ = opr('/', 2, $1, $3); }
    | '-' expr %prec UMINUS { $$ = opr(UMINUS, 1, $2); }
    | '(' expr ')'   { $$ = $2; }
    ;

%%

nodeType *con(int value) {
    nodeType *p;
    if ((p = malloc(sizeof(nodeType))) == NULL) {
        yyerror("out of memory");
        exit(1);
    }
    p->type = typeCon;
    p->con.value = value;
    return p;
}

nodeType *id(int i) {
    nodeType *p;
    if ((p = malloc(sizeof(nodeType))) == NULL) {
        yyerror("out of memory");
        exit(1);
    }
    p->type = typeId;
    p->id.i = i;
    return p;
}

nodeType *opr(int oper, int nops, ...) {
    va_list ap;
    nodeType *p;
    int i;

    if ((p = malloc(sizeof(nodeType) + (nops - 1) * sizeof(nodeType *))) == NULL) {
        yyerror("out of memory");
        exit(1);
    }

    p->type = typeOpr;
    p->opr.oper = oper;
    p->opr.nops = nops;

    va_start(ap, nops);
    for (i = 0; i < nops; i++)
        p->opr.op[i] = va_arg(ap, nodeType *);
    va_end(ap);

    return p;
}

void freeNode(nodeType *p) {
    int i;

    if (!p)
        return;

    if (p->type == typeOpr) {
        for (i = 0; i < p->opr.nops; i++)
            freeNode(p->opr.op[i]);
    }

    free(p);
}

void yyerror(char *s) {
    fprintf(stderr, "%s\n", s);
}

int main(void) {
    yyparse();
    return 0;
}