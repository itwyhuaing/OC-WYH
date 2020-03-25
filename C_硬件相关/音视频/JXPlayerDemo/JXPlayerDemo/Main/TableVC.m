//
//  TableVC.m
//  JXPlayerDemo
//
//  Created by hnbwyh on 2019/1/24.
//  Copyright © 2019年 JiXia. All rights reserved.
//

#import "TableVC.h"
#import "VoiceAVPlayerVC.h"
#import "BaseFuncVC.h"

static NSString *kTHEM          = @"them";
static NSString *kVC            = @"vc";
static NSString *kType          = @"type";

@interface TableVC ()

@property (nonatomic,strong)        NSMutableArray<NSDictionary *> *cnts;

@end

@implementation TableVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = NSStringFromClass(self.class);
}

#pragma mark - Table view data source

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.cnts.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"CntCellID"];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"CntCellID"];
    }
    cell.textLabel.text = [self.cnts[indexPath.row] objectForKey:kTHEM];
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:TRUE];
    NSString *vcstr = [self.cnts[indexPath.row] objectForKey:kVC];
    if ([vcstr isEqualToString:@"VoiceAVPlayerVC"]) {
        [self.navigationController pushViewController:[VoiceAVPlayerVC currentAVPlayerVC] animated:TRUE];
    } else {
        BaseFuncVC *vc  = [[NSClassFromString(vcstr) alloc] init];
        vc.type         = [[self.cnts[indexPath.row] objectForKey:kType] integerValue];
        [self.navigationController pushViewController:vc animated:TRUE];
    }
}

-(NSMutableArray<NSDictionary *> *)cnts{
    if (!_cnts) {
        _cnts = [[NSMutableArray alloc] init];
        NSArray *thems = @[@"Voice - AVAudioPlayer 播放系统音",@"Voice - AVAudioPlayer 播放自定义音频",
                           @"Voice - AVPlayer",@"Vedio - AVPlayer"];
        NSArray *vcs   = @[@"VoiceAVAudioPlayerVC",@"VoiceAVAudioPlayerVC",
                           @"VoiceAVPlayerVC",@"VedioAVPlayerVC"];
        NSArray *types = @[@(FuncTypeVoiceAVAudioSystem),@(FuncTypeVoiceAVAudioCustom),
                           @(FuncTypeAVPlayerVoice),@(FuncTypeAVPlayerVedio)];
        for (NSInteger cou = 0; cou < thems.count; cou ++) {
            NSMutableDictionary *dict = [[NSMutableDictionary alloc] init];
            [dict setObject:thems[cou] forKey:kTHEM];
            [dict setObject:vcs[cou] forKey:kVC];
            [dict setObject:types[cou] forKey:kType];
            [_cnts addObject:dict];
        }
    }
    return _cnts;
}

@end
