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
- (JRDigitalKlotskiView *)generateDigitalKlotskiViewWithRows:(NSInteger)rows withCols:(NSInteger)cols;

@end
