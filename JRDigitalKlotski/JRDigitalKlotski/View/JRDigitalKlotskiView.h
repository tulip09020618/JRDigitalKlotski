//
//  JRDigitalKlotskiView.h
//  JRDigitalKlotski
//
//  Created by hqtech on 2018/4/25.
//  Copyright © 2018年 tulip. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "JRDigitalView.h"

// 数字华容道视图

@interface JRDigitalKlotskiView : UIView

/**
 总行数
 */
@property (nonatomic, assign) NSInteger totalRows;

/**
 总列数
 */
@property (nonatomic, assign) NSInteger totalCols;

/**
 检测成功，顺利通关
 */
@property (nonatomic, strong) void (^checkSuccess) (void);

// 初始化
- (instancetype)initWithImg:(NSString *)imgName withRows:(NSInteger)rows withCols:(NSInteger)cols;

#pragma mark 生成随机数据模块
/**
 生成随机数据模块视图(根据一组不重复的随机数)
 */
- (void)generateRandomDigitalView:(NSArray<NSString *> *)randonNums;

/**
 是否显示每个数据块上的数字

 @param show 是否显示
 */
- (void)showNums:(BOOL)show;

@end
