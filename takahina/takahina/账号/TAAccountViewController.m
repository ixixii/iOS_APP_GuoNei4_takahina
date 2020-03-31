//
//  TAAccountViewController.m
//  takahina
//
//  Created by beyond on 2020/03/29.
//  Copyright © 2020 beyond. All rights reserved.
//

#import "TAAccountViewController.h"
#import "TAFamilyHeadView.h"
#import "TAAccountTableViewCell.h"
#import "TAAddAccountViewController.h"

@interface TAAccountViewController ()<UITableViewDataSource, UITableViewDelegate>
{
    UITableView *_ta_tableView;
    NSMutableArray *_ta_accountArr;
}

@end

@implementation TAAccountViewController
- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self loadTAData];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self ta_resetTabBarItemTextColor];
    
    [self loadTAData];
    [self addTASubViews];
}

- (void)ta_resetTabBarItemTextColor
{
    [self.ta_xib_tabBarItem setTitleTextAttributes:[NSDictionary dictionaryWithObject:ta_yellowColor forKey:NSForegroundColorAttributeName] forState:UIControlStateSelected];
}
- (void)addTASubViews
{
    [self addTABgView];
    [self addTATableView];
}
- (void)addTABgView
{
    UIImageView *bgTAView = [[UIImageView alloc]initWithFrame:CGRectMake(0, 64, ta_ScreenWidth, ta_ScreenHeight - 64 - 44)];
    bgTAView.image = [UIImage imageNamed:@"login_background.png"];
    bgTAView.contentMode = UIViewContentModeScaleAspectFill;
    [self.view addSubview:bgTAView];
}
- (void)addTATableView
{
    UITableView *taTableView = [[UITableView alloc]initWithFrame:CGRectMake(20, 64, ta_ScreenWidth-40, ta_ScreenHeight - 64) style:UITableViewStylePlain];
    taTableView.backgroundColor = [UIColor clearColor];
    [self.view addSubview:taTableView];
    
    taTableView.dataSource = self;
    taTableView.delegate = self;
    
    taTableView.tableFooterView = [[UIView alloc] initWithFrame:CGRectZero];
    
    _ta_tableView = taTableView;
    TAFamilyHeadView *taHeadView = [TAFamilyHeadView taFamilyHeadView];
    taHeadView.xib_ta_imgView_banner.image = [UIImage imageNamed:@"balance_banner4.png"];
    _ta_tableView.tableHeaderView = taHeadView;
    _ta_tableView.showsVerticalScrollIndicator = NO;
}
- (void)loadTAData
{
    NSArray *taArr = [[NSUserDefaults standardUserDefaults] objectForKey:@"userDefault_ta_accountArr"];
    _ta_accountArr = [NSMutableArray arrayWithArray:taArr];
    if(_ta_tableView){
        [_ta_tableView reloadData];
    }
}
#pragma mark - tableView delegate
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return _ta_accountArr.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    TAAccountTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"TAAccountTableViewCell"];
    if (cell == nil) {
        cell = [TAAccountTableViewCell taTableViewCell];
        cell.backgroundColor = [UIColor clearColor];
        cell.selectionStyle = UITableViewCellSeparatorStyleNone;
        [cell.xib_ta_btn_del addTarget:self action:@selector(delTAButtonClickedFunc:) forControlEvents:UIControlEventTouchUpInside];
    }
    
    NSDictionary *accountDict = [_ta_accountArr objectAtIndex:indexPath.row];
    cell.xib_ta_label_account.text = [NSString stringWithFormat:@"账号：%@",accountDict[@"ta_account"]];
    cell.xib_ta_label_password.text = [NSString stringWithFormat:@"密码：%@",accountDict[@"ta_password"]];
    cell.xib_ta_label_type.text = [NSString stringWithFormat:@"账号类型：%@",accountDict[@"ta_type"]];
    cell.xib_ta_label_remark.text = [NSString stringWithFormat:@"账号备注：%@",accountDict[@"ta_remark"]];
    cell.xib_ta_label_date.text = [NSString stringWithFormat:@"创建日期：%@",accountDict[@"ta_date"]];
    cell.xib_ta_label_family.text = [NSString stringWithFormat:@"所属家人：%@",accountDict[@"ta_family"]];
    return cell;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 206;
}
#pragma mark - btn 事件
- (void)addTABtnClicked:(UIButton *)sender
{
    [self.navigationController pushViewController:[[NSClassFromString(@"TAAddAccountViewController") alloc]init] animated:YES];
}

- (void)delTAButtonClickedFunc:(UIButton *)btn
{
    UIAlertController *alertTACtrl = [UIAlertController alertControllerWithTitle:@"提示" message:@"是否确认删除该账号记录？" preferredStyle:UIAlertControllerStyleAlert];
    [alertTACtrl addAction:[UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:nil]];
    [alertTACtrl addAction:[UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        [self delTTBtnClicked:btn];
    }]];
    [self presentViewController:alertTACtrl animated:YES completion:nil];
}
- (void)delTTBtnClicked:(UIButton *)btn
{
    while (![btn isMemberOfClass:[TAAccountTableViewCell class]]){
        btn = (UIButton *)[btn superview];
    }
    TAAccountTableViewCell *cell = (TAAccountTableViewCell *)btn;
    UITableView *tableView = (UITableView *)cell;
    while (![tableView isMemberOfClass:[UITableView class]]){
        tableView = (UITableView *)[tableView superview];
    }
    NSIndexPath *indexTAPath = [tableView indexPathForCell:cell];
    [_ta_accountArr removeObjectAtIndex:indexTAPath.row];
    [self abstract_saveTAData];
    [_ta_tableView reloadData];
}
- (void)abstract_saveTAData
{
    [[NSUserDefaults standardUserDefaults] setObject:_ta_accountArr forKey:@"userDefault_ta_accountArr"];
    [[NSUserDefaults standardUserDefaults] synchronize];
}
#pragma mark - tableView 代理
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSDictionary *currentTAAccount = _ta_accountArr[indexPath.row];
    TAAddAccountViewController *addTACtrl = [[TAAddAccountViewController alloc]init];
    addTACtrl.model = currentTAAccount;
    [self.navigationController pushViewController:addTACtrl animated:YES];
}

@end
