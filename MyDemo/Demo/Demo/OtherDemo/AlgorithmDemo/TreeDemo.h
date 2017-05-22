//
//  TreeDemo.h
//  Demo
//
//  Created by 朱超鹏(外包) on 17/2/22.
//  Copyright © 2017年 zcp. All rights reserved.
//

#import <Foundation/Foundation.h>
#include <stdio.h>

// 二叉树
typedef struct BiTreeNode {
    struct BiTreeNode *leftChild;
    struct BiTreeNode *rightChild;
    char data;
}BiTreeNode, *BiTree;

BiTree createBiTree (NSString *treeString);


@interface TreeDemo : NSObject

+ (void)run;

@end


