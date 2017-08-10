//
//  OrderDetailViewController.m
//  COCRouter
//
//  Created by bin on 2017/6/16.
//  Copyright © 2017年 githhhh. All rights reserved.
//

#import "OrderDetailViewController.h"
#import <Masonry/Masonry.h>

@interface OrderDetailViewController ()

@property (strong, nonatomic) UIButton *pay;

@property (strong, nonatomic) UIButton *cancelPay;

@property (copy, nonatomic) void (^success)(NSString *orderID, NSDictionary *info);

@property (copy, nonatomic) void (^cancel)(NSString *orderID, NSDictionary *info);

@end

@implementation OrderDetailViewController


#pragma mark - Life cycle

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title = @"订单详情";
    self.view.backgroundColor = [UIColor whiteColor];
    
    UIButton*btn = [[UIButton alloc] init];
    [self.view addSubview:btn];
    btn.backgroundColor = [UIColor whiteColor];
    [btn setTitle:@"back" forState:UIControlStateNormal];
    [btn setTitleColor:[UIColor blueColor] forState:UIControlStateNormal];

    [btn addTarget:self action:@selector(backAction) forControlEvents:UIControlEventTouchUpInside];

    [btn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.view.mas_left).offset(5);
        make.width.height.equalTo(@40);
        make.top.equalTo(self.view.mas_top).offset(22);
    }];

    [self.view addSubview:self.pay];
    [self.pay addTarget:self action:@selector(payAction) forControlEvents:UIControlEventTouchUpInside];
    [self.pay mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.view.mas_left).offset(15);
        make.width.height.equalTo(@100);
        make.top.equalTo(self.view.mas_top).offset(100);
    }];
    
    
    [self.view addSubview:self.cancelPay];
    [self.cancelPay addTarget:self action:@selector(cancelPayAction) forControlEvents:UIControlEventTouchUpInside];
    [self.cancelPay mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.view.mas_right).offset(-15);
        make.width.height.equalTo(@100);
        make.top.equalTo(self.view.mas_top).offset(100);
    }];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


-(void)request:(NSString *)discountID
    paySuccess:(void (^)(NSString *orderID, NSDictionary *info))successBlock
     payCancel:(void (^)(NSString *orderID, NSDictionary *info))cancelBlock{
    
    self.title = [NSString stringWithFormat:@"订单详情[%@]",discountID] ;

    self.success = successBlock;
    self.cancel = cancelBlock;
}

-(void)backAction{
    
    [self dismissViewControllerAnimated:YES completion:nil];
    
}


-(void)payAction{
    
    if (self.success) {
        self.success(@"123456789",@{@"statue":@200});
    }
 
    [self dismissViewControllerAnimated:YES completion:nil];

}

-(void)cancelPayAction{
    
    if (self.cancel) {
        self.cancel(@"123456789",@{@"statue":@400});
    }
    
    [self dismissViewControllerAnimated:YES completion:nil];

}


#pragma mark -  AutoGetter

- (UIButton *)pay {
    if (!_pay) {
        _pay = [[UIButton alloc] init];
        [_pay   setTitle:@"支付" forState:UIControlStateNormal];
        _pay.backgroundColor = [UIColor grayColor];
        [_pay setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    }
    
    return _pay;
}

- (UIButton *)cancelPay {
    if (!_cancelPay) {
        _cancelPay = [[UIButton alloc] init];
        [_cancelPay   setTitle:@"取消支付" forState:UIControlStateNormal];
        _cancelPay.backgroundColor = [UIColor grayColor];
        [_cancelPay setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];

    }

    return _cancelPay;
}

@end
