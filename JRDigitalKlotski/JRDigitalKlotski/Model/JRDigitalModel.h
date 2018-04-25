//
//  JRDigitalModel.h
//  JRDigitalKlotski
//
//  Created by hqtech on 2018/4/25.
//  Copyright © 2018年 tulip. All rights reserved.
//

#import <Foundation/Foundation.h>

// 数字华容道中的数据模型

@interface JRDigitalModel : NSObject

/**
 每个数据模型上的数字
 */
@property (nonatomic, strong) NSString *num;

/**
 每个数据模型当前所在行
 */
@property (nonatomic, assign) NSInteger row;

/**
 每个数据模型当前所在列
 */
@property (nonatomic, assign) NSInteger col;

/**
 初始化方法

 @param num 当前数据模型上的数字
 @param row 当前数据模型所在行
 @param col 当前数据模型所在列
 @return 数据模型
 */
- (instancetype)initWithNum:(NSString *)num withRow:(NSInteger)row withCol:(NSInteger)col;

/**
 判断当前数据模型是否可以移动

 @param emptyRow 空白块所在行
 @param emptyCol 空白块所在列
 @return 当前数据模块是否可移动
 */
- (BOOL)canMoveWithEmptyRow:(NSInteger)emptyRow withEmptyCol:(NSInteger)emptyCol;

/**
 将当前数据模块与空白块交换位置

 @param emptyRow 空白块所在行
 @param emptyCol 空白块所在列
 */
- (void)moveWithEmptyRow:(NSInteger)emptyRow withEmptyCol:(NSInteger)emptyCol;

@end
