//
//  JRLevelDetailsViewController.h
//  JRDigitalKlotski
//
//  Created by hqtech on 2018/4/26.
//  Copyright © 2018年 tulip. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSUInteger, MODE_TYPE) {
    MODE_TYPE_LEVEL, // 闯关模式
    MODE_TYPE_FREEDOM, // 自由模式
    MODE_TYPE_CUSTOM, // 自定义模式
};

@interface JRLevelDetailsViewController : UIViewController

/**
 模式类型
 */
@property (nonatomic, assign) MODE_TYPE type;

/**
 第几关(闯关模式)
 */
@property (nonatomic, assign) NSInteger levelIndex;

/**
 选择的图片名称(自定义模式)
 */
@property (nonatomic, strong) NSString *imgName;

/**
 难度等级(自定义模式)
 */
@property (nonatomic, assign) NSInteger customLevel;

/**
 闯关成功
 */
@property (nonatomic, strong) void (^success) (NSInteger levelIndex);

@end
