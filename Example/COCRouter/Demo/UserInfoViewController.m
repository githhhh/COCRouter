//
//  UserInfoViewController.m
//  COCRouter
//
//  Created by bin on 2017/6/21.
//  Copyright © 2017年 githhhh. All rights reserved.
//

#import "UserInfoViewController.h"
#import "COCRouter+Navigation.h"

@interface UserInfoViewController ()

@property (strong, nonatomic) NSString* userID;

@end

@implementation UserInfoViewController

#pragma mark - params

-(NSString *)userID{
    if (!_userID) {
        _userID = self.routeContext.pathInnerParams.allValues.firstObject;
    }
    return _userID;
}


#pragma mark - Life cycle

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor whiteColor];
    
    self.title = [NSString stringWithFormat:@"当前用户ID[%@]",self.userID];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



@end
