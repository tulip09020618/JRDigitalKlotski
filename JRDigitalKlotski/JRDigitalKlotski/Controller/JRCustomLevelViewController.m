//
//  JRCustomLevelViewController.m
//  JRDigitalKlotski
//
//  Created by hqtech on 2018/4/27.
//  Copyright © 2018年 tulip. All rights reserved.
//

#import "JRCustomLevelViewController.h"
#import "JRLevelDetailsViewController.h"

@interface JRCustomLevelViewController ()

@property (weak, nonatomic) IBOutlet UIScrollView *scrollView;

/**
 存放图片的数组
 */
@property (nonatomic, strong) NSMutableArray *imgsArr;

@end

@implementation JRCustomLevelViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    // 初始化数据源
    UIImage *originalImg = [UIImage imageNamed:self.imgName];
    self.imgsArr = [NSMutableArray arrayWithArray:@[
                                                    [JRUtils cutImage:originalImg withRows:3 withCols:3],
                                                    [JRUtils cutImage:originalImg withRows:4 withCols:4],
                                                    [JRUtils cutImage:originalImg withRows:5 withCols:5],
                                                    [JRUtils cutImage:originalImg withRows:6 withCols:6],
                                                    [JRUtils cutImage:originalImg withRows:7 withCols:7],
                                                    [JRUtils cutImage:originalImg withRows:8 withCols:8],
                                                    [JRUtils cutImage:originalImg withRows:9 withCols:9],
                                                    [JRUtils cutImage:originalImg withRows:10 withCols:10],
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
        backView.backgroundColor = [UIColor lightGrayColor];
        [self.scrollView addSubview:backView];
        
        // 小图片数组
        NSArray *arr = self.imgsArr[i];
        // 每个小图片的宽高
        CGFloat littleW = width / (i + 3);
        CGFloat littleH = littleW;
        
        for (NSInteger j = 0; j < arr.count; j ++) {
            // 计算所在行和列
            NSInteger jRow = j / (i + 3);
            NSInteger jCol = j % (i + 3);
            
            // 每个小块的背景视图
            UIView *littleBackView = [[UIView alloc] initWithFrame:CGRectMake(littleW * jCol, littleH * jRow, littleW, littleH)];
            littleBackView.backgroundColor = [UIColor whiteColor];
            [backView addSubview:littleBackView];
            
            // 每个小块上的图片
            UIImage *littleImg = arr[j];
            UIImageView *littleImgView = [[UIImageView alloc] initWithFrame:CGRectMake(1, 1, littleW - 2, littleH - 2)];
            littleImgView.image = littleImg;
            [littleBackView addSubview:littleImgView];
        }
        
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
    
    NSLog(@"选择难度：%ld", index + 3);
    
    JRLevelDetailsViewController *detailsVC = [[JRLevelDetailsViewController alloc] initWithNibName:@"JRLevelDetailsViewController" bundle:nil];
    detailsVC.type = MODE_TYPE_CUSTOM;
    detailsVC.customImgName = self.imgName;
    detailsVC.customLevel = index + 3;
    [self presentViewController:detailsVC animated:NO completion:nil];
    
}

- (IBAction)goback:(id)sender {
    [self dismissViewControllerAnimated:NO completion:nil];
}

@end
