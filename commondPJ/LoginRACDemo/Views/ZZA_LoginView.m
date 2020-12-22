//
//  ZZA_LoginView.m
//  commondPJ
//
//  Created by zhulei on 2018/7/31.
//  Copyright © 2018 zhulei. All rights reserved.
//

#import "ZZA_LoginView.h"

@implementation ZZA_LoginView

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [self setUpViews];
    }
    return self;
}

- (void)setUpViews{
    self.backgroundColor = [UIColor whiteColor];
    
    self.userNameTF = [[UITextField alloc]init];
    self.userNameTF.placeholder = @"用户名";
    self.userNameTF.borderStyle = UITextBorderStyleRoundedRect;
    [self addSubview:self.userNameTF];
    
    self.passwordTF = [[UITextField alloc]init];
    self.passwordTF.placeholder = @"密码";
    self.passwordTF.borderStyle = UITextBorderStyleRoundedRect;
    self.passwordTF.secureTextEntry = YES;
    [self addSubview:self.passwordTF];
    
    self.loginBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    self.loginBtn.layer.cornerRadius = 3.5f;
    self.loginBtn.layer.masksToBounds = YES;
    [self.loginBtn setTitle:@"登陆" forState:UIControlStateNormal];
    self.loginBtn.backgroundColor = [UIColor grayColor];
    [self addSubview:self.loginBtn];
    
    [self addMasConstraints];

    
}

- (void)addMasConstraints{
    [self.userNameTF mas_makeConstraints:^(MASConstraintMaker *make) {
        make.center.equalTo(self).with.centerOffset(CGPointMake(0, -80));
        make.width.equalTo(@250);
        make.height.equalTo(@30);
    }];
    
    [self.passwordTF mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self);
        make.top.equalTo(self.userNameTF.mas_bottom).with.offset(10);
        make.size.equalTo(self.userNameTF);
    }];
    
    [self.loginBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self);
        make.top.equalTo(self.passwordTF.mas_bottom).with.offset(10);
        make.size.equalTo(self.passwordTF);
    }];
}


@end

