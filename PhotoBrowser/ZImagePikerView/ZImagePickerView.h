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
@property (assign, nonatomic) NSInteger pictureMax;  // 因只能选一个视频 在ZLThumbnailViewController类中写死了值 修改时需注意

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

@property (nonatomic, strong) NSMutableArray<PHAsset *> *lastSelectAssets; // 记录上次选择的图片或视频

@property (nonatomic, copy) void (^selectImageBlock)(NSArray<UIImage *> *__nullable images, NSArray<PHAsset *> *assets, BOOL isOriginal);

- (void) show:(UIViewController *)viewController ;

- (void)previewSelectedPhotos:(UIViewController *)viewController lastSelectPhotos:(NSArray<UIImage *> *)images assets:(NSArray<PHAsset *> *)assets index:(NSInteger)index isOriginal:(BOOL)isOriginal;
@end

NS_ASSUME_NONNULL_END
