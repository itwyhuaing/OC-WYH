//
//  RecentPHManage.h
//  hinabian
//
//  Created by 何松泽 on 2017/8/7.
//  Copyright © 2017年 &#20313;&#22362;. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <Photos/Photos.h>

@interface RecentPHManage : NSObject

@property (nonatomic, assign) NSUInteger allPHCount;

+(instancetype)defaultPHManager;
- (NSMutableArray *)getModelAssetWithCount:(NSInteger)count;
- (NSMutableArray *)getAssetWirhModelArr:(NSMutableArray *)modelArr;
- (NSMutableArray *)getPhotoWithModelArr:(NSMutableArray *)modelArr;
- (BOOL)authorizationStatusAuthorized;
- (NSString *)getAssetIdentifier:(id)asset;
- (PHImageRequestID)getPhotoWithAsset:(id)asset photoWidth:(CGFloat)photoWidth completion:(void (^)(UIImage *, NSDictionary *, BOOL isDegraded))completion;

@end
