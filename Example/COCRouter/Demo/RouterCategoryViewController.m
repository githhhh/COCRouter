//
//  RouterCategoryViewController.m
//  COCRouter
//
//  Created by bin on 2017/7/14.
//  Copyright © 2017年 bin. All rights reserved.
//

#import "RouterCategoryViewController.h"
#import "COCRouter+Order.h"
#import "COCRouter+ComponentUI.h"

@interface RouterCategoryViewController ()<UITableViewDelegate,UITableViewDataSource>

@property (strong, nonatomic) UITableView *tableView;

@property (strong, nonatomic) NSArray * dataSource;

@end

@implementation RouterCategoryViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.view.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:self.tableView];
    
    self.dataSource = @[
                        @{@"order 路由扩展:":@[
                                  @"order://showDetail/",
                                  @"order://showList/?city_id=801"
                                  ]
                          },
                        @{@"componentUI 路由扩展:":@[
                                  @"componentUI://alert"
                                  ]
                          },


                        ];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    [self.tableView reloadData];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
    
    if (indexPath.section == 1) {
        NSArray *titles = @[@"取消",@"确定"];
        
        [COCRouter alertView:@"测试AlterView"
                    message:@"AlterView"
               buttonTitles:titles
              buttonClicked:^(NSNumber *numb) {
                         
                         NSLog(@"~~~~选中~~%@~~~~~~~~",titles[[numb integerValue]]);
                     }];
        
        return;
    }
    
    if (indexPath.row == 0) {
        //order
        [COCRouter orderDetail:@"18329"
                       baseVC:self
                   paySuccess:^(NSString *orderID, NSDictionary *info) {
                              NSLog(@"paySuccess~orderID~~%@~info~~~%@",orderID,info);
                          }
                    payCancel:^(NSString *orderID, NSDictionary *info) {
                               NSLog(@"payCancel~orderID~~%@~info~~~%@",orderID,info);
                           }];
        
        return;
    }
    
    [COCRouter showOrderList:self];

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
