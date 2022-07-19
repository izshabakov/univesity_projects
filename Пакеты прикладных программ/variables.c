#include "variables.h"

int symbol_get(symbol_block **root, symbol **dst, char *name) {
	symbol_block *cur_block = *root; int i;
	while (cur_block != NULL) {
		for (i = 0; i < cur_block->cur_index; i++) {
			if (strcmp(cur_block->symbols[i].name, name) == 0) {
				if (cur_block->symbols[i].hasVal == 1) {
					*dst = &(cur_block->symbols[i]);
					return 1;
				}
				else { return 0; }
			}
		}
		cur_block = cur_block->next;
	}
	return -1;
}

int symbol_get_value(symbol_block **root, int *dst, char *name) {
	symbol *sym;
	int retval = symbol_get(root, &sym, name);
	if (retval == 1) {
		*dst = sym->val;
	}
	return retval;
}

void enlarge_if_need(symbol_block **root)
{
	if (*root == NULL || (*root)->cur_index >= BLOCK_SIZE)
	{
		symbol_block *sb = (symbol_block*)malloc(sizeof(symbol_block));
		sb->symbols = (symbol*)malloc(BLOCK_SIZE*sizeof(symbol));
		sb->cur_index = 0;
		sb->next = *root;
		*root = sb;
	}
}

void symbol_add(symbol_block **root, char *name)
{
	int tmp; if (symbol_get_value(root, &tmp, name) != -1) { return; }
	enlarge_if_need(root);
	int ind = (*root)->cur_index;
	strcpy((*root)->symbols[ind].name, name);
	(*root)->symbols[ind].hasVal = 0;
	(*root)->cur_index++;
}

void symbol_assign(symbol_block **root, char *name, int value)
{
	symbol *sym;
	if (symbol_get(root, &sym, name) != -1) {
		sym->val = value;
		sym->hasVal = 1;
		return;
	}
	enlarge_if_need(root);
	int ind = (*root)->cur_index;
	strcpy((*root)->symbols[ind].name, name);
	(*root)->symbols[ind].hasVal = 1;
	(*root)->symbols[ind].val = value;
	(*root)->cur_index++;
}
