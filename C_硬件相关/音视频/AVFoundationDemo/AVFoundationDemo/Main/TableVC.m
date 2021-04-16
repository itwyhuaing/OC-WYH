//
//  TableVC.m
//  JXPlayerDemo
//
//  Created by hnbwyh on 2019/1/24.
//  Copyright © 2019年 JiXia. All rights reserved.
//

#import "TableVC.h"

static NSString *kTHEM          = @"them";
static NSString *kVC            = @"vc";

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
    [self.navigationController pushViewController:[[NSClassFromString(vcstr) alloc] init] animated:TRUE];
}

-(NSMutableArray<NSDictionary *> *)cnts{
    if (!_cnts) {
        _cnts = [[NSMutableArray alloc] init];
        NSArray *thems = @[@"AVSpeechSynthesizer",@"AVAudioPlayer播放",
                            @"AVAudioRecorder录制",@"AVAudioSession"];
        NSArray *vcs   = @[@"AVSpeechSynthesizerVC",@"AVAudioPlayerVC",
                            @"AVAudioRecorderVC",@"AVAudioSessionVC"];
        for (NSInteger cou = 0; cou < thems.count; cou ++) {
            NSMutableDictionary *dict = [[NSMutableDictionary alloc] init];
            [dict setObject:thems[cou] forKey:kTHEM];
            [dict setObject:vcs[cou] forKey:kVC];
            [_cnts addObject:dict];
        }
    }
    return _cnts;
}

@end
