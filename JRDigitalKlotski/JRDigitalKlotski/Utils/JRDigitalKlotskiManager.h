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

 @param rows 总行数
 @param cols 总列数
 @param complexity 复杂度：移动次数
 @return 数字华容道视图
 */
- (JRDigitalKlotskiView *)generateDigitalKlotskiViewWithRows:(NSInteger)rows withCols:(NSInteger)cols withComplexity:(NSInteger)complexity;

@end
