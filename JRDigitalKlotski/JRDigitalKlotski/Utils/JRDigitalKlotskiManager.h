//
//  JRDigitalKlotskiManager.h
//  JRDigitalKlotski
//
//  Created by hqtech on 2018/4/25.
//  Copyright © 2018年 tulip. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "JRDigitalKlotskiView.h"

@interface JRDigitalKlotskiManager : NSObject

/**
 通关
 */
@property (nonatomic, strong) void (^success) (void);

+ (JRDigitalKlotskiManager *)manager;

#pragma mark 生成数字华容道视图
/**
 生成数字华容道视图

 @param imgName 使用的图片名称
 @param rows 总行数
 @param cols 总列数
 @param complexity 复杂度：移动次数
 @return 数字华容道视图
 */
- (JRDigitalKlotskiView *)generateDigitalKlotskiViewWithImg:(NSString *)imgName withRows:(NSInteger)rows withCols:(NSInteger)cols withComplexity:(NSInteger)complexity;

/**
 设置是否显示每张图片上的数字
 
 @param show 是否显示
 */
- (void)showNums:(BOOL)show;

@end
