//
//  ForwardModuleViewController.m
//  COCRouter
//
//  Created by bin on 2016/12/20.
//  Copyright © 2016年 bin. All rights reserved.
//

#import "ForwardModuleViewController.h"
#import "COCRouter.h"
#import "COCRouter+Order.h"

@interface ForwardModuleViewController ()<UITableViewDelegate,UITableViewDataSource>

@property (strong, nonatomic) UITableView *tableView;

@property (strong, nonatomic) NSArray * dataSource;

@end

@implementation ForwardModuleViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    self.view.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:self.tableView];
    
    self.dataSource = @[
                        @{
                           @"lastdiscount模块:":@[
                                   @"lastdiscount%3A%2F%2Faction_share%3Furl%3Dhttp%3A%2F%2Fz.coc.com%26title%3D%E6%A0%87%E9%A2%98%26subtitle%3D%E9%A6%96%E9%A1%B5%26cover%3Dstatic.coc.com"
                                   ]
                            },
                        @{
                            @"http/https模块:":@[
                                    @"http://appview.coc.com/newask/ask/?a=1&&b=2",
                                    @"http://appview.coc.com/newask/ask?a=1&&b=2",
                                    @"http://app.coc.com/zt/405/index/203?a=1&&b=2",
                                    @"http://z.coc.com/all_0_0_14_0_0_0_0/?_channel=freetour&_type=place&campaign=zsj&category=locnav",
                                    @"http://z.coc.com/all_0_0_14_8603_0_0_0/?_channel=freetour&_type=place&campaign=zsj&category=locnav-hot"

                                    ]
                            }
                        ];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    [self.tableView reloadData];
}


-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return self.dataSource.count;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    NSDictionary *detail = self.dataSource[section];
    
    NSArray *item = detail.allValues.firstObject;

    return item.count;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 50;
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 40;
}

-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    UITableViewHeaderFooterView *header = [tableView dequeueReusableHeaderFooterViewWithIdentifier:@"header"];
    header.contentView.backgroundColor = [UIColor lightGrayColor];

    UILabel *lable = [header.contentView viewWithTag:102];
    if (!lable) {
        lable = [[UILabel alloc] init];
        lable.textAlignment = NSTextAlignmentLeft;
        lable.textColor = [UIColor redColor];
        [header.contentView addSubview:lable];
        lable.tag = 102;
        lable.frame = CGRectMake(15, 0, 375,40);
        lable.font = [UIFont systemFontOfSize:14];
    }

    NSDictionary *detail = self.dataSource[section];
    NSString*key = detail.allKeys.firstObject;
    lable.text = key;
    return header;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"id"];
    cell.backgroundColor = [UIColor whiteColor];

    UILabel *lable = [cell.contentView viewWithTag:101];
    if (!lable) {
        lable = [[UILabel alloc] init];
        lable.textAlignment = NSTextAlignmentLeft;
        lable.textColor = [UIColor blackColor];
        [cell.contentView addSubview:lable];
        lable.tag = 101;
        lable.frame = CGRectMake(15, 0, 375,50);
        lable.font = [UIFont systemFontOfSize:14];
    }
    
    NSDictionary *detail = self.dataSource[indexPath.section];
    NSArray *item = detail.allValues.firstObject;
    lable.text = item[indexPath.row];
    return cell;
}


-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    [tableView deselectRowAtIndexPath:[tableView indexPathForSelectedRow]
                             animated:NO];
    
    NSDictionary *detail = self.dataSource[indexPath.section];
    NSArray *item = detail.allValues.firstObject;
    NSString *url = item[indexPath.row];

    [COCRouter forwardModule:[NSURL URLWithString:url] complete:^(COCRouterMode mode) {
        if (mode == COCRouterModeSuccess) {
            NSLog(@"==响应成功====");
            return ;
        }
        NSLog(@"==响应失败====");

    }];
}

#pragma mark -  AutoGetter

- (UITableView *)tableView {
    if (!_tableView) {
        _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, self.view.bounds.size.width, self.view.bounds.size.height) style:UITableViewStyleGrouped];
        [_tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"id"];
        [_tableView registerClass:[UITableViewHeaderFooterView class] forHeaderFooterViewReuseIdentifier:@"header"];
    }
    
    return _tableView;
}


@end
