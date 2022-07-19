#ifndef SYMBOLS_H
#define SYMBOLS_H

#include <string.h>
#include <stdlib.h>

#define BLOCK_SIZE 15
#define NAME_LEN 30

typedef struct symbol {
    char name[NAME_LEN]; // symbol name
    int val; // symbol value
    int hasVal; // 0 if symbol has notany value, 1 if has
} symbol;

typedef struct symbol_block {
    symbol *symbols; // pointer to symbol array of BLOCK_SIZE size
    int cur_index; // current index put new element to  
    struct symbol_block *next; // pointer to the next block
} symbol_block;

/* Read pointer to symbol to dst.
Return value:
-1 if symbols not found
0 if symbol found but hasVal is 0
1 if symbol found and hasVal is 1
Note: this function can be used to just check if some symbol exist or not*/
int symbol_get(symbol_block **root, symbol **dst, char *name);


/* Read symbol value to dst.
Return value:
-1 if symbols not found
0 if symbol found but hasVal is 0
1 if symbol found and hasVal is 1
Note: this function can be used to just check if some symbol exist or not*/
int symbol_get_value(symbol_block **root, int *dst, char *name);

/* Add symbol without assigning it any value
Note: if symbol already exists, function won't add a new one */
void symbol_add(symbol_block **root, char *name);

/* Add symbol and assign given value to it
Note: if symbol already exists, function will change its value,
if doesnt, function will create a new one with given value */
void symbol_assign(symbol_block **root, char *name, int value);

/* If root block is filled up, then alloc new and insert it before root */
void enlarge_if_need(symbol_block **root);

/*
Example usage:
symbol_block *root;
...
int x;
symbol_get_value(&root, &x, "foobar");

symbol *sym;
symbol_get(&root, &sym, "foo");
*/

#endif // SYMBOLS_H

