
#import "DownSheetCell.h"

@interface DownSheetCell ()

@property (nonatomic,assign) BOOL selectedStyle; // 默认 TRUE

@end

@implementation DownSheetCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
        //leftView = [[UIImageView alloc]init];
        InfoLabel = [[UILabel alloc]init];
        InfoLabel.backgroundColor = [UIColor clearColor];
        InfoLabel.textAlignment = NSTextAlignmentCenter;
        //[self.contentView addSubview:leftView];
        [self.contentView addSubview:InfoLabel];
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        _selectedStyle = TRUE;
    }
    return self;
}

-(void)layoutSubviews{
    [super layoutSubviews];
    //leftView.frame = CGRectMake(20, (self.frame.size.height-20)/2, 20, 20);
    InfoLabel.frame = CGRectMake((self.frame.size.width-140)/2, (self.frame.size.height-20)/2, 140, 20);
    //CGRectMake(leftView.frame.size.width+leftView.frame.origin.x+15, (self.frame.size.height-20)/2, 140, 20);
}

-(void)setData:(DownSheetModel *)dicdata index:(NSIndexPath *)indexPath{
    cellData = dicdata;
    //leftView.image = [UIImage imageNamed:dicdata.icon];
    InfoLabel.text = dicdata.title;
    if (dicdata.cellStyleType == DownSheetCellStyleTypeRichText) {
        _selectedStyle = FALSE;
        switch (indexPath.row) {
            case 0:
            {
                InfoLabel.textColor = [UIColor colorWithRed:68.0/255.0 green:68.0/255.0 blue:68.0/255.0 alpha:1.0];
            }
                break;
            case 1:
            {
                InfoLabel.textColor = [UIColor colorWithRed:252.0/255.0 green:46.0/255.0 blue:47.0/255.0 alpha:1.0];
            }
                break;
            case 2:
            {
                InfoLabel.textColor = [UIColor colorWithRed:102.0/255.0 green:102.0/255.0 blue:102.0/255.0 alpha:1.0];
            }
                break;
                
            default:
                break;
        }
    }else{
        _selectedStyle = TRUE;
    }
    
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];
    if (_selectedStyle) {
        if(selected){
            self.backgroundColor = RGBCOLOR(12, 102, 188);
            //leftView.image = [UIImage imageNamed:cellData.icon_on];
            InfoLabel.textColor = [UIColor whiteColor];
        }else{
            self.backgroundColor = [UIColor whiteColor];
            //leftView.image = [UIImage imageNamed:cellData.icon];
            InfoLabel.textColor = [UIColor blackColor];
        }
        // Configure the view for the selected state
    }
}

@end

