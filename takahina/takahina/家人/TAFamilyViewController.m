//
//  TAFamilyViewController.m
//  takahina
//
//  Created by beyond on 2020/03/29.
//  Copyright © 2020 beyond. All rights reserved.
//

#import "TAFamilyViewController.h"
#import "TAFamilyHeadView.h"
#import "TAFamilyTableViewCell.h"
#import "TAAddFamilyViewController.h"
#import "SomeoneAccountViewController.h"

@interface TAFamilyViewController ()<UITableViewDataSource, UITableViewDelegate>
{
    UITableView *_ta_tableView;
    NSMutableArray *_ta_familyArr;
}
@end

@implementation TAFamilyViewController
-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self loadTAFamilyData];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self ta_resetTabBarItemTextColor];
    
    [self pushTALoginViewController];
    
    [self loadTAFamilyData];
    
    [self addTASubViews];
}
- (void)ta_resetTabBarItemTextColor
{
    [self.ta_xib_tabBarItem setTitleTextAttributes:[NSDictionary dictionaryWithObject:ta_yellowColor forKey:NSForegroundColorAttributeName] forState:UIControlStateSelected];
}
- (void)loadTAFamilyData
{
    NSArray *tmpTAFamilyArr = [[NSUserDefaults standardUserDefaults] objectForKey:@"userDefault_ta_familyArr"];
    _ta_familyArr = [NSMutableArray arrayWithArray:tmpTAFamilyArr];
    if(!tmpTAFamilyArr){
        _ta_familyArr = [NSMutableArray arrayWithArray:@[
            @{
                @"ta_relation": @"我",
                @"ta_interest": @"各大IT论坛、科技网站",
                @"ta_description": @"IT民工、二次元宅男"
            }
        ]];
        [[NSUserDefaults standardUserDefaults] setObject:_ta_familyArr forKey:@"userDefault_ta_familyArr"];
        [[NSUserDefaults standardUserDefaults] setObject:@[
            @{
                @"ta_account": @"beyond",
                @"ta_password": @"asdfqwer1234",
                @"ta_type": @"github",
                @"ta_remark": @"这是一条备注信息",
                @"ta_date": @"2020-03-30 14:12",
                @"ta_family": @"我"
            }
        ] forKey:@"userDefault_ta_accountArr"];
        [[NSUserDefaults standardUserDefaults] synchronize];
    }
    if(_ta_tableView){
        [_ta_tableView reloadData];
    }
}
- (void)addTASubViews
{
    [self addTABgView];
    [self addTAFamilyTableView];
}

