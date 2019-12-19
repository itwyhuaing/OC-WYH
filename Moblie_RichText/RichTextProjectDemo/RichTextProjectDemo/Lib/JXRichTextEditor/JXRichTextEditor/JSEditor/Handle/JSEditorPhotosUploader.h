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

-(void)uploadImageWithModel:(PhotoModel *)model completion:(PhonesUploadCompletion)completion;

-(void)uploadImageWithData:(NSArray<PhotoModel *> *)data completion:(PhonesUploadCompletion)completion;

@end

NS_ASSUME_NONNULL_END
