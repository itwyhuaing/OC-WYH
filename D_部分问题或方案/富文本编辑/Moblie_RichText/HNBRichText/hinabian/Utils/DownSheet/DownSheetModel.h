#import <Foundation/Foundation.h>

typedef enum : NSUInteger {
    DownSheetCellStyleTypeNormal = 100,
    DownSheetCellStyleTypeRichText,
} DownSheetCellStyleType;

@interface DownSheetModel : NSObject
@property(nonatomic,strong) NSString *icon;
@property(nonatomic,strong) NSString *icon_on;
@property(nonatomic,strong) NSString *title;
@property (nonatomic,assign) DownSheetCellStyleType cellStyleType;
@end
