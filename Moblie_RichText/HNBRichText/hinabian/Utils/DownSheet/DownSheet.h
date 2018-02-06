

#import <UIKit/UIKit.h>
#import "DownSheetCell.h"

@protocol DownSheetDelegate <NSObject>
@optional
-(void)didSelectIndex:(NSInteger)index;
@end

@interface DownSheet : UIView<UITableViewDataSource,UITableViewDelegate,UIGestureRecognizerDelegate>{
    UITableView *view;
    NSArray *listData;
}
-(id)initWithlist:(NSArray *)list height:(CGFloat)height;
- (void)showInView:(UIView *)Sview;

@property(nonatomic,assign) id <DownSheetDelegate> delegate;

/**
 * 添加 DownSheet 到 window
 */
- (void)showDownSheetOnWindow;

/**
 * 移除 DownSheet
 */
- (void)removeDownSheet:(DownSheet *)ds animation:(BOOL)ani;

@end

