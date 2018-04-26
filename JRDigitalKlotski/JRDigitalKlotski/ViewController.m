//
//  ViewController.m
//  JRDigitalKlotski
//
//  Created by hqtech on 2018/4/25.
//  Copyright © 2018年 tulip. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    JRDigitalKlotskiView *dkView = [[JRDigitalKlotskiManager manager] generateDigitalKlotskiViewWithRows:3 withCols:3];
    dkView.center = self.view.center;
    [self.view addSubview:dkView];
    
    [JRDigitalKlotskiManager manager].success = ^{
        // 通关
        [self win];
    };
}


#pragma mark 通关
- (void)win {
    [JRUtils showAlertViewWithTitle:@"通关" withMessage:@"恭喜，您已顺利通过此关。" withActionTitle:@"确定" withActionMothed:^{
        
    } withCancelTitle:nil withCancelMothed:nil withViewController:self];
}


@end
