//
//  COCViewController.m
//  COCRouter
//
//  Created by bin on 12/16/2016.
//  Copyright (c) 2016 bin. All rights reserved.
//

#import "COCViewController.h"
#import "COCRouter.h"
#import "ForwardModuleViewController.h"
#import "NavigationViewController.h"
#import "RouterCategoryViewController.h"
#import "GlobalFilterViewController.h"

@interface COCViewController ()<UITableViewDelegate,UITableViewDataSource>

@property (strong, nonatomic) UITableView *tableView;

@property (strong, nonatomic) NSArray * dataSource;

@end

@implementation COCViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    self.title = @"路由";
    
    [self.view addSubview:self.tableView];
    
    self.dataSource = @[
                        @"转发ModuleController",
                        @"导航UIViewController",
                        @"路由扩展(自定义路由参数)",
                        @"全局错误处理/拦截器(非必须)"
                        ];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    [self.tableView reloadData];
}


-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return self.dataSource.count;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 100;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"id"];
    
    UILabel *lable = [cell.contentView viewWithTag:101];
    if (!lable) {
        lable = [[UILabel alloc] init];
        lable.textAlignment = NSTextAlignmentLeft;
        lable.textColor = [UIColor blackColor];
        [cell.contentView addSubview:lable];
        lable.tag = 101;
        lable.frame = CGRectMake(15, 0, 375,100);
        lable.font = [UIFont systemFontOfSize:14];
    }
    
    cell.backgroundColor = [UIColor whiteColor];

    lable.text = self.dataSource[indexPath.row];
   
    return cell;
}


-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    [tableView deselectRowAtIndexPath:[tableView indexPathForSelectedRow]
                             animated:NO];
    
    NSString *url = self.dataSource[indexPath.row];
    
    UIViewController *vc = nil;
    
    if (indexPath.row == 0) {
        vc = [ForwardModuleViewController new];
    }else if(indexPath.row == 1){
        vc = [NavigationViewController new];
    }else if (indexPath.row == 2){
        vc = [RouterCategoryViewController new];
    }else if (indexPath.row == 3){
        vc = [GlobalFilterViewController new];
    }
    
    vc.title = url;
    
    [self.navigationController pushViewController:vc animated:YES];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark -  AutoGetter

- (UITableView *)tableView {
    if (!_tableView) {
        _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, self.view.bounds.size.width, self.view.bounds.size.height)];
        [_tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"id"];
        [_tableView registerClass:[UITableViewHeaderFooterView class] forHeaderFooterViewReuseIdentifier:@"header"];

    }
    
    return _tableView;
}

@end
