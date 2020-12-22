//
//  ZZA_LoginManager.h
//  commondPJ
//
//  Created by zhulei on 2018/7/31.
//  Copyright © 2018 zhulei. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

typedef void (^ZZALoginCallBack)(BOOL issuccess, id data);


@interface ZZA_LoginManager : NSObject

//登录
+ (void)login:(NSDictionary *)dict callback:(ZZALoginCallBack)callback;


@end

NS_ASSUME_NONNULL_END
