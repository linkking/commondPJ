//
//  MBProgressHUD+ZZAHelper.m
//  commondPJ
//
//  Created by zhulei on 2018/7/31.
//  Copyright © 2018 zhulei. All rights reserved.
//

#import "MBProgressHUD+ZZAHelper.h"

@implementation MBProgressHUD (ZZAHelper)

+ (void)showMessage:(NSString *)message onView:(UIView *)view
{
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:view animated:YES];
    
    // configure for text
    hud.mode = MBProgressHUDModeText;
    hud.label.text = message;
    hud.removeFromSuperViewOnHide = YES;
    [hud hideAnimated:YES afterDelay:1.0f];
}

@end
