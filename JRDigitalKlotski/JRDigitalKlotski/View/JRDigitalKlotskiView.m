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
 要分割的图片名称
 */
@property (nonatomic, strong) NSString *imgName;

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

- (instancetype)initWithImg:(NSString *)imgName withRows:(NSInteger)rows withCols:(NSInteger)cols {
    if (self = [super init]) {
        self.imgName = imgName;
        
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
    
    // 获取切割图片
    UIImage *originalImg = [UIImage imageNamed:self.imgName];
    NSArray *imgsArr = [JRUtils cutImage:originalImg withRows:self.totalRows withCols:self.totalCols];
    if (imgsArr.count != self.totalRows * self.totalCols) {
        NSLog(@"获取切割图片错误");
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
        // 每个小数据块对应的背景图
        UIImage *backImg = imgsArr[[model.num integerValue] - 1];
        model.backImg = backImg;
        
        // 每个小数据模块视图
        JRDigitalView *dView = [[JRDigitalView alloc] init];
        dView.frame = CGRectMake(iCol * self.perWidth, iRow * self.perHeight, self.perWidth, self.perHeight);
        dView.model = model;
        dView.tag = i + 100;
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
        
        // 检测是否通过
        [self checkAllMode];
    }
}

#pragma mark 检测所有数据块是否全部归位
- (void)checkAllMode {
    for (NSInteger i = 0; i < self.totalRows * self.totalCols; i ++) {
        JRDigitalView *dView = (JRDigitalView *)[self viewWithTag:100 + i];
        if (dView == nil) {
            // 排除空白块
            continue;
        }
        JRDigitalModel *model = dView.model;
        if (model.row * self.totalCols + model.col != [model.num integerValue] - 1) {
            // 未通过检测
            return;
        }
    }
    
    // 全部通过检测
    if (self.checkSuccess) {
        self.checkSuccess();
    }
}

@end
