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
 要使用的图片
 */
@property (nonatomic, assign) NSString *imgName;

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
        // 创建数字华容道视图
        [self createDigitalKlotskiViewWithLevel];
    }else if (self.type == MODE_TYPE_FREEDOM) {
        self.titleLabel.text = @"自由模式";
        // 创建数字华容道视图
        [self createDigitalKlotskiViewWithFreedom];
    }else {
        self.titleLabel.text = @"自定义模式";
        // 创建数字华容道视图
        [self createDigitalKlotskiViewWithCustom];
    }
    
    [JRDigitalKlotskiManager manager].success = ^{
        // 通关
        [self win];
    };
}

#pragma mark 生成数字华容道视图
// 闯关模式
- (void)createDigitalKlotskiViewWithLevel {
    // 1 ~ 100 关，设置不同难度
    // 最简单:3x3, 最复杂:10x10
    NSInteger rows = 3;
    NSInteger cols = rows;
    
    if (self.levelIndex < 10) {
        rows = 3;
    }else if (self.levelIndex < 20) {
        rows = 4;
    }else if (self.levelIndex < 45) {
        rows = 5;
    }else if (self.levelIndex < 65) {
        rows = 6;
    }else if (self.levelIndex < 78) {
        rows = 7;
    }else if (self.levelIndex < 88) {
        rows = 8;
    }else if (self.levelIndex < 95) {
        rows = 9;
    }else if (self.levelIndex < 100) {
        rows = 10;
    }else if (self.levelIndex < 110) {
        rows = 11;
    }else if (self.levelIndex < 120) {
        rows = 12;
    }else {
        rows = 13;
    }
    cols = rows;
    
    // 使用默认图片
    NSString *imgName = @"football";
    
    // 创建数字华容道视图
    [self createDigitalKlotskiViewWithImg:imgName withRows:rows withCols:cols];
}

// 自由模式
- (void)createDigitalKlotskiViewWithFreedom {
    // 随机生成3~10之间的数，确定难度
    NSInteger random = arc4random() % 8 + 3;
    
    // 确定行列
    NSInteger rows = random;
    NSInteger cols = rows;
    
    // 使用默认图片
    NSString *imgName = @"football";
    
    // 创建数字华容道视图
    [self createDigitalKlotskiViewWithImg:imgName withRows:rows withCols:cols];
}

// 自定义模式
- (void)createDigitalKlotskiViewWithCustom {
    // 根据选择难度，确定行和列
    NSInteger rows = self.customLevel;
    NSInteger cols = rows;
    
    // 使用选择图片
    NSString *imgName = self.customImgName;
    
    // 创建数字华容道视图
    [self createDigitalKlotskiViewWithImg:imgName withRows:rows withCols:cols];
}

// 创建数字华容道视图
- (void)createDigitalKlotskiViewWithImg:(NSString *)imgName withRows:(NSInteger)rows withCols:(NSInteger)cols {
    self.imgName = imgName;
    self.rows = rows;
    self.cols = cols;
    
    // 设置复杂度
    self.complexity = (self.rows + self.cols) / 2.0 * 100;
    
    JRDigitalKlotskiView *dkView = [[JRDigitalKlotskiManager manager] generateDigitalKlotskiViewWithImg:imgName withRows:rows withCols:cols withComplexity:self.complexity];
    dkView.center = CGPointMake(SCREEN_WIDTH / 2.0, SCREEN_HEIGHT / 2.0);
    [self.view addSubview:dkView];
    self.dkView = dkView;
}

#pragma mark 通关
- (void)win {
    if (self.type == MODE_TYPE_LEVEL) {
        if (self.success) {
            self.success(self.levelIndex);
        }
    }
    
    [JRUtils showAlertViewWithTitle:@"解救成功" withMessage:@"门锁已开，足球已被顺利救出。您真是太聪明了，赶快带着足球继续探索吧。" withActionTitle:@"好的" withActionMothed:^{
        [self goback:nil];
    } withCancelTitle:nil withCancelMothed:nil withViewController:self];
}

- (IBAction)goback:(id)sender {
    [self dismissViewControllerAnimated:NO completion:nil];
}

- (IBAction)introduction:(id)sender {
    
    JRIntroductionViewController *introductionVC = [[JRIntroductionViewController alloc] initWithNibName:@"JRIntroductionViewController" bundle:nil];
    [self presentViewController:introductionVC animated:YES completion:nil];
    
}

#pragma mark 设置是否显示数字(默认为不显示)
- (IBAction)tapSwitch:(id)sender {
    UISwitch *s = (UISwitch *)sender;
    [[JRDigitalKlotskiManager manager] showNums:s.on];
}

@end
