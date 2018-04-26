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

/**
 复杂度
 */
@property (nonatomic, assign) NSInteger complexity;

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
- (JRDigitalKlotskiView *)generateDigitalKlotskiViewWithRows:(NSInteger)rows withCols:(NSInteger)cols withComplexity:(NSInteger)complexity {
    
    self.complexity = complexity;
    
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
    
    // 默认最后一块为空白块
    // 空白块所在行列为
    NSInteger emptyRow = row - 1;
    NSInteger emptyCol = col - 1;
    
    // 移动总次数为10次，每次都随机移动一步
    for (NSInteger i = 0; i < self.complexity; i ++) {
        
        // 每次移动随机选择一个方向: 0 左，1 上，2 右，3 下
        NSInteger direction = arc4random() % 4;
        // 找到要交换的行和列
        NSInteger nextRow, nextCol;
        if (direction == 0) {
            // 向左移动
            nextRow = emptyRow;
            nextCol = emptyCol - 1;
        }else if (direction == 1) {
            // 向上移动
            nextRow = emptyRow - 1;
            nextCol = emptyCol;
        }else if (direction == 2) {
            // 向右移动
            nextRow = emptyRow;
            nextCol = emptyCol + 1;
        }else {
            // 向下移动
            nextRow = emptyRow + 1;
            nextCol = emptyCol;
        }
        
        // 判断行和列是否正确
        if (nextRow < 0 || nextRow >= row || nextCol < 0 || nextCol >= col) {
            // 行列不正确，重复本次移动
            i --;
            continue;
        }
        
        // 行列正确，移动
        // 交换空白块和选中块的位置
        // 空白块位置
        NSInteger emptyIndex = emptyRow * col + emptyCol;
        // 选中块位置
        NSInteger nextIndex = nextRow * col + nextCol;
        // 交换
        [numsArr exchangeObjectAtIndex:nextIndex withObjectAtIndex:emptyIndex];
        
        // 重置空白块位置
        emptyRow = nextRow;
        emptyCol = nextCol;
    }
    
    // 返回随机数数组
    return numsArr;
}

@end
