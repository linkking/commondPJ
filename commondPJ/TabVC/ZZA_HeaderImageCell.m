//
//  ZZA_HeaderImageCell.m
//  commondPJ
//
//  Created by zhulei on 2020/3/26.
//  Copyright © 2020 zhulei. All rights reserved.
//

#import "ZZA_HeaderImageCell.h"

@implementation ZZA_HeaderImageCell


- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        self.backgroundColor = [UIColor clearColor];
        [self addLabel];
    }
    return self;
}

- (instancetype)initWithCoder:(NSCoder *)aDecoder {
    if (self = [super initWithCoder:aDecoder]) {
        self.backgroundColor = [UIColor clearColor];
        [self addLabel];
    }
    return self;
}


- (void)addLabel {
    
    UILabel *label = [[UILabel alloc]init];
    label.textAlignment = NSTextAlignmentCenter;
    label.textColor = [UIColor whiteColor];
    label.font = [UIFont systemFontOfSize:18];
    [self.contentView addSubview:label];
    _label = label;
    
    
    self.carImageView = [[UIImageView alloc] init];
    [self.label addSubview:self.carImageView];
//    self.carImageView.backgroundColor = UIColor.redColor;
    [self.carImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.mas_equalTo(0);
    }];
    
    self.videoImage = [[UIImageView alloc] init];
    self.videoImage.hidden = YES;
    self.videoImage.backgroundColor = UIColor.yellowColor;
    [self.label addSubview:self.videoImage];
    [self.videoImage mas_makeConstraints:^(MASConstraintMaker *make) {
        make.center.equalTo(self.contentView);
        make.width.height.mas_equalTo(50);
    }];
}

- (void)layoutSubviews {
    [super layoutSubviews];
    _label.frame = self.bounds;
}

- (void)configerCell:(BOOL)isShowVideo {
    self.videoImage.hidden = !isShowVideo;
}

@end
