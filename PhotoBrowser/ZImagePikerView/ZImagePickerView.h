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

- (void) show:(UIViewController *)viewController ;

@end

NS_ASSUME_NONNULL_END
