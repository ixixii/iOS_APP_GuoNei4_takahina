//
//  SomeoneAccountViewController.m
//  takahina
//
//  Created by beyond on 2020/03/30.
//  Copyright © 2020 beyond. All rights reserved.
//

#import "SomeoneAccountViewController.h"
#import "TAFamilyHeadView.h"
#import "TAAccountTableViewCell.h"
#import "TAAddAccountViewController.h"

@interface SomeoneAccountViewController ()<UITableViewDataSource, UITableViewDelegate>
{
    UITableView *_ta_tableView;
    NSMutableArray *_ta_accountArr;
}

@end

@implementation SomeoneAccountViewController
- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self loadTAData];
}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = [NSString stringWithFormat:@"%@的账号",_taFamilyDict[@"ta_relation"]];
    self.navigationController.navigationBar.tintColor = [UIColor whiteColor];
    [self loadTAData];
    [self addTASubViews];
}
- (void)addTASubViews
{
    [self addTABgView];
    [self addTATableView];
}
- (void)addTABgView
{
    UIImageView *bgView = [[UIImageView alloc]initWithFrame:CGRectMake(0, 64, ta_ScreenWidth, ta_ScreenHeight - 64 - 44)];
    bgView.image = [UIImage imageNamed:@"login_background.png"];
    bgView.contentMode = UIViewContentModeScaleAspectFill;
    [self.view addSubview:bgView];
}
- (void)addTATableView
{
    UITableView *tableViewer = [[UITableView alloc]initWithFrame:CGRectMake(20, 64, ta_ScreenWidth-40, ta_ScreenHeight - 64) style:UITableViewStylePlain];
    tableViewer.backgroundColor = [UIColor clearColor];
    [self.view addSubview:tableViewer];
    
    tableViewer.dataSource = self;
    tableViewer.delegate = self;
    
    tableViewer.tableFooterView = [[UIView alloc] initWithFrame:CGRectZero];
    
    _ta_tableView = tableViewer;
    TAFamilyHeadView *headView = [TAFamilyHeadView taFamilyHeadView];
    headView.xib_ta_imgView_banner.image = [UIImage imageNamed:@"balance_banner4.png"];
    _ta_tableView.tableHeaderView = headView;
    _ta_tableView.showsVerticalScrollIndicator = NO;
}
- (void)loadTAData
{
    NSArray *arrr = [[NSUserDefaults standardUserDefaults] objectForKey:@"userDefault_ta_accountArr"];
    _ta_accountArr = [NSMutableArray arrayWithArray:arrr];
    if(_taFamilyDict){
        NSMutableArray *resultArrr = [NSMutableArray array];
        for (NSDictionary *item in _ta_accountArr) {
            if([item[@"ta_family"] isEqualToString:_taFamilyDict[@"ta_relation"]]){
                [resultArrr addObject:item];
            }
        }
        _ta_accountArr = [NSMutableArray arrayWithArray:resultArrr];
    }
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
    cell.xib_ta_label_remark.text = [NSString stringWithFormat:@"账号描述：%@",accountDict[@"ta_remark"]];
    cell.xib_ta_label_date.text = [NSString stringWithFormat:@"创建时间：%@",accountDict[@"ta_date"]];
    cell.xib_ta_label_family.text = [NSString stringWithFormat:@"所属家人：%@",accountDict[@"ta_family"]];
    return cell;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 206;
}
#pragma mark - btn 事件
- (void)addBtnClicked:(UIButton *)sender
{
    [self.navigationController pushViewController:[[NSClassFromString(@"TAAddAccountViewController") alloc]init] animated:YES];
}

- (void)delTAButtonClickedFunc:(UIButton *)btn
{
    UIAlertController *alertCtrler = [UIAlertController alertControllerWithTitle:@"提示" message:@"是否确认删除该账号记录？" preferredStyle:UIAlertControllerStyleAlert];
    [alertCtrler addAction:[UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:nil]];
    [alertCtrler addAction:[UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        [self delTABtnClicked:btn];
    }]];
    [self presentViewController:alertCtrler animated:YES completion:nil];
}
- (void)delTABtnClicked:(UIButton *)btn
{
    while (![btn isMemberOfClass:[TAAccountTableViewCell class]]){
        btn = (UIButton *)[btn superview];
    }
    TAAccountTableViewCell *cell = (TAAccountTableViewCell *)btn;
    UITableView *tableView = (UITableView *)cell;
    while (![tableView isMemberOfClass:[UITableView class]]){
        tableView = (UITableView *)[tableView superview];
    }
    NSIndexPath *indexPath = [tableView indexPathForCell:cell];
    [_ta_accountArr removeObjectAtIndex:indexPath.row];
    [self abstract_saveTAData];
    [_ta_tableView reloadData];
}
- (void)abstract_saveTAData
{
    [[NSUserDefaults standardUserDefaults] setObject:_ta_accountArr forKey:@"userDefault_ta_accountArr"];
    [[NSUserDefaults standardUserDefaults] synchronize];
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSDictionary *currentAccount = _ta_accountArr[indexPath.row];
    TAAddAccountViewController *addCtrler = [[TAAddAccountViewController alloc]init];
    addCtrler.model = currentAccount;
    [self.navigationController pushViewController:addCtrler animated:YES];
}
@end
