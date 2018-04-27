//
//  JRUtils.m
//  JRDigitalKlotski
//
//  Created by hqtech on 2018/4/26.
//  Copyright © 2018年 tulip. All rights reserved.
//

#import "JRUtils.h"

@implementation JRUtils

#pragma mark --弹框提示
+ (void)showAlertViewWithTitle:(NSString *)title
                   withMessage:(NSString *)message
               withActionTitle:(NSString *)actionTitle
              withActionMothed:(void (^)(void))actionMothed
               withCancelTitle:(NSString *)cancelTitle
              withCancelMothed:(void (^)(void))cancelMothed
            withViewController:(UIViewController *)viewController
{
    
    UIAlertController *alertCon = [UIAlertController alertControllerWithTitle:title message:message preferredStyle:UIAlertControllerStyleAlert];
    [alertCon addAction:[UIAlertAction actionWithTitle:actionTitle style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        if (actionMothed) {
            actionMothed();
        }
    }]];
    if (cancelTitle) {
        [alertCon addAction:[UIAlertAction actionWithTitle:cancelTitle style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
            if (cancelMothed) {
                cancelMothed();
            }
        }]];
    }
    [viewController presentViewController:alertCon animated:YES completion:nil];
    
}

#pragma mark 切割图片
+ (NSArray<UIImage *> *)cutImage:(UIImage *)originalImg withRows:(NSInteger)rows withCols:(NSInteger)cols {

    // 切割后的每一个小图片的大小
    CGSize size = CGSizeMake(originalImg.size.width/cols, originalImg.size.height/rows);
    
    // 存放切割图片的数组
    NSMutableArray *imgsArr = [NSMutableArray arrayWithCapacity:0];
    
    // 切割图片
    for (NSInteger i = 0; i < rows * cols; i ++) {
        // 当前行
        NSInteger iRow = i / cols;
        // 当前列
        NSInteger iCol = i % cols;
        // 创建上下文(大小，是否透明，缩放)
        UIGraphicsBeginImageContextWithOptions(size, NO, 0);
        // 设置截图原点(由于上下文坐标系与图片自身坐标系是相反的，所以绘制坐标需要取反)
        [originalImg drawAtPoint:CGPointMake(- size.width * iCol, - size.height * iRow)];
        // 获取图片
        UIImage *img = UIGraphicsGetImageFromCurrentImageContext();
        // 保存图片
        [imgsArr addObject:img];
    }
    
    return imgsArr;
}

@end