- (void)addTABgView
{
    UIImageView *taFamilyBgView = [[UIImageView alloc]initWithFrame:CGRectMake(0, 64, ta_ScreenWidth, ta_ScreenHeight - 64 - 44)];
    taFamilyBgView.contentMode = UIViewContentModeScaleAspectFill;
    taFamilyBgView.image = [UIImage imageNamed:@"login_background.png"];
    [self.view addSubview:taFamilyBgView];
}
- (void)addTAFamilyTableView
{
    UITableView *tmpTAFamilyTableView = [[UITableView alloc]initWithFrame:CGRectMake(20, 64, ta_ScreenWidth-40, ta_ScreenHeight - 64) style:UITableViewStylePlain];
    tmpTAFamilyTableView.backgroundColor = [UIColor clearColor];
    [self.view addSubview:tmpTAFamilyTableView];
    
    tmpTAFamilyTableView.dataSource = self;
    tmpTAFamilyTableView.delegate = self;
    
    tmpTAFamilyTableView.tableFooterView = [[UIView alloc] initWithFrame:CGRectZero];
    
    _ta_tableView = tmpTAFamilyTableView;
    _ta_tableView.tableHeaderView = [TAFamilyHeadView taFamilyHeadView];

    _ta_tableView.showsVerticalScrollIndicator = NO;
}
#pragma mark - tableView delegate
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return _ta_familyArr.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    TAFamilyTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"TAFamilyTableViewCell"];
    if (cell == nil) {
        cell = [TAFamilyTableViewCell taFamilyTableViewCell];
        cell.backgroundColor = [UIColor clearColor];
        cell.selectionStyle = UITableViewCellSeparatorStyleNone;
        [cell.xib_ta_button_delete addTarget:self action:@selector(delTAButtonClickedFunc:) forControlEvents:UIControlEventTouchUpInside];
    }
    
    NSDictionary *taFamilyDict = [_ta_familyArr objectAtIndex:indexPath.row];
    cell.xib_ta_label_relation.text = [NSString stringWithFormat:@"家人关系：%@",taFamilyDict[@"ta_relation"]];
    cell.xib_ta_label_interest.text = [NSString stringWithFormat:@"账号热点：%@",taFamilyDict[@"ta_interest"]];
    cell.xib_ta_label_description.text = [NSString stringWithFormat:@"家人描述：%@",taFamilyDict[@"ta_description"]];
    return cell;
}
- (void)delTAButtonClickedFunc:(UIButton *)btn
{
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"提示" message:@"是否确认删除该家人，所属账号也会随之删除？" preferredStyle:UIAlertControllerStyleAlert];
    [alertController addAction:[UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:nil]];
    [alertController addAction:[UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        [self delTAButtonClicked:btn];
    }]];
    [self presentViewController:alertController animated:YES completion:nil];
}
- (void)delTAButtonClicked:(UIButton *)taButton
{
    while (![taButton isMemberOfClass:[TAFamilyTableViewCell class]]){
        taButton = (UIButton *)[taButton superview];
    }
    TAFamilyTableViewCell *taCell = (TAFamilyTableViewCell *)taButton;
    UITableView *taTableView = (UITableView *)taCell;
    while (![taTableView isMemberOfClass:[UITableView class]]){
        taTableView = (UITableView *)[taTableView superview];
    }
    NSIndexPath *indexPath = [taTableView indexPathForCell:taCell];
    NSDictionary *currentTAFamilyDict = [_ta_familyArr objectAtIndex:indexPath.row];
    NSString *tmpTARelation = currentTAFamilyDict[@"ta_relation"];
    [_ta_familyArr removeObjectAtIndex:indexPath.row];
    NSArray *tmpTAAccountArr = [[NSUserDefaults standardUserDefaults] objectForKey:@"userDefault_ta_accountArr"];
    NSMutableArray *resultTAAccountArr = [NSMutableArray array];
    for (NSDictionary *tmpTAAccountDict in tmpTAAccountArr) {
        if(![tmpTAAccountDict[@"ta_family"] isEqualToString:tmpTARelation]){
            [resultTAAccountArr addObject:tmpTAAccountDict];
        }
    }
    [[NSUserDefaults standardUserDefaults] setObject:resultTAAccountArr forKey:@"userDefault_ta_accountArr"];
    
    [self abstract_saveTAFamilyData];
    [_ta_tableView reloadData];
}
- (void)abstract_saveTAFamilyData
{
    [[NSUserDefaults standardUserDefaults] setObject:_ta_familyArr forKey:@"userDefault_ta_familyArr"];
    [[NSUserDefaults standardUserDefaults] synchronize];
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 113;
}
- (void)pushTALoginViewController
{
    if(![[NSUserDefaults standardUserDefaults] boolForKey:@"userDefault_ta_isLogin"]){
        [self.navigationController pushViewController:[[NSClassFromString(@"TALoginViewController") alloc] init] animated:NO];
    }
}
#pragma mark - btn 事件
- (void)addTAButtonClicked:(UIButton *)sender
{
    TAAddFamilyViewController *addTACtrl = [[TAAddFamilyViewController alloc]init];
    [self.navigationController pushViewController:addTACtrl animated:YES];
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSDictionary *taFamilyDict = _ta_familyArr[indexPath.row];
    SomeoneAccountViewController *taCtrl = [[SomeoneAccountViewController alloc] init];
    taCtrl.taFamilyDict = taFamilyDict;
    [self.navigationController pushViewController:taCtrl animated:YES];
}



@end
