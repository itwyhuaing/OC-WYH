//
//  TableVC.m
//  RichTextProjectDemo
//
//  Created by hnbwyh on 2018/2/5.
//  Copyright © 2018年 hainbwyh. All rights reserved.
//

#import "TableVC.h"
#import "RichTextEditor.h"
#import "JXTextViewVC.h"
#import "AttibutedTestVC.h"
#import "AttributedTest2VC.h"
#import "TextViewLoadHtmlVC.h"
#import "WKLoadHtmlVC.h"

@interface TableVC ()
@property (nonatomic,strong) NSMutableArray *dataSource;
@end

@implementation TableVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    //  UI 修饰
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    NSArray *tmp = @[@"RichTextEditor - WK",@"JXTextViewVC",@"AttibutedTestVC:属性测试第一部分",@"AttributedTest2VC:属性测试第二部分",@"TextViewLoadHtmlVC:UITextView加载HTML",@"WKLoadHtmlVC:WKWebView加载HTML"];
    _dataSource = [[NSMutableArray alloc] initWithArray:tmp];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


#pragma mark - Table view data source

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return _dataSource.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell_id_reuse"];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cell_id_reuse"];
    }
    cell.textLabel.text = _dataSource[indexPath.row];
    return cell;
    
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    UIViewController *vc;
    switch (indexPath.row) {
        case 0:
        {
            vc = [[RichTextEditor alloc] init];
            [self.navigationController pushViewController:vc animated:FALSE];
        }
            break;
        case 1:
        {
            vc = [[JXTextViewVC alloc] init];
            [self.navigationController pushViewController:vc animated:FALSE];
        }
            break;
        case 2:
        {
            vc = [[AttibutedTestVC alloc] init];
            [self.navigationController pushViewController:vc animated:FALSE];
        }
            break;
        case 3:
        {
            vc = [[AttributedTest2VC alloc] init];
            [self.navigationController pushViewController:vc animated:FALSE];
        }
            break;
        case 4:
        {
            vc = [[TextViewLoadHtmlVC alloc] init];
            [self.navigationController pushViewController:vc animated:FALSE];
        }
            break;
        case 5:
        {
            vc = [[WKLoadHtmlVC alloc] init];
            [self.navigationController pushViewController:vc animated:FALSE];
        }
            break;
            
        default:
            break;
    }
}


/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath {
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
