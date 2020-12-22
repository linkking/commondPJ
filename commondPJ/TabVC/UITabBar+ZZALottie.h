//
//  UITabBar+ZZALottie.h
//  commondPJ
//
//  Created by zhulei on 2019/4/11.
//  Copyright © 2019 zhulei. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UITabBar (ZZALottie)

/**
 增加lLottie动图
 
 @param lottieName lottie动画需要的json文件名称
 @param index 位置
 */
- (void)addLottieView:(NSString *)lottieName atIndex:(NSInteger)index;


/**
 点击开始动画
 */
- (void)playAnimationLottieAtIndex:(NSInteger)index;




@end

NS_ASSUME_NONNULL_END
