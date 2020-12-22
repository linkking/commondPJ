//
//  ZZA_NavigationController.m
//  commondPJ
//
//  Created by zhulei on 2019/3/20.
//  Copyright © 2019 zhulei. All rights reserved.
//

#import "ZZA_NavigationController.h"

@interface ZZA_NavigationController ()

@end

@implementation ZZA_NavigationController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}



- (void)pushViewController:(UIViewController *)viewController animated:(BOOL)animated {
    if (self.viewControllers.count > 0) {
        viewController.hidesBottomBarWhenPushed = YES;
    }
    [super pushViewController:viewController animated:YES];
}

/**
 去掉rootView的控制，让导航栈的topViewController自己控制statusBar
 */
- (UIViewController *)childViewControllerForStatusBarStyle{
    return self.topViewController;
}

- (UIViewController *)childViewControllerForStatusBarHidden {
    return self.topViewController;
}

- (BOOL)shouldAutorotate {
    return [self.topViewController shouldAutorotate];
}

@end
