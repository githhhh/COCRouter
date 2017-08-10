//
//  NavigationViewController.m
//  COCRouter
//
//  Created by bin on 2017/6/22.
//  Copyright © 2017年 githhhh. All rights reserved.
//

#import "NavigationViewController.h"
#import "COCRouter+Navigation.h"

@interface NavigationViewController ()<UITableViewDelegate,UITableViewDataSource>

@property (strong, nonatomic) UITableView *tableView;

@property (strong, nonatomic) NSArray * dataSource;


@end

@implementation NavigationViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.view.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:self.tableView];
    
    self.dataSource = @[
                        @"navigator://user/1010"
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
    
    lable.text = self.dataSource[indexPath.section];
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:[tableView indexPathForSelectedRow]
                             animated:NO];

    NSString *url = self.dataSource[indexPath.section];
    
    [COCRouter push:[NSURL URLWithString:url] animated:YES];
}

#pragma mark -  AutoGetter

- (UITableView *)tableView {
    if (!_tableView) {
        _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, self.view.bounds.size.width, self.view.bounds.size.height) style:UITableViewStyleGrouped];
        [_tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"id"];
    }

    return _tableView;
}

@end
