//
//  CODInfo+CoreDataProperties.h
//  hinabian
//
//  Created by hnbwyh on 16/5/23.
//  Copyright © 2016年 &#20313;&#22362;. All rights reserved.
//
//  Choose "Create NSManagedObject Subclass…" from the Core Data editor menu
//  to delete and recreate this implementation file for your updated model.
//

#import "CODInfo.h"

NS_ASSUME_NONNULL_BEGIN

@interface CODInfo (CoreDataProperties)

@property (nullable, nonatomic, retain) NSString *image_url;
@property (nullable, nonatomic, retain) NSString *timestamp;
@property (nullable, nonatomic, retain) NSString *title;
@property (nullable, nonatomic, retain) NSString *url;
@property (nullable, nonatomic, retain) NSString *url_new;
@property (nullable, nonatomic, retain) NSString *timestamp2;

@end

NS_ASSUME_NONNULL_END
