//
//  JRDigitalKlotskiManager.m
//  JRDigitalKlotski
//
//  Created by hqtech on 2018/4/25.
//  Copyright © 2018年 tulip. All rights reserved.
//

#import "JRDigitalKlotskiManager.h"

@interface JRDigitalKlotskiManager ()

@property (nonatomic, strong) JRDigitalKlotskiView *dkView;

@end

static JRDigitalKlotskiManager *manager = nil;

@implementation JRDigitalKlotskiManager

+ (JRDigitalKlotskiManager *)manager {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        manager = [[JRDigitalKlotskiManager alloc] init];
    });
    return manager;
}

- (instancetype)init {
    if (self = [super init]) {
        
    }
    return self;
}

#pragma mark 生成数字华容道视图
- (JRDigitalKlotskiView *)generateDigitalKlotskiViewWithRows:(NSInteger)rows withCols:(NSInteger)cols {
    // 生成随机数
    NSArray *randomNums = [self generateRandomNumsWithRow:rows withCol:cols];
    NSLog(@"随机数组：%@", randomNums);
    
    // 数字华容道视图
    JRDigitalKlotskiView *dkView = [[JRDigitalKlotskiView alloc] initWithRows:rows withCols:cols];
    // 生成数据模块视图
    [dkView generateRandomDigitalView:randomNums];
    __weak typeof(self) weakSelf = self;
    dkView.checkSuccess = ^{
        // 通关
        if (weakSelf.success) {
            weakSelf.success();
        }
    };
    self.dkView = dkView;
    
    return dkView;
}

#pragma mark 生成随机数
- (NSArray<NSString *> *)generateRandomNumsWithRow:(NSInteger)row withCol:(NSInteger)col {
    
    // 按顺讯生成一组数
    NSMutableArray *numsArr = [NSMutableArray arrayWithCapacity:0];
    for (NSInteger i = 0; i < row * col; i ++) {
        [numsArr addObject:[NSString stringWithFormat:@"%ld", i + 1]];
    }
    
    // 随机排序
    NSMutableArray *randomArr = [NSMutableArray arrayWithCapacity:0];
    for (NSInteger i = 0; i < row * col; i ++) {
        // 生成一个随机数
        NSInteger index = arc4random() % numsArr.count;
        // 在上面生成好的数组中随机取一个数，放入结果数组中
        [randomArr addObject:numsArr[index]];
        // 将上面数据中已取出的数删除
        [numsArr removeObjectAtIndex:index];
    }
    
    // 返回随机数数组
    return randomArr;
}

@end
