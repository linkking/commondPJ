//
//  ZZA_LoginViewController.m
//  commondPJ
//
//  Created by zhulei on 2018/7/31.
//  Copyright © 2018 zhulei. All rights reserved.
//

#import "ZZA_LoginViewController.h"
#import "ZZA_LoginView.h"
#import "ZZA_LoginViewModel.h"
#import "MBProgressHUD+ZZAHelper.h"

@interface ZZA_LoginViewController ()

@property (nonatomic,strong) ZZA_LoginView  *loginView;
@property (nonatomic,strong) ZZA_LoginViewModel *viewModel;

@end

@implementation ZZA_LoginViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self layoutMyViews];
    [self bindWithViewModel];
}

- (void)layoutMyViews{
    self.loginView = [[ZZA_LoginView alloc]init];
    [self.view addSubview:self.loginView];
    
    [self.loginView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.view);
    }];
    
}

- (void)bindWithViewModel{
    self.viewModel = [[ZZA_LoginViewModel alloc]init];
    
    RAC(self.viewModel,userName) = self.loginView.userNameTF.rac_textSignal;
    RAC(self.viewModel,password) = self.loginView.passwordTF.rac_textSignal;
    @weakify(self);
    [[[self.viewModel isValidUserNameAndPasswordSignal] map:^id (NSNumber *value) {
        return [value boolValue] ? [UIColor orangeColor]:[UIColor grayColor];
    }] subscribeNext:^(UIColor *color) {
        @strongify(self);
        self.loginView.loginBtn.backgroundColor = color;
    }];
    
    self.loginView.loginBtn.rac_command = self.viewModel.loginCommand;
    
    [[self.viewModel.loginCommand.executionSignals switchToLatest]
     subscribeNext:^(NSString *msg) {
        @strongify(self);
        [MBProgressHUD showMessage:msg onView:self.view];
         
        
    }];
    
}

- (void)dealloc{
    NSLog(@"deallo loginVC");
}

@end
