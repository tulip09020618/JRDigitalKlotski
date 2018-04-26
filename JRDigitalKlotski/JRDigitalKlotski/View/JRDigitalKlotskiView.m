//
//  JRDigitalKlotskiView.m
//  JRDigitalKlotski
//
//  Created by hqtech on 2018/4/25.
//  Copyright © 2018年 tulip. All rights reserved.
//

#import "JRDigitalKlotskiView.h"

@interface JRDigitalKlotskiView ()

/**
 每个小数据模块的宽
 */
@property (nonatomic, assign) CGFloat perWidth;

/**
 每个小数据模块的高
 */
@property (nonatomic, assign) CGFloat perHeight;

/**
 空白块所在行
 */
@property (nonatomic, assign) NSInteger emptyRow;

/**
 空白块所在列
 */
@property (nonatomic, assign) NSInteger emptyCol;

@end

@implementation JRDigitalKlotskiView

- (instancetype)initWithRows:(NSInteger)rows withCols:(NSInteger)cols {
    if (self = [super init]) {
        self.totalRows = rows;
        self.totalCols = cols;
        
        // 宽、高
        CGFloat width = SCREEN_WIDTH - 20;
        CGFloat height = width;
        self.frame = CGRectMake(0, 0, width, height);
        self.backgroundColor = [UIColor lightGrayColor];
        
        // 每个数据块的宽高
        self.perWidth = width / cols;
        self.perHeight = height / rows;
        
    }
    return self;
}

#pragma mark 生成随机数据模块
/**
 生成随机数据模块视图(根据一组不重复的随机数)
 */
- (void)generateRandomDigitalView:(NSArray<NSString *> *)randonNums {
    
    if (randonNums.count != self.totalRows * self.totalCols) {
        NSLog(@"数据错误");
        return;
    }
    
    for (NSInteger i = 0; i < self.totalRows * self.totalCols; i ++) {
        
        // 当前所在行列
        NSInteger iRow = i / self.totalCols;
        NSInteger iCol = i % self.totalCols;
        NSLog(@"row:%ld, col:%ld", iRow, iCol);
        
        if ([randonNums[i] integerValue] == self.totalRows * self.totalCols) {
            // 最后一个为空白块
            // 记录空白块的行列
            self.emptyRow = iRow;
            self.emptyCol = iCol;
            continue;
        }
        
        // 数据模型
        JRDigitalModel *model = [[JRDigitalModel alloc] initWithNum:randonNums[i] withRow:iRow withCol:iCol];
        
        // 每个小数据模块视图
        JRDigitalView *dView = [[JRDigitalView alloc] init];
        dView.frame = CGRectMake(iCol * self.perWidth, iRow * self.perHeight, self.perWidth, self.perHeight);
        dView.model = model;
        __weak typeof(self) weakSelf = self;
        __weak JRDigitalView *weakDView = dView;
        dView.wantToMove = ^(JRDigitalModel *model) {
            [weakSelf moveDigitalView:weakDView withModel:model];
        };
        
        [self addSubview:dView];
    }
}

#pragma mark 移动
- (void)moveDigitalView:(JRDigitalView *)dView withModel:(JRDigitalModel *)model {
    // 判断是否能移动
    if ([model canMoveWithEmptyRow:self.emptyRow withEmptyCol:self.emptyCol]) {
        // 可以移动
        
        // 缓存当前model的行列
        NSInteger oldRow = model.row;
        NSInteger oldCol = model.col;
        
        // 移动model
        [model moveWithEmptyRow:self.emptyRow withEmptyCol:self.emptyCol];
        // 更新数据模块的model
        dView.model = model;
        // 移动数据模块视图
        [UIView animateWithDuration:0.1 animations:^{
            dView.frame = CGRectMake(model.col * self.perWidth, model.row * self.perHeight, self.perWidth, self.perHeight);
        }];
        
        // 重置空白块
        self.emptyRow = oldRow;
        self.emptyCol = oldCol;
    }
}

@end
