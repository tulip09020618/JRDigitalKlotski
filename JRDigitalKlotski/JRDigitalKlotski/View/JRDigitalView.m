//
//  JRDigitalView.m
//  JRDigitalKlotski
//
//  Created by hqtech on 2018/4/25.
//  Copyright © 2018年 tulip. All rights reserved.
//

#import "JRDigitalView.h"

@interface JRDigitalView ()

@property (nonatomic, strong) UIButton *btn;

@end

@implementation JRDigitalView

- (instancetype)init {
    if (self = [super init]) {
        self.backgroundColor = [UIColor clearColor];
        
        self.btn = [UIButton buttonWithType:UIButtonTypeCustom];
        self.btn.backgroundColor = [UIColor whiteColor];
    }
    return self;
}

- (void)setModel:(JRDigitalModel *)model {
    
    if (_model == nil) {
        // 初始化
        self.btn.frame = CGRectMake(1, 1, self.frame.size.width - 2, self.frame.size.height - 2);
        // 设置显示内容
        [self.btn setTitle:model.num forState:UIControlStateNormal];;
        // 设置显示颜色
        [self.btn setTitleColor:[UIColor greenColor] forState:UIControlStateNormal];
        // 设置背景图片
        [self.btn setBackgroundImage:model.backImg forState:UIControlStateNormal];
        // 添加点击事件
        [self.btn addTarget:self action:@selector(tapAction:) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:self.btn];
    }
    
    _model = model;
}

#pragma mark 点击button触发的方法
- (void)tapAction:(id)sender {
    if (self.wantToMove) {
        self.wantToMove(self.model);
    }
}

@end
