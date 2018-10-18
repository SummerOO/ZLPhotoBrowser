//
//  ZImagePickerView.h
//  ZLPhotoBrowser
//
//  Created by Chris on 2018/10/17.
//  Copyright © 2018年 long. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ZLPhotoConfiguration.h"

NS_ASSUME_NONNULL_BEGIN

@interface ZImagePickerView : NSObject

/**
 视频最长时间
 */
@property (assign, nonatomic) NSInteger videoMaxTime;
/**
 最大照片张数
 */
@property (assign, nonatomic) NSInteger pictureMax;

@property (assign, nonatomic) BOOL showSelectedMask; // 是否在已选图片上显示遮罩层

@property (assign, nonatomic) BOOL allowEditVideo; // x允许编辑视频

@property (nonatomic, strong) UIColor *navBarColor;

/**
 导航标题颜色，默认 rgb(255, 255, 255)
 */
@property (nonatomic, strong) UIColor *navTitleColor;

/**
 底部工具条底色，
 */
@property (nonatomic, strong) UIColor *bottomViewBgColor;

/**
 底部工具栏按钮 可交互 状态标题颜色，底部 toolbar 按钮可交互状态title颜色均使用这个，确定按钮 可交互 的背景色为这个，默认rgb(80, 180, 234)
 */
@property (nonatomic, strong) UIColor *bottomBtnsNormalTitleColor;

- (void) show:(UIViewController *)viewController ;

@end

NS_ASSUME_NONNULL_END
