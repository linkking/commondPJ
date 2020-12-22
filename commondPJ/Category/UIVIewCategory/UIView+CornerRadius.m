//
//  UIView+CornerRadius.m
//  commondPJ
//
//  Created by zza on 2019/12/24.
//  Copyright © 2019 admin. All rights reserved.
//

#import "UIView+CornerRadius.h"
#import "YXU_CornerRadiusTool.h"

@implementation UIView (CornerRadius)

- (void)drawCircularBeadImageWithRadius:(float)radius CustomCornerStyle:(CustomRectCorner)type {
    [self drawCircularBeadImageWithRadius:radius fillColor:UIColor.whiteColor CustomCornerStyle:type];
}

- (void)drawCircularBeadImageWithRadius:(float)radius fillColor:(UIColor *)fillColor CustomCornerStyle:(CustomRectCorner)type {
    UIRectCorner cornerType = 0;
    if (type & CustomRectCornerTop) {
        cornerType |= UIRectCornerTopLeft | UIRectCornerTopRight;
    }
    
    if (type & CustomRectCornerBottom) {
        cornerType |= UIRectCornerBottomLeft | UIRectCornerBottomRight ;
    }
    
    if (type == CustomRectCornerAll) {
        cornerType = UIRectCornerAllCorners;
    }
    
    [self drawCircularBeadImageWithRadius:radius fillColor:fillColor CornerStyle:cornerType];
}


- (void)drawCircularBeadImageWithRadius:(float)radius fillColor:(UIColor *)fillColor CornerStyle:(UIRectCorner)type {
    UIImageView *imgView = [[UIImageView alloc] init];
    [self addSubview:imgView];
    [self layoutIfNeeded];
    imgView.frame = self.bounds;

    imgView.image = [YXU_CornerRadiusTool drawAntiRoundedCornerImageWithRadius:radius rectSize:imgView.frame.size fillColor:fillColor cornerStyle:type];
}

- (void)drawCircularBeadImageWithRadius_TL:(float)radius_TL
                             radius_TR:(float)radius_TR
                             radius_BL:(float)radius_BL
                             radius_BR:(float)radius_BR
                             fillColor:(UIColor *)fillColor {
    UIImageView *imgView = [[UIImageView alloc] init];
    [self addSubview:imgView];
    [self layoutIfNeeded];
    imgView.frame = self.bounds;

    imgView.image = [YXU_CornerRadiusTool drawAntiRoundedCornerWithRadius_TL:radius_TL radius_TR:radius_TR radius_BL:radius_BL radius_BR:radius_BR rectSize:imgView.frame.size fillColor:fillColor];
}

@end
