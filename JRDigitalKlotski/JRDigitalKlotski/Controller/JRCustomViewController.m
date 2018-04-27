//
//  JRCustomViewController.m
//  JRDigitalKlotski
//
//  Created by hqtech on 2018/4/26.
//  Copyright © 2018年 tulip. All rights reserved.
//

#import "JRCustomViewController.h"
#import "JRCustomLevelViewController.h"

@interface JRCustomViewController ()

@property (weak, nonatomic) IBOutlet UIScrollView *scrollView;

/**
 存放图片的数组
 */
@property (nonatomic, strong) NSMutableArray *imgsArr;

@end

@implementation JRCustomViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    // 初始化数据源
    self.imgsArr = [NSMutableArray arrayWithArray:@[
                                                    @"football",
                                                    @"football01",
                                                    @"football02",
                                                    @"football03",
                                                    @"football04",
                                                    ]];
    
    // 添加图片
    [self addImgs];
}

#pragma mark 添加图片
- (void)addImgs {
    
    // 图片数量
    NSInteger count = self.imgsArr.count;
    
    // 每张图片宽高
    CGFloat width = SCREEN_WIDTH;
    CGFloat height = width;
    
    [self.scrollView setContentSize:CGSizeMake(width * count, height)];
    
    for (NSInteger i = 0; i < count; i ++) {
        UIView *backView = [[UIView alloc] initWithFrame:CGRectMake(width * i, 0, width, height)];
        backView.backgroundColor = [UIColor whiteColor];
        [self.scrollView addSubview:backView];
        
        NSString * imgName = self.imgsArr[i];
        UIImageView *imgView = [[UIImageView alloc] initWithFrame:CGRectMake(10, 10, width - 20, height - 20)];
        imgView.image = [UIImage imageNamed:imgName];
        [backView addSubview:imgView];
        
        UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
        btn.frame = CGRectMake(0, 0, width, height);
        [btn addTarget:self action:@selector(tapAction:) forControlEvents:UIControlEventTouchUpInside];
        btn.tag = i + 100;
        [backView addSubview:btn];
    }
    
}

#pragma mark 点击按钮
- (void)tapAction:(id)sender {
    UIButton *btn = (UIButton *)sender;
    NSInteger index = btn.tag - 100;
    
    NSString *imgName = self.imgsArr[index];
    
    NSLog(@"选择图片：%@", imgName);
    
    JRCustomLevelViewController *levelVC = [[JRCustomLevelViewController alloc] initWithNibName:@"JRCustomLevelViewController" bundle:nil];
    levelVC.imgName = imgName;
    [self presentViewController:levelVC animated:NO completion:nil];
}

- (IBAction)goback:(id)sender {
    [self dismissViewControllerAnimated:NO completion:nil];
}

@end
