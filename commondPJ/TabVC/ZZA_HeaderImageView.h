//
//  ZZA_HeaderImageView.h
//  commondPJ
//
//  Created by zhulei on 2020/3/26.
//  Copyright © 2020 zhulei. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN


typedef void(^ZZA_HeaderImageDidClickBlock)(NSInteger index);

typedef void(^ZZA_HeaderImageDidScrollFromIndexToIndexBlock)(NSInteger fromIndex, NSInteger toIndex);

@interface ZZA_HeaderImageView : UIView

@property (nonatomic, copy) ZZA_HeaderImageDidClickBlock imageDidClickBlock;
@property (nonatomic, copy) ZZA_HeaderImageDidScrollFromIndexToIndexBlock imageDidScrollBlock;


- (void)updateWithArray:(NSArray *)dataArray withShowVideo:(BOOL)video;


@end

NS_ASSUME_NONNULL_END
