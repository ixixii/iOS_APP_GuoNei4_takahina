//
//  TAMineViewController.m
//  takahina
//
//  Created by beyond on 2020/03/29.
//  Copyright © 2020 beyond. All rights reserved.
//

#import "TAMineViewController.h"
#import "TAMineHeadView.h"
#import "TAMineCell.h"

@interface TAMineViewController ()
<UITableViewDataSource, UITableViewDelegate>
{
    UITableView *_ta_tableView;
    NSMutableArray *_ta_modelArr;
}
@end

@implementation TAMineViewController

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    if(_ta_modelArr.count == 3){
        [_ta_modelArr addObject:@{
            @"ta_icon": @"ta_logout.png",
            @"ta_title": @"退出登陆"
        }];
        [_ta_tableView reloadData];
    }
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self ta_resetTabBarItemTextColor];
    [self ta_addTableView];
}

- (void)ta_resetTabBarItemTextColor
{
    [self.ta_xib_tabBarItem setTitleTextAttributes:[NSDictionary dictionaryWithObject:ta_yellowColor forKey:NSForegroundColorAttributeName] forState:UIControlStateSelected];
}


- (void)ta_addTableView
{
    CGRect frame = CGRectMake(0, 0, ta_ScreenWidth, ta_ScreenHeight);
    UITableView *tableView = [[UITableView alloc]initWithFrame:frame style:UITableViewStylePlain];
    [self.view addSubview:tableView];
    
    tableView.dataSource = self;
    tableView.delegate = self;
    
    tableView.tableFooterView = [[UIView alloc] initWithFrame:CGRectZero];
    
    _ta_tableView = tableView;
    
    NSArray *tmpArr = @[
        @{
            @"ta_icon": @"ta_kefu.png",
            @"ta_title": @"电话客服",
            @"ta_detailText": @"15700191367"
        },
        @{
            @"ta_icon": @"ta_feedback.png",
            @"ta_title": @"反馈意见",
            @"ta_className": @"TAFeedViewController"
        },
        @{
            @"ta_icon": @"ta_about.png",
            @"ta_title": @"关于我们",
            @"ta_className": @"TAAboutViewController"
        },
        @{
            @"ta_icon": @"ta_logout.png",
            @"ta_title": @"退出登录"
        }
    ];
    _ta_modelArr = [NSMutableArray arrayWithArray:tmpArr];
    _ta_tableView.tableHeaderView = [TAMineHeadView taMineHeadView];
}
#pragma mark - tableView delegate
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return _ta_modelArr.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    TAMineCell *cell = [tableView dequeueReusableCellWithIdentifier:@"TAMineCell"];
    if (cell == nil) {
        cell = [TAMineCell taMineCell];
    }
    cell = [self inflateCell:cell withModel:[_ta_modelArr objectAtIndex:indexPath.row]];
    return cell;
}
- (TAMineCell *)inflateCell:(TAMineCell *)cell withModel:(NSDictionary *)model
{
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    cell.textLabel.numberOfLines = 0;
    cell.imageView.image = [UIImage imageNamed:[model objectForKey:@"ta_icon"]];
    cell.textLabel.text = [model objectForKey:@"ta_title"];
    cell.detailTextLabel.text = [model objectForKey:@"ta_detailText"];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    switch (indexPath.row) {
        case 0:
            {
                [[UIApplication sharedApplication] openURL:[NSURL URLWithString:[[NSMutableString alloc] initWithFormat:@"telprompt://%@",_ta_modelArr[indexPath.row][@"ta_detailText"]]]];
            }
            break;
        case 1:
            {
                [self.navigationController pushViewController:[[NSClassFromString([[_ta_modelArr objectAtIndex:indexPath.row] objectForKey:@"ta_className"]) alloc]init] animated:YES];
            }
            break;
        case 2:
            {
                [self.navigationController pushViewController:[[NSClassFromString([[_ta_modelArr objectAtIndex:indexPath.row] objectForKey:@"ta_className"]) alloc]init] animated:YES];
            }
            break;
        case 3:
            {
                UIAlertController *ta_alertController = [UIAlertController alertControllerWithTitle:@"温馨提示" message:@"你是否退出登录？" preferredStyle:UIAlertControllerStyleAlert];
                [ta_alertController addAction:[UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:nil]];
                [ta_alertController addAction:[UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull act) {
                    [TAMessageTool showTAMessage:@"发送中..." duration:3];
                    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                        [TAMessageTool showTAMessage:@"退出登录成功"];
                        [[NSUserDefaults standardUserDefaults] setBool:NO forKey:@"userDefault_ta_isLogin"];
                        [[NSUserDefaults standardUserDefaults] synchronize];
                        
                        // 弹出登陆控制器
                        
                        [self.navigationController pushViewController:[[NSClassFromString(@"TALoginViewController") alloc] init] animated:YES];
                        
                        if(_ta_modelArr.count == 4){
                            // modelArr 将最后一个移除
                            [_ta_modelArr removeLastObject];
                            [_ta_tableView reloadData];
                        }
                    });
                }]];
                [self presentViewController:ta_alertController animated:YES completion:nil];
            }
            break;
            
        default:
            break;
    }
}

@end
