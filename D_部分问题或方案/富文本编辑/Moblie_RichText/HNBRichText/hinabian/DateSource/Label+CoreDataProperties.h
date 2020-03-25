//
//  Label+CoreDataProperties.h
//  hinabian
//
//  Created by hnbwyh on 16/5/23.
//  Copyright © 2016年 &#20313;&#22362;. All rights reserved.
//
//  Choose "Create NSManagedObject Subclass…" from the Core Data editor menu
//  to delete and recreate this implementation file for your updated model.
//

#import "Label.h"

NS_ASSUME_NONNULL_BEGIN

@interface Label (CoreDataProperties)

@property (nullable, nonatomic, retain) NSString *cate;
@property (nullable, nonatomic, retain) NSString *name;
@property (nullable, nonatomic, retain) NSString *value;
@property (nullable, nonatomic, retain) NSString *timestamp;

@end

NS_ASSUME_NONNULL_END
