//
//  JRLevelDetailsViewController.m
//  JRDigitalKlotski
//
//  Created by hqtech on 2018/4/26.
//  Copyright © 2018年 tulip. All rights reserved.
//

#import "JRLevelDetailsViewController.h"
#import "JRIntroductionViewController.h"

@interface JRLevelDetailsViewController ()

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

@property (weak, nonatomic) IBOutlet UILabel *titleLabel;

@end

@implementation JRLevelDetailsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    if (self.type == MODE_TYPE_LEVEL) {
        self.titleLabel.text = [NSString stringWithFormat:@"第%ld关", self.levelIndex+1];
    }else if (self.type == MODE_TYPE_FREEDOM) {
        self.titleLabel.text = @"自由模式";
    }else {
        self.titleLabel.text = @"自定义模式";
    }
    
    self.rows = 5;
    self.cols = 5;
    self.complexity = (self.rows + self.cols) / 2.0 * 100;
    
    JRDigitalKlotskiView *dkView = [[JRDigitalKlotskiManager manager] generateDigitalKlotskiViewWithRows:self.rows withCols:self.cols withComplexity:self.complexity];
    dkView.center = CGPointMake(SCREEN_WIDTH / 2.0, SCREEN_HEIGHT / 2.0);
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

- (IBAction)goback:(id)sender {
    [self dismissViewControllerAnimated:NO completion:nil];
}

- (IBAction)introduction:(id)sender {
    
    JRIntroductionViewController *introductionVC = [[JRIntroductionViewController alloc] initWithNibName:@"JRIntroductionViewController" bundle:nil];
    [self presentViewController:introductionVC animated:YES completion:nil];
    
}
@end
