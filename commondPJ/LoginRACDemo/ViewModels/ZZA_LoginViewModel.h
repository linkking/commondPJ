//
//  ZZA_LoginViewModel.h
//  commondPJ
//
//  Created by zhulei on 2018/7/31.
//  Copyright © 2018 zhulei. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface ZZA_LoginViewModel : NSObject

@property (nonatomic,copy) NSString *userName;
@property (nonatomic,copy) NSString *password;

@property (nonatomic,strong) RACCommand *loginCommand;

- (RACSignal *)isValidUserNameAndPasswordSignal;

@end

NS_ASSUME_NONNULL_END
