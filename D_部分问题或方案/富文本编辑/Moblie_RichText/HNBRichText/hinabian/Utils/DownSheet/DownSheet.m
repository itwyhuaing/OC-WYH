
#import "DownSheet.h"
@implementation DownSheet

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
    }
    return self;
}

-(id)initWithlist:(NSArray *)list height:(CGFloat)height{
    self = [super init];
    if(self){
        self.frame = CGRectMake(0, 0, SCREEN_WIDTH, ((float)SCREEN_HEIGHT) - ((float)SCREEN_NAVHEIGHT)-((float)SCREEN_STATUSHEIGHT) - SUIT_IPHONE_X_HEIGHT);
        self.backgroundColor = RGBACOLOR(160, 160, 160, 0);
        view = [[UITableView alloc]initWithFrame:CGRectMake(0, ((float)SCREEN_HEIGHT) - ((float)SCREEN_NAVHEIGHT)-((float)SCREEN_STATUSHEIGHT) - SUIT_IPHONE_X_HEIGHT, SCREEN_WIDTH,44*[list count]) style:UITableViewStylePlain];
        view.dataSource = self;
        view.delegate = self;
        listData = list;
        view.scrollEnabled = NO;
        [self addSubview:view];
        [self animeData];
    }
    return self;
}

-(void)animeData{
    //self.userInteractionEnabled = YES;
    UITapGestureRecognizer *tapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tappedCancel)];
    [self addGestureRecognizer:tapGesture];
    tapGesture.delegate = self;
    [UIView animateWithDuration:.25 animations:^{
        self.backgroundColor = RGBACOLOR(160, 160, 160, .4);
        [UIView animateWithDuration:.25 animations:^{
            [view setFrame:CGRectMake(view.frame.origin.x, ((float)SCREEN_HEIGHT) - ((float)SCREEN_NAVHEIGHT)-((float)SCREEN_STATUSHEIGHT) - SUIT_IPHONE_X_HEIGHT -view.frame.size.height, view.frame.size.width, view.frame.size.height)];
        }];
    } completion:^(BOOL finished) {
    }];
}

- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldReceiveTouch:(UITouch *)touch{
    if([touch.view isKindOfClass:[self class]]){
        return YES;
    }
    return NO;
}

-(void)tappedCancel{
    [UIView animateWithDuration:.25 animations:^{
        [view setFrame:CGRectMake(0, ((float)SCREEN_HEIGHT) - ((float)SCREEN_NAVHEIGHT)-((float)SCREEN_STATUSHEIGHT) - SUIT_IPHONE_X_HEIGHT,SCREEN_WIDTH, 0)];
        self.alpha = 0;
    } completion:^(BOOL finished) {
        if (finished) {
            [self removeFromSuperview];
        }
    }];
}

- (void)removeDownSheet:(DownSheet *)ds animation:(BOOL)ani{

    if (ani) {
        
        [UIView animateWithDuration:.25 animations:^{
            [view setFrame:CGRectMake(0, (float)SCREEN_HEIGHT,SCREEN_WIDTH, 0)];
            self.alpha = 0;
        } completion:^(BOOL finished) {
            [self removeFromSuperview];
        }];
        
    } else {
        [self removeFromSuperview];
    }
    
}

- (void)showInView:(UIView *)Sview
{
    [Sview addSubview:self];
}

- (void)showDownSheetOnWindow{

    [[UIApplication sharedApplication].keyWindow addSubview:self];
    CGRect rect = CGRectZero;
    rect.size.width = SCREEN_WIDTH;
    rect.size.height = 44 * listData.count;
    rect.origin.y = ((float)SCREEN_HEIGHT) - rect.size.height;
    [view setFrame:rect];
    [self setFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT)];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    // Return the number of rows in the section.
    return [listData count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    DownSheetCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if(cell==nil){
        cell = [[DownSheetCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
    }
    [cell setData:[listData objectAtIndex:indexPath.row] index:indexPath];
    // Configure the cell...
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [self tappedCancel];
    if(_delegate!=nil && [_delegate respondsToSelector:@selector(didSelectIndex:)]){
        [_delegate didSelectIndex:indexPath.row];
        return;
    }
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/

@end

