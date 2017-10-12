//
//  MinesweeperToolMethod.m
//  Demo
//
//  Created by 朱超鹏 on 2017/10/11.
//  Copyright © 2017年 zcp. All rights reserved.
//

#pragma mark - tool method

// 在low~high范围中不重复的随机抽count个数字，存入results数组中
BOOL randomNumsInRange(int low, int high, int count, int results[]) {
    // 检验参数
    if (low > high || (high - low + 1) < count || results == NULL) {
        return NO;
    }
    
    // 初始化
    int nums[100] = {0};
    int numsCount = high - low + 1;
    for (int index = 0, i = low; i <= high; i++, index++) {
        nums[index] = i;
    }
    
    for (int i = 0; i < count; i++) {
        int randomIndex     = RANDOM(0, numsCount - 1);
        int result          = nums[randomIndex];
        int numLastIndex    = numsCount - 1;
        nums[randomIndex]   = nums[numLastIndex];
        results[i]          = result;
        numsCount--;
    }
    return YES;
}

// 在0~high范围中不重复的随机抽count个数字，存入results数组中
BOOL randomNums(int max, int count, int results[]) {
    return randomNumsInRange(0, max, count, results);
}

// 获取正方形数字矩阵index位置上4/8方向的数字的索引组成的数组
int getMatrixDirectionIndexsWithIndex(int direction, int index, int lineNum, int resultIndexs[]) {
    
    // index所在行列的情况
    BOOL isFirstRow     = (index >= 0 && index < lineNum);
    BOOL isFirstColumn  = (index % lineNum == 0);
    BOOL isLastRow      = (index >= lineNum * (lineNum - 1) && index < (lineNum * lineNum));
    BOOL isLastColumn   = ((index + 1)%lineNum == 0);
    
    int m1 = !(isFirstRow || isFirstColumn) ? 1 : 0;    // 第一行和第一列的并集没有m1
    int m2 = !isFirstRow ? 1 : 0;                       // 第一行没有m2
    int m3 = !(isFirstRow || isLastColumn) ? 1 : 0;     // 第一行和最后一列的并集没有m3
    int m4 = !isFirstColumn ? 1 : 0;                    // 第一列没有m4
    int m6 = !isLastColumn ? 1 : 0;                     // 最后一列没有m6
    int m7 = !(isFirstColumn || isLastRow) ? 1 : 0;     // 第一列和最后一行的并集没有m7
    int m8 = !isLastRow ? 1 : 0;                        // 最后一行没有m8
    int m9 = !(isLastRow || isLastColumn)  ? 1 : 0;     // 最后一列和最后一行的并集没有m9
    
    // 处理4方向的情况
    if (direction == 4) {
        m1 = 0;
        m3 = 0;
        m7 = 0;
        m9 = 0;
    }
    
    // 判定矩阵
    int m[] = {
        m1, m2, m3,
        m4, 0, m6,
        m7, m8, m9
    };
    
    // 值矩阵
    int indexs[] = {
        index - lineNum - 1, index - lineNum, index - lineNum + 1,
        index - 1,           index,           index + 1,
        index + lineNum - 1, index + lineNum, index + lineNum + 1
    };
    
    // 取值
    int count = 0;
    for (int i = 0, j = 0; i < 9; i++) {
        if (m[i] == 1) {
            resultIndexs[j] = indexs[i];
            j++;
            count++;
        }
    }
    return count;
}
