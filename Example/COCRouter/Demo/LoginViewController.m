//
//  LoginViewController.m
//  COCRouter
//
//  Created by bin on 2017/7/11.
//  Copyright © 2017年 githhhh. All rights reserved.
//

#import "LoginViewController.h"
#import <Masonry/Masonry.h>
#import "COCLoginState.h"

@interface LoginViewController ()

@property (strong, nonatomic) UIButton *login;

@property (strong, nonatomic) UIButton *cancel;

@end

@implementation LoginViewController

-(void)dealloc{
    NSLog(@"~~~~~LoginViewController~~~~~~dealloc~~~~");
}

#pragma mark - Life cycle

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.view.backgroundColor = [UIColor whiteColor];
    self.title = @"登录界面";
    
    [self.view addSubview:self.login];
    [self.view addSubview:self.cancel];

    [self.login mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.centerY.equalTo(self.view);
        make.width.height.equalTo(@100);
    }];
    
    [self.cancel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.view.mas_left).offset(5);
        make.width.height.equalTo(@40);
        make.top.equalTo(self.view.mas_top).offset(22);
    }];
    
    
    [self.login addTarget:self action:@selector(loginAction) forControlEvents:UIControlEventTouchUpInside];
    [self.cancel addTarget:self action:@selector(cancelAction) forControlEvents:UIControlEventTouchUpInside];

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


-(void)loginAction{
    
    COCLoginState.sharedSingleton.isLogin = YES;
    
    [self dismissViewControllerAnimated:YES completion:^{
        
        if (self.logined) {
            self.logined();
        }
    }];
    
}


-(void)cancelAction{
    
    
    [self dismissViewControllerAnimated:YES completion:nil];

}





#pragma mark -  AutoGetter

- (UIButton *)login {
    if (!_login) {
        _login = [[UIButton alloc] init];
        [_login   setTitle:@"登录" forState:UIControlStateNormal];
        _login.backgroundColor = [UIColor grayColor];
        [_login setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];

    }

    return _login;
}

- (UIButton *)cancel {
    if (!_cancel) {
        _cancel = [[UIButton alloc] init];
        [_cancel   setTitle:@"取消" forState:UIControlStateNormal];
        _cancel.backgroundColor = [UIColor grayColor];
        [_cancel setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];

    }

    return _cancel;
}

@end
