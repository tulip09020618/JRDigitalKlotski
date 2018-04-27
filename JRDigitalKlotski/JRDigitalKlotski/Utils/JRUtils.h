//
//  JRUtils.h
//  JRDigitalKlotski
//
//  Created by hqtech on 2018/4/26.
//  Copyright © 2018年 tulip. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface JRUtils : NSObject

#pragma mark --弹框提示
+ (void)showAlertViewWithTitle:(NSString *)title
                   withMessage:(NSString *)message
               withActionTitle:(NSString *)actionTitle
              withActionMothed:(void (^)(void))actionMothed
               withCancelTitle:(NSString *)cancelTitle
              withCancelMothed:(void (^)(void))cancelMothed
            withViewController:(UIViewController *)viewController;

#pragma mark 切割图片(将一张图片，切割成m行n列的小图片)
/**
 切割图片(将一张图片，切割成m行n列的小图片)

 @param originalImg 原始图片
 @param rows 切割的总行数
 @param cols 切割的总列数
 @return 切割后的图片数组
 */
+ (NSArray<UIImage *> *)cutImage:(UIImage *)originalImg withRows:(NSInteger)rows withCols:(NSInteger)cols;

#pragma mark 下载文件
+ (void)downLoadFile;

@end
