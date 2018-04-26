//
//  ViewController.m
//  JRDigitalKlotski
//
//  Created by hqtech on 2018/4/25.
//  Copyright © 2018年 tulip. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

/**
 总行数
 */
@property (nonatomic, assign) NSInteger rows;

/**
 总列数
 */
@property (nonatomic, assign) NSInteger cols;

/**
 复杂度
 */
@property (nonatomic, assign) NSInteger complexity;

@property (nonatomic, strong) JRDigitalKlotskiView *dkView;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    self.rows = 5;
    self.cols = 5;
    self.complexity = (self.rows + self.cols) / 2.0 * 100;
    
    JRDigitalKlotskiView *dkView = [[JRDigitalKlotskiManager manager] generateDigitalKlotskiViewWithRows:self.rows withCols:self.cols withComplexity:self.complexity];
    dkView.center = self.view.center;
    [self.view addSubview:dkView];
    self.dkView = dkView;
    
    [JRDigitalKlotskiManager manager].success = ^{
        // 通关
        [self win];
    };
}


#pragma mark 通关
- (void)win {
    [JRUtils showAlertViewWithTitle:@"通关" withMessage:@"恭喜，您已顺利通过此关。" withActionTitle:@"确定" withActionMothed:^{
        [self reset];
    } withCancelTitle:nil withCancelMothed:nil withViewController:self];
}

#pragma mark 重置
- (void)reset {
    [self.dkView removeFromSuperview];
    
    JRDigitalKlotskiView *dkView = [[JRDigitalKlotskiManager manager] generateDigitalKlotskiViewWithRows:self.rows withCols:self.cols withComplexity:self.complexity];
    dkView.center = self.view.center;
    [self.view addSubview:dkView];
    self.dkView = dkView;
}


@end
