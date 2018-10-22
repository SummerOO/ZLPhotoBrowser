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

@property (assign, nonatomic) BOOL allowEditVideo; // 允许编辑视频

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

/**
 支持开发者自定义图片，但是所自定义图片资源名称必须与被替换的bundle中的图片名称一致
 @example: 开发者需要替换选中与未选中的图片资源，则需要传入的数组为 @[@"zl_btn_selected", @"zl_btn_unselected"]，则框架内会使用开发者项目中的图片资源，而其他图片则用框架bundle中的资源
 */
@property (nonatomic, strong) NSArray<NSString *> *customImageNames;
/**
 选择照片回调，回调解析好的图片、对应的asset对象
 */
@property (nonatomic, copy) void (^selectImageBlock)(NSArray<UIImage *> *__nullable images, NSArray<PHAsset *> *assets, NSString *url);

/**
 提供 混合预览照片及视频的方法， 相册PHAsset / 网络、本地图片 / 网络、本地视频，（需先设置 sender 参数）
 
 @warning photos 内对象请调用 ZLDefine 中 GetDictForPreviewPhoto 方法，e.g.: GetDictForPreviewPhoto(image, ZLPreviewPhotoTypeUIImage)
 
 @param photos 接收对象 ZLDefine 中 GetDictForPreviewPhoto 生成的字典
 @param index 点击的照片/视频索引
 @param hideToolBar 是否隐藏底部工具栏和导航右上角选择按钮
 @param complete 回调 (数组内为接收的 PHAsset / UIImage / NSURL 对象)
 */
- (void)previewSelectedPhotos:(UIViewController *)viewController lastSelectPhotos:(NSArray<UIImage *> *)images assets:(NSArray<PHAsset *> *)assets index:(NSInteger)index isOriginal:(BOOL)isOriginal;

- (void) show:(UIViewController *)viewController;
@end

NS_ASSUME_NONNULL_END
