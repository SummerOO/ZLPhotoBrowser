//
//  ZImagePickerView.m
//  ZLPhotoBrowser
//
//  Created by Chris on 2018/10/17.
//  Copyright © 2018年 long. All rights reserved.
//

#import "ZImagePickerView.h"
#import "ZLPhotoActionSheet.h"
#import "ZLPhotoManager.h"
#import "ZLCustomCamera.h"
#import <MobileCoreServices/MobileCoreServices.h>

@interface ZImagePickerView() {
    UIStatusBarStyle _lastStatusBarStyle;
}
@property (nonatomic, strong) NSMutableArray<UIImage *> *lastSelectPhotos;
@property (nonatomic, strong) NSMutableArray<PHAsset *> *lastSelectAssets;
@property (nonatomic, strong) NSArray *arrDataSources;
@property (nonatomic, assign) BOOL isOriginal;

@end

@implementation ZImagePickerView
- (instancetype)init {
    self = [super init];
    if (self) {
        _lastStatusBarStyle =  [UIApplication sharedApplication].statusBarStyle;
    }
    return self;
}

- (void) show:(UIViewController *)viewController {
    ZLPhotoActionSheet *a = [self getPas:viewController];
    
//    if (preview) {
        [a showPreviewAnimated:YES];
//    } else {
//        [a showPhotoLibrary];
//    }
}

- (ZLPhotoActionSheet *)getPas:(UIViewController *)viewController {
    ZLPhotoActionSheet *actionSheet = [[ZLPhotoActionSheet alloc] init];
    
#pragma mark - 参数配置 optional，可直接使用 defaultPhotoConfiguration
    
    //设置相册内部显示拍照按钮
    actionSheet.configuration.allowTakePhotoInLibrary = NO;
    //设置照片最大预览数
    actionSheet.configuration.maxPreviewCount = 0;
    //设置照片最大选择数
    actionSheet.configuration.maxSelectCount = self.pictureMax;
    //设置允许选择的视频最大时长
    actionSheet.configuration.maxVideoDuration = self.videoMaxTime;
    //单选模式是否显示选择按钮
    //    actionSheet.configuration.showSelectBtn = YES;
    //是否在选择图片后直接进入编辑界面
//    actionSheet.configuration.editAfterSelectThumbnailImage = self.editAfterSelectImageSwitch.isOn;
    //是否保存编辑后的图片
    //    actionSheet.configuration.saveNewImageAfterEdit = NO;
    //设置编辑比例
    //    actionSheet.configuration.clipRatios = @[GetClipRatio(7, 1)];
    //是否在已选择照片上显示遮罩层
    actionSheet.configuration.showSelectedMask = self.showSelectedMask;
    //颜色，状态栏样式
    //    actionSheet.configuration.selectedMaskColor = [UIColor purpleColor];
    //    actionSheet.configuration.navBarColor = [UIColor orangeColor];
    //    actionSheet.configuration.navTitleColor = [UIColor blackColor];
    //    actionSheet.configuration.bottomBtnsNormalTitleColor = kRGB(80, 160, 100);
    //    actionSheet.configuration.bottomBtnsDisableBgColor = kRGB(190, 30, 90);
    //    actionSheet.configuration.bottomViewBgColor = [UIColor blackColor];
    //    actionSheet.configuration.statusBarStyle = UIStatusBarStyleDefault;
    //是否允许框架解析图片
//    actionSheet.configuration.shouldAnialysisAsset = self.allowAnialysisAssetSwitch.isOn;
    //框架语言
    //自定义图片
    //    actionSheet.configuration.customImageNames = @[@"zl_navBack"];
    
    //是否使用系统相机
    //    actionSheet.configuration.useSystemCamera = YES;
    //    actionSheet.configuration.sessionPreset = ZLCaptureSessionPreset1920x1080;
    //    actionSheet.configuration.exportVideoType = ZLExportVideoTypeMp4;
    //    actionSheet.configuration.allowRecordVideo = NO;
    //    actionSheet.configuration.maxVideoDuration = 5;
#pragma mark - required
    //如果调用的方法没有传sender，则该属性必须提前赋值
    actionSheet.sender = viewController;
    //记录上次选择的图片
    actionSheet.arrSelectedAssets = YES && self.pictureMax >1 ? self.lastSelectAssets : nil;
    
    zl_weakify(self);
    [actionSheet setSelectImageBlock:^(NSArray<UIImage *> * _Nonnull images, NSArray<PHAsset *> * _Nonnull assets, BOOL isOriginal) {
        zl_strongify(weakSelf);
        strongSelf.arrDataSources = images;
        strongSelf.isOriginal = isOriginal;
        strongSelf.lastSelectAssets = assets.mutableCopy;
        strongSelf.lastSelectPhotos = images.mutableCopy;
        NSLog(@"image:%@", images);
        //解析图片
//        if (!strongSelf.allowAnialysisAssetSwitch.isOn) {
//            [strongSelf anialysisAssets:assets original:isOriginal];
//        }
    }];
    
    actionSheet.cancleBlock = ^{
        NSLog(@"取消选择图片");
    };
    
    return actionSheet;
}
@end
