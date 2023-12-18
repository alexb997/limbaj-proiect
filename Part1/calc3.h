#ifndef CALC3_H
#define CALC3_H

#define GE 257
#define LE 258
#define EQ 259
#define NE 260
#define WHILE 261
#define IF 262
#define ELSE 263
#define PRINT 264


typedef enum { typeCon, typeId, typeOpr } nodeEnum;

typedef struct {
    int value;
} conNodeType;

typedef struct {
    int i;
} idNodeType;

typedef struct {
    int oper;
    int nops;
    struct nodeTypeTag *op[1];
} oprNodeType;

typedef struct nodeTypeTag {
    nodeEnum type;
    union {
        conNodeType con;
        idNodeType id;
        oprNodeType opr;
    };
} nodeType;

int ex(nodeType *p);

extern int sym[26];

#endif // CALC3_H
