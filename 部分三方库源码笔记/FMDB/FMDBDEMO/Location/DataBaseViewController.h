//
//  DataBaseViewController.h
//  Location
//
//  Created by admin on 14-11-17.
//  Copyright (c) 2014年 admin. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DataBaseViewController : UIViewController
@property (weak, nonatomic) IBOutlet UITextField *nameTextField;
@property (weak, nonatomic) IBOutlet UITextField *sexTextField;
@property (weak, nonatomic) IBOutlet UITextField *ageTextField;

- (IBAction)save:(id)sender;
- (IBAction)query:(id)sender;
- (IBAction)queryByCondition:(id)sender;
- (IBAction)update:(id)sender;
- (IBAction)deleteByCondition:(id)sender;

@end
