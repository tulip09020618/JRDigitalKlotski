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
    
    JRDigitalKlotskiView *dkView = [[JRDigitalKlotskiManager manager] generateDigitalKlotskiViewWithRows:4 withCols:5];
    dkView.center = self.view.center;
    [self.view addSubview:dkView];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
