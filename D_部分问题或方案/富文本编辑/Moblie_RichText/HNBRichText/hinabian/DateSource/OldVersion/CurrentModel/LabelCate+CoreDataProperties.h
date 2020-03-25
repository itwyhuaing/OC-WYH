//
//  LabelCate+CoreDataProperties.h
//  hinabian
//
//  Created by hnbwyh on 16/7/28.
//  Copyright © 2016年 &#20313;&#22362;. All rights reserved.
//
//  Choose "Create NSManagedObject Subclass…" from the Core Data editor menu
//  to delete and recreate this implementation file for your updated model.
//

#import "LabelCate.h"

NS_ASSUME_NONNULL_BEGIN

@interface LabelCate (CoreDataProperties)

@property (nullable, nonatomic, retain) NSString *catename;
@property (nullable, nonatomic, retain) NSString *timestamp;

@end

NS_ASSUME_NONNULL_END
