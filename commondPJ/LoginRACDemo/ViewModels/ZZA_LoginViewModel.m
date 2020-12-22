//
//  ZZA_LoginViewModel.m
//  commondPJ
//
//  Created by zhulei on 2018/7/31.
//  Copyright © 2018 zhulei. All rights reserved.
//

#import "ZZA_LoginViewModel.h"
#import "ZZA_LoginManager.h"

@implementation ZZA_LoginViewModel

- (instancetype)init {
    self = [super init];
    if (self) {
        [self initBind];
    }
    return self;
}

- (void)initBind {
    self.userName = @"";
    self.password = @"";
    
    @weakify(self);
    self.loginCommand = [[RACCommand alloc]initWithEnabled:[self isValidUserNameAndPasswordSignal] signalBlock:^RACSignal * _Nonnull(id  _Nullable input) {
        @strongify(self);
        return [self loginWithName:self.userName password:self.password];
    }];
}


- (RACSignal *)isValidUserNameAndPasswordSignal{
    return [RACSignal combineLatest:@[RACObserve(self, userName),RACObserve(self, password)] reduce:^(NSString *name ,NSString *pwd){
        return @(name.length > 3 && pwd.length > 6);
    }];
}
- (RACSignal *)loginWithName:(NSString *)name password:(NSString *)pwd{
    RACSignal *loginSignal = [RACSignal createSignal:^RACDisposable * _Nullable(id<RACSubscriber>  _Nonnull subscriber) {
        
        [ZZA_LoginManager login:@{name:name,pwd:pwd} callback:^(BOOL issuccess, id  _Nonnull data) {
            if (issuccess) {
                [subscriber sendNext:data];
                [subscriber sendCompleted];
            }else{
                [subscriber sendError:nil];
            }
        }];
        
        return nil;
    }];
    return loginSignal;
}


@end
