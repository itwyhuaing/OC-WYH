
#import <UIKit/UIKit.h>
#define RGBCOLOR(r, g, b)       [UIColor colorWithRed:(r)/255.0f green:(g)/255.0f blue:(b)/255.0f alpha:1]
#define RGBACOLOR(r, g, b, a)   [UIColor colorWithRed:(r)/255.0f green:(g)/255.0f blue:(b)/255.0f alpha:(a)]
//获取设备的物理高度
#define ScreenHeight [UIScreen mainScreen].bounds.size.height
//获取设备的物理宽度
#define ScreenWidth [UIScreen mainScreen].bounds.size.width
#import "DownSheetModel.h"
@interface DownSheetCell : UITableViewCell{
    //UIImageView *leftView;
    UILabel *InfoLabel;
    DownSheetModel *cellData;
    UIView *backgroundView;
}
-(void)setData:(DownSheetModel *)dicdata index:(NSIndexPath *)indexPath;
@end

