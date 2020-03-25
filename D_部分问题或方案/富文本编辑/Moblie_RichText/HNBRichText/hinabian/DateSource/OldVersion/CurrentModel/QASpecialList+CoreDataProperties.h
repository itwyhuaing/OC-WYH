//
//  QASpecialList+CoreDataProperties.h
//  hinabian
//
//  Created by hnbwyh on 16/7/28.
//  Copyright © 2016年 &#20313;&#22362;. All rights reserved.
//
//  Choose "Create NSManagedObject Subclass…" from the Core Data editor menu
//  to delete and recreate this implementation file for your updated model.
//

#import "QASpecialList.h"

NS_ASSUME_NONNULL_BEGIN

@interface QASpecialList (CoreDataProperties)

@property (nullable, nonatomic, retain) NSString *headurl;
@property (nullable, nonatomic, retain) NSString *name;
@property (nullable, nonatomic, retain) NSString *expertLabel;
@property (nullable, nonatomic, retain) NSString *signature;
@property (nullable, nonatomic, retain) NSString *userid;
@property (nullable, nonatomic, retain) NSString *timestamp;
@property (nullable, nonatomic, retain) NSString *certified;
@property (nullable, nonatomic, retain) NSString *certified_type;

@end

NS_ASSUME_NONNULL_END
