//
//  MBProgressHUD+ZZAHelper.h
//  commondPJ
//
//  Created by zhulei on 2018/7/31.
//  Copyright © 2018 zhulei. All rights reserved.
//

#import <MBProgressHUD/MBProgressHUD.h>

NS_ASSUME_NONNULL_BEGIN

@interface MBProgressHUD (ZZAHelper)
+ (void)showMessage:(NSString *)message onView:(UIView *)view;
@end

NS_ASSUME_NONNULL_END
