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
@property (nonatomic, strong) NSArray *arrDataSources;
@property (nonatomic, assign) BOOL isOriginal;

@end

@implementation ZImagePickerView
- (instancetype)init {
    self = [super init];
    if (self) {
        self.allowEditVideo = YES;
        _lastStatusBarStyle =  [UIApplication sharedApplication].statusBarStyle;
    }
    return self;
}

- (void) show:(UIViewController *)viewController {
    ZLPhotoActionSheet *a = [self getPas:viewController];
    [a showPreviewAnimated:YES];
}

- (ZLPhotoActionSheet *)getPas:(UIViewController *)viewController {
    ZLPhotoActionSheet *actionSheet = [[ZLPhotoActionSheet alloc] init];
    
#pragma mark - 参数配置 optional，可直接使用 defaultPhotoConfiguration
    
    actionSheet.configuration.navBarColor = self.navBarColor;
    actionSheet.configuration.navTitleColor = self.navTitleColor;
    actionSheet.configuration.bottomBtnsNormalTitleColor = self.bottomBtnsNormalTitleColor;
    
    actionSheet.configuration.sortAscending = NO; //降序排列
    //设置相册内部显示拍照按钮
    actionSheet.configuration.allowTakePhotoInLibrary = NO;
    //设置照片最大预览数
    actionSheet.configuration.maxPreviewCount = 0;
    //设置照片最大选择数
    actionSheet.configuration.maxSelectCount = self.pictureMax;
    //设置允许选择的视频最大时长
    actionSheet.configuration.maxVideoDuration = self.videoMaxTime;
    
    actionSheet.configuration.allowEditVideo = self.allowEditVideo;
    actionSheet.configuration.exportVideoType = ZLExportVideoTypeMp4;
    actionSheet.configuration.allowMixSelect = NO;
    actionSheet.configuration.allowSelectOriginal = NO;
    actionSheet.configuration.customImageNames = self.customImageNames;
    actionSheet.configuration.showSelectedMask = self.showSelectedMask;
#pragma mark - required
    //如果调用的方法没有传sender，则该属性必须提前赋值
    actionSheet.sender = viewController;
    //记录上次选择的图片
    actionSheet.arrSelectedAssets = self.lastSelectAssets;
    
    for (PHAsset *asset in self.lastSelectAssets ) {
        if (asset.mediaType == PHAssetMediaTypeImage) {
            actionSheet.configuration.allowRecordVideo = NO;
        }
    }
    
    zl_weakify(self);
    [actionSheet setSelectImageBlock:^(NSArray<UIImage *> * _Nonnull images, NSArray<PHAsset *> * _Nonnull assets, BOOL isOriginal) {
        zl_strongify(weakSelf);
        NSString *videoUrl = [ZLPhotoManager getVideoExportFilePath:(ZLExportVideoTypeMp4)];
        if (strongSelf.selectImageBlock) {
            strongSelf.selectImageBlock(images, assets, videoUrl);
        }
        NSLog(@"image:%@", images);
    }];
    
    
    actionSheet.cancleBlock = ^{
        NSLog(@"取消选择图片");
    };
    
    return actionSheet;
}

- (void)previewSelectedPhotos:(UIViewController *)viewController lastSelectPhotos:(NSArray<UIImage *> *)images assets:(NSArray<PHAsset *> *)assets index:(NSInteger)index isOriginal:(BOOL)isOriginal {
    [[self getPas: viewController] previewSelectedPhotos:images assets:assets index:index isOriginal:isOriginal];
}
@end
