//
//  JRDigitalModel.m
//  JRDigitalKlotski
//
//  Created by hqtech on 2018/4/25.
//  Copyright © 2018年 tulip. All rights reserved.
//

#import "JRDigitalModel.h"

@implementation JRDigitalModel

- (instancetype)initWithNum:(NSString *)num withRow:(NSInteger)row withCol:(NSInteger)col {
    if (self = [super init]) {
        self.num = num;
        self.row = row;
        self.col = col;
    }
    return self;
}

/**
 判断当前数据模型是否可以移动
 
 @param emptyRow 空白块所在行
 @param emptyCol 空白块所在列
 @return 当前数据模块是否可移动
 */
- (BOOL)canMoveWithEmptyRow:(NSInteger)emptyRow withEmptyCol:(NSInteger)emptyCol {
    // 如果当前数据模块与空白块在同一行相邻列或同一列相邻行，则可以移动，否则，不能移动
    if (self.row == emptyRow && labs(self.col - emptyCol) == 1) {
        // 同一行相邻列
        return YES;
    }else if (self.col == emptyCol && labs(self.row - emptyRow) == 1) {
        // 同一列相邻行
        return YES;
    }
    return NO;
}

/**
 将当前数据模块与空白块交换位置
 
 @param emptyRow 空白块所在行
 @param emptyCol 空白块所在列
 */
- (void)moveWithEmptyRow:(NSInteger)emptyRow withEmptyCol:(NSInteger)emptyCol {
    self.row = emptyRow;
    self.col = emptyCol;
}

@end
