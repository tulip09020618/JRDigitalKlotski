//
//  ViewController.m
//  JRDigitalKlotski
//
//  Created by hqtech on 2018/4/25.
//  Copyright © 2018年 tulip. All rights reserved.
//

#import "ViewController.h"
#import "JRSelectLevelViewController.h"
#import "JRCustomViewController.h"
#import "JRIntroductionViewController.h"
#import "JRLevelDetailsViewController.h"

@interface ViewController ()

@property (nonatomic, strong) JRDigitalKlotskiView *dkView;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
}

#pragma mark 闯关模式
- (IBAction)presentToSelectLevelMode:(id)sender {
    JRSelectLevelViewController *selectVC = [[JRSelectLevelViewController alloc] initWithNibName:@"JRSelectLevelViewController" bundle:nil];
    [self presentViewController:selectVC animated:NO completion:nil];
}

#pragma mark 自由模式
- (IBAction)presentToFreedomMode:(id)sender {
    JRLevelDetailsViewController *detailsVC = [[JRLevelDetailsViewController alloc] initWithNibName:@"JRLevelDetailsViewController" bundle:nil];
    detailsVC.type = MODE_TYPE_FREEDOM;
    [self presentViewController:detailsVC animated:NO completion:nil];
}

#pragma mark 自定义模式
- (IBAction)presentToCustomMode:(id)sender {
    JRCustomViewController *customVC = [[JRCustomViewController alloc] initWithNibName:@"JRCustomViewController" bundle:nil];
    [self presentViewController:customVC animated:NO completion:nil];
}

#pragma mark 玩法介绍
- (IBAction)presentToIntroduction:(id)sender {
    JRIntroductionViewController *introductionVC = [[JRIntroductionViewController alloc] initWithNibName:@"JRIntroductionViewController" bundle:nil];
    [self presentViewController:introductionVC animated:YES completion:nil];
}


@end
