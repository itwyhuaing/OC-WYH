//
//  JSEditorPhotosUploader.m
//  RichTextProjectDemo
//
//  Created by hnbwyh on 2019/12/18.
//  Copyright © 2019 hainbwyh. All rights reserved.
//

#import "JSEditorPhotosUploader.h"

@interface JSEditorPhotosUploader ()

@property (nonatomic,strong) JSEditorHandleJs *handlerJs;

@end

@implementation JSEditorPhotosUploader

-(void)uploadImageForEditor:(WKWebView *)web data:(NSArray<PhotoModel *> *)data completion:(PhonesUploadCompletion)completion {
    if (data) {
        for (PhotoModel *f in data) {
            [self uploadImageForEditor:web model:f completion:completion];
        }
    }
}

-(void)uploadImageForEditor:(WKWebView *)web model:(PhotoModel *)model completion:(PhonesUploadCompletion)completion {
    __weak typeof(self)weakSelf = self;
    [self.handlerJs editableWeb:web insertImgBase64Str:model.editedImgBase64Str
                                                 width:[NSString stringWithFormat:@"%f",model.compatibleSize.width]
                                                height:[NSString stringWithFormat:@"%f",model.compatibleSize.height]
                                               sideGap:[NSString stringWithFormat:@"%f",model.lrGap]
                                             imageSign:model.uniqueSign
                                           loadingPath:model.loadingPath
                                         reLoadingPath:model.reloadingPath
                                            deletePath:model.deletePath
                                            completion:^(id  _Nonnull info, NSError * _Nonnull error) {
        [weakSelf.handlerJs editableWeb:web removeGrayMaskWithImageSign:model.uniqueSign completion:^(id  _Nonnull info, NSError * _Nonnull error) {
           completion ? completion(info) : nil;
        }];
    }];
}


- (void)netUploadModel {
    
}


-(JSEditorHandleJs *)handlerJs {
    if (!_handlerJs) {
        _handlerJs = [JSEditorHandleJs new];
    }
    return _handlerJs;
}

@end
