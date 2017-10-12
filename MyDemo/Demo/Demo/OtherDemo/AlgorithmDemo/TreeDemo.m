//
//  TreeDemo.m
//  Demo
//
//  Created by 朱超鹏(外包) on 17/2/22.
//  Copyright © 2017年 zcp. All rights reserved.
//

#import "TreeDemo.h"

// static
static const char *treeSetup;
static int charIndex;

// method define
BiTree _createBiTree (void);
BiTreeNode* treeSearch (BiTreeNode *node, char query);
void printBiTreeNode(BiTreeNode *node);


// -- 二叉树 --
// 创建二叉树
BiTree createBiTree (NSString *treeString) {
    treeSetup = [treeString UTF8String];
    charIndex = 0;
    BiTree T = _createBiTree();
    treeSetup = NULL;
    charIndex = -1;
    return T;
}

BiTree _createBiTree () {
    BiTree T;
    char ch = treeSetup[charIndex];
    charIndex ++;
    
    if (ch == '#') {
        T = NULL;
    } else {
        T = (BiTree)malloc(sizeof(BiTreeNode));
        T->data = ch;
        T->leftChild = _createBiTree();
        T->rightChild = _createBiTree();
        return T;
    }
    return NULL;
}

// 查找
BiTreeNode* treeSearch (BiTreeNode *node, char query) {
    if (node == NULL || node->data == query) {
        return node;
    }
    if (node->data < query) {
        return treeSearch(node->rightChild, query);
    } else {
        return treeSearch(node->leftChild, query);
    }
}
// 打印bitree node
void printBiTreeNode(BiTreeNode *node) {
    if (node != NULL) {
        ZCPLog(@"node data: %c", node->data);
    } else {
        ZCPLog(@"node is NULL.");
    }
}

// 先序遍历
void PreOrderTraverse (BiTree T) {
    if (T != NULL) {
        printf("%c", T->data);
        PreOrderTraverse(T->leftChild);
        PreOrderTraverse(T->rightChild);
    }
}
// 中序遍历
void InOrderTraverse (BiTree T) {
    if (T != NULL) {
        InOrderTraverse(T->leftChild);
        printf("%c", T->data);
        InOrderTraverse(T->rightChild);
    }
}
// 后序遍历
void PostOrderTraverse (BiTree T) {
    if (T != NULL) {
        PostOrderTraverse(T->leftChild);
        PostOrderTraverse(T->rightChild);
        printf("%c", T->data);
    }
}

@implementation TreeDemo

//            a
//        b       c
//      #  d     # e
//        # #     # #

+ (void)run {
    NSString *str = @"ab#d##c#e##";
    BiTree T = createBiTree(str);
    BiTreeNode *node = treeSearch(T, 'e');
    printBiTreeNode(node);
    
    PreOrderTraverse(T);
    printf("\n");
    InOrderTraverse(T);
    printf("\n");
    PostOrderTraverse(T);
    printf("\n");
    
    free(T);
}

@end
