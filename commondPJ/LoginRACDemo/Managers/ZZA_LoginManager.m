//
//  ZZA_LoginManager.m
//  commondPJ
//
//  Created by zhulei on 2018/7/31.
//  Copyright © 2018 zhulei. All rights reserved.
//

#import "ZZA_LoginManager.h"

@implementation ZZA_LoginManager

+ (void)login:(NSDictionary *)dict callback:(ZZALoginCallBack)callback{
    //网络请求，解析数据
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        callback(YES,@"登录成功");
    });
    
}

@end
