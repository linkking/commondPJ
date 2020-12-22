//
//  UITabBar+ZZALottie.m
//  commondPJ
//
//  Created by zhulei on 2019/4/11.
//  Copyright © 2019 zhulei. All rights reserved.
//

#import "UITabBar+ZZALottie.h"
#import <Lottie/Lottie.h>

static CGFloat LOTAnimationViewWidth = 35;
static CGFloat LOTAnimationViewHeiht = 35;

@implementation UITabBar (ZZALottie)


- (void)addLottieView:(NSString *)lottieName atIndex:(NSInteger)index{
    
    if (!lottieName) return;
    LOTAnimationView *lottieView = [LOTAnimationView animationNamed:lottieName];
    CGFloat itemWidth = (self.bounds.size.width / (self.items.count ? self.items.count : 1)) ;
    CGFloat x = ceil(index * itemWidth + (itemWidth - LOTAnimationViewWidth) /2);
    CGFloat y = 5;
    lottieView.frame = CGRectMake(x, y, LOTAnimationViewWidth, LOTAnimationViewHeiht);
    lottieView.userInteractionEnabled = NO;
    lottieView.contentMode = UIViewContentModeScaleAspectFit;
    lottieView.tag = 10000 + index;
    [self addSubview:lottieView];
}

- (void)playAnimationLottieAtIndex:(NSInteger)index{
    [self stopAnimationLottie];
    LOTAnimationView *lottieView = [self viewWithTag:(10000 + index)];
    if ([lottieView isKindOfClass:[LOTAnimationView class]]) {
        [lottieView play];
    }
    
}

- (void)stopAnimationLottie{
    if (self.items) {
        for(NSInteger i = 0; i<self.items.count; i++) {
            LOTAnimationView *lottieView = [self viewWithTag:(10000 + i)];
            if([lottieView isKindOfClass:[LOTAnimationView class]]){
                [lottieView stop];
            }
        }
    }
}

@end
