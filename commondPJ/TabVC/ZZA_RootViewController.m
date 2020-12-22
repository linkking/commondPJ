//
//  ZZA_RootViewController.m
//  commondPJ
//
//  Created by zhulei on 2019/4/11.
//  Copyright © 2019 zhulei. All rights reserved.
//

#import "ZZA_RootViewController.h"
#import "ZZA_NavigationController.h"
#import "ZZA_HomeViewController.h"
#import "ZZA_MessageViewController.h"
#import "ZZA_MineViewController.h"
#import "UITabBar+ZZALottie.h"
@interface ZZA_RootViewController ()<UITabBarControllerDelegate>

@property (nonatomic,assign) NSInteger lastSelectIndex;


@end

@implementation ZZA_RootViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.

    self.delegate = self;
    self.lastSelectIndex = -1;
    [self addSubViewControllers];
    
    [self configerTabBar];

}

- (void)addSubViewControllers{
    
    ZZA_HomeViewController *homeVC = [[ZZA_HomeViewController alloc]init];
    ZZA_NavigationController *homeNav = [[ZZA_NavigationController alloc]initWithRootViewController:homeVC];
//    homeNav.tabBarItem.title = @"首页";
    
    ZZA_MessageViewController *messageVC = [[ZZA_MessageViewController alloc]init];
    ZZA_NavigationController *messageNav = [[ZZA_NavigationController alloc]initWithRootViewController:messageVC];
    
    ZZA_MineViewController *myVC = [[ZZA_MineViewController alloc]init];
    ZZA_NavigationController *myNav = [[ZZA_NavigationController alloc]initWithRootViewController:myVC];
//    myNav.tabBarItem.title = @"我的";
    
    self.viewControllers = @[homeNav,messageNav,myNav];

    self.tabBar.tintColor = [UIColor orangeColor];
    self.tabBar.backgroundColor = [UIColor clearColor];
    self.tabBar.backgroundImage = [[UIImage alloc]init];
    
}

- (void)configerTabBar{
    //tab_me_animate tab_message_animate tab_search_animate
    NSArray *jsonArray = @[@"tab_search_animate",@"tab_message_animate",@"tab_me_animate"];
    
    for (NSInteger i = 0; i < self.viewControllers.count; i++) {
        [self.tabBar addLottieView:jsonArray[i] atIndex:i];
    }
    

}


#pragma mark - UITabBarControllerDelegate

- (void)tabBarController:(UITabBarController *)tabBarController didSelectViewController:(UIViewController *)viewController{

    NSInteger index = tabBarController.selectedIndex;
    
    if (index == self.lastSelectIndex) {
        return;
    }else{
        self.lastSelectIndex = index;
        [self.tabBar playAnimationLottieAtIndex:index];
    }
    
}

@end
