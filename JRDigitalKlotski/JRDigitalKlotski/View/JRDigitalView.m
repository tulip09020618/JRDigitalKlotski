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
        self.btn.backgroundColor = [UIColor greenColor];
    }
    return self;
}

- (void)setFrame:(CGRect)frame {
    [super setFrame:frame];
    
    self.btn.frame = CGRectMake(1, 1, frame.size.width - 2, frame.size.height - 2);
    [self addSubview:self.btn];
}

- (void)setModel:(JRDigitalModel *)model {
    [self.btn setTitle:model.num forState:UIControlStateNormal];;
    [self.btn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
}

@end
