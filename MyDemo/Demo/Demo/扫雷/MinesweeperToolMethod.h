//
//  MinesweeperToolMethod.h
//  Demo
//
//  Created by 朱超鹏 on 2017/10/11.
//  Copyright © 2017年 zcp. All rights reserved.
//

#pragma mark - tool method

/**
 在low~high范围中不重复的随机抽count个数字，存入results数组中
 @return 是否成功，失败返回NO
 */
BOOL randomNumsInRange(int low, int high, int count, int results[]);
/**
 在0~high范围中不重复的随机抽count个数字，存入results数组中
 @return 是否成功，失败返回NO
 */
BOOL randomNums(int max, int count, int results[]);


/**
 获取正方形数字矩阵index位置上4/8方向的数字的索引组成的数组

 @param direction 4：4方向，8：8方向
 @param index 待计算位置
 @param lineNum 行数
 @param resultIndexs 结果索引数组
 @return 索引数组中值的数量
 */
int getMatrixDirectionIndexsWithIndex(int direction, int index, int lineNum, int resultIndexs[]);
