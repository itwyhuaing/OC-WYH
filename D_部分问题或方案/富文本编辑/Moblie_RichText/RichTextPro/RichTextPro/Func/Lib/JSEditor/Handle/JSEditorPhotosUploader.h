//
//  JSEditorPhotosUploader.h
//  RichTextProjectDemo
//
//  Created by hnbwyh on 2019/12/18.
//  Copyright © 2019 hainbwyh. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "JSEditorHandleJs.h"
#import "JSEditorDataModel.h"

NS_ASSUME_NONNULL_BEGIN

typedef void(^PhonesUploadCompletion)(id info);
@interface JSEditorPhotosUploader : NSObject

-(void)uploadImageForEditor:(WKWebView *)web model:(PhotoModel *)model completion:(PhonesUploadCompletion)completion;

-(void)uploadImageForEditor:(WKWebView *)web data:(NSArray<PhotoModel *> *)data completion:(PhonesUploadCompletion)completion;

@end

NS_ASSUME_NONNULL_END
