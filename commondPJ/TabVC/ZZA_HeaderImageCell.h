//
//  ZZA_HeaderImageCell.h
//  commondPJ
//
//  Created by zhulei on 2020/3/26.
//  Copyright © 2020 zhulei. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface ZZA_HeaderImageCell : UICollectionViewCell

@property (nonatomic, strong) UILabel *label;

@property (nonatomic, strong) UIImageView *carImageView;
@property (nonatomic, strong) UIImageView *videoImage;

- (void)configerCell:(BOOL)isShowVideo;

@end

NS_ASSUME_NONNULL_END
