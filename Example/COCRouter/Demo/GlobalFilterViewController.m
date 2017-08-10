//
//  GlobalFilterViewController.m
//  COCRouter
//
//  Created by bin on 2017/7/14.
//  Copyright © 2017年 bin. All rights reserved.
//

#import "GlobalFilterViewController.h"
#import "COCRouter.h"

@interface GlobalFilterViewController ()<UITableViewDelegate,UITableViewDataSource>

@property (strong, nonatomic) UITableView *tableView;

@property (strong, nonatomic) NSArray * dataSource;


@end

@implementation GlobalFilterViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.view.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:self.tableView];
    
    self.dataSource = @[
                        @"cocer://main/type/dest/?a=1&&b=2",
                        @"cocer://main/type/dest/",
                        @"cocer://main/type/dest",
                        ];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    [self.tableView reloadData];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.dataSource.count;
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
    
    lable.text = @" 故意在cocConfig.plist中配错";
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
    
    lable.text = self.dataSource[indexPath.row];
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:[tableView indexPathForSelectedRow]
                             animated:NO];
    
    NSString *url = self.dataSource[indexPath.row];
    
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
