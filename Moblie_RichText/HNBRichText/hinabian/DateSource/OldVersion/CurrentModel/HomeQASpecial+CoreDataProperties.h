//
//  HomeQASpecial+CoreDataProperties.h
//  hinabian
//
//  Created by hnbwyh on 16/5/30.
//  Copyright © 2016年 &#20313;&#22362;. All rights reserved.
//
//  Choose "Create NSManagedObject Subclass…" from the Core Data editor menu
//  to delete and recreate this implementation file for your updated model.
//

#import "HomeQASpecial.h"

NS_ASSUME_NONNULL_BEGIN

@interface HomeQASpecial (CoreDataProperties)

@property (nullable, nonatomic, retain) NSString *title;
@property (nullable, nonatomic, retain) NSString *desc;
@property (nullable, nonatomic, retain) NSString *head_url;
@property (nullable, nonatomic, retain) NSString *id;

@end

NS_ASSUME_NONNULL_END
