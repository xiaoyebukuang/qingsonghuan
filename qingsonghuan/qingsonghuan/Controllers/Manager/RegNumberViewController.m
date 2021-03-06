//
//  RegNumberViewController.m
//  qingsonghuan
//
//  Created by 陈晓 on 2018/10/5.
//  Copyright © 2018年 XYBK. All rights reserved.
//

#import "RegNumberViewController.h"
#import "ManagerCommonTableViewCell.h"
#import "ManagerCommonModel.h"
static NSString * const ManagerCommonTableViewCellID = @"ManagerCommonTableViewCellID";
@interface RegNumberViewController ()<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic, strong) UITableView *regNumberTableV;

@property (nonatomic, strong) NSMutableArray *listArr;

@end

@implementation RegNumberViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.listArr = [[NSMutableArray alloc]init];
    [self setupView];
    [self statisticsUserStaRequedt];
}
- (void)setupView {
    [self.view addSubview:self.regNumberTableV];
    [self.regNumberTableV mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.view);
    }];
}

- (void)statisticsUserStaRequedt {
    NSString *url;
    switch (self.type) {
        case ManagerTypeUser:
            self.title = @"注册人数统计";
            url = API_STATISTICS_USERSTA;
            break;
        case ManagerTypeFlight:
            self.title = @"上传航班统计";
            url = API_STATISTICS_FLIGHTSTA;
            break;
        case ManagerTypeLetter:
            self.title = @"站内信统计";
            url = API_STATISTICS_LETTERSTA;
            break;
        default:
            break;
    }
    NSDictionary *param = @{@"phone":[UserModel sharedInstance].phone};
    [RequestPath statistics_StaView:self.view url:url param:param success:^(NSArray *obj, NSInteger code, NSString *mes) {
        for (NSDictionary *subDic in obj) {
            if ([subDic isKindOfClass:[NSDictionary class]]) {
                ManagerCommonModel *model = [[ManagerCommonModel alloc]initWithDic:subDic];
                [self.listArr addObject:model];
            }
        }
        [self.regNumberTableV reloadData];
    } failure:^(ErrorType errorType, NSString *mes) {
        WeakSelf;
        [self showErrorView:^{
            [weakSelf statisticsUserStaRequedt];
        }];
    }];
}
#pragma mark -- UITableViewDelegate, UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.listArr.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    ManagerCommonTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier: ManagerCommonTableViewCellID];
    [cell reloadViewWithModel:self.listArr[indexPath.row]];
    return cell;
}
#pragma mark -- setup
- (UITableView *)regNumberTableV{
    if (!_regNumberTableV) {
        _regNumberTableV = [[UITableView alloc] init];
        _regNumberTableV.delegate = self;
        _regNumberTableV.dataSource = self;
        _regNumberTableV.estimatedRowHeight = 50;
        _regNumberTableV.showsVerticalScrollIndicator = NO;
        _regNumberTableV.showsHorizontalScrollIndicator = NO;
        _regNumberTableV.separatorStyle = UITableViewCellSeparatorStyleNone;
        [_regNumberTableV registerClass:[ManagerCommonTableViewCell class] forCellReuseIdentifier:ManagerCommonTableViewCellID];
    }
    return _regNumberTableV;
}

@end
