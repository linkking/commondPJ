//
//  ZZA_HeaderImageView.m
//  commondPJ
//
//  Created by zhulei on 2020/3/26.
//  Copyright © 2020 zhulei. All rights reserved.
//

#import "ZZA_HeaderImageView.h"
#import "ZZA_HeaderImageCell.h"
#import <SDWebImage/SDWebImage.h>
#import <TYCyclePagerView/TYCyclePagerView.h>
#import <TYCyclePagerView/TYCyclePagerTransformLayout.h>
#import <TYCyclePagerView/TYPageControl.h>


@interface ZZA_HeaderImageView()<TYCyclePagerViewDelegate,TYCyclePagerViewDataSource>

@property (nonatomic, strong) TYCyclePagerView *pagerView;
@property (nonatomic, strong) TYPageControl *pageControl;
@property (nonatomic, strong) NSArray *datas;
@property (nonatomic, assign) BOOL isShowVideo;


@end


@implementation ZZA_HeaderImageView

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [self layoutMyViews];
    }
    
    return self;
}

- (instancetype)initWithCoder:(NSCoder *)aDecoder {
    if (self = [super initWithCoder:aDecoder]) {
       
        [self layoutMyViews];

    }
    return self;
}

- (void)layoutMyViews {
    self.isShowVideo = YES;
    [self addPagerView];
    [self addPageControl];
    [self viewConfigers];
//    [self loadData];
}

- (void)addPagerView {
    TYCyclePagerView *pagerView = [[TYCyclePagerView alloc]init];
    pagerView.frame = CGRectMake(0, 64, CGRectGetWidth(self.frame), 200);
//    pagerView.layer.borderWidth = 1;
    pagerView.isInfiniteLoop = YES; //支持循环
    pagerView.autoScrollInterval = 0;
    pagerView.dataSource = self;
    pagerView.delegate = self;
    // registerClass or registerNib
    [pagerView registerClass:[ZZA_HeaderImageCell class] forCellWithReuseIdentifier:@"cellId"];
    [self addSubview:pagerView];
    _pagerView = pagerView;
}

- (void)addPageControl {
    TYPageControl *pageControl = [[TYPageControl alloc]init];
    pageControl.frame = CGRectMake(0, CGRectGetHeight(_pagerView.frame) - 26, CGRectGetWidth(_pagerView.frame), 26);

    //pageControl.numberOfPages = _datas.count;
    pageControl.currentPageIndicatorSize = CGSizeMake(6, 6);
    pageControl.pageIndicatorSize = CGSizeMake(12, 6);
    pageControl.currentPageIndicatorTintColor = [UIColor redColor];
    pageControl.pageIndicatorTintColor = [UIColor grayColor];
//    pageControl.pageIndicatorImage = [UIImage imageNamed:@"Dot"];
//    pageControl.currentPageIndicatorImage = [UIImage imageNamed:@"DotSelected"];
//    pageControl.contentInset = UIEdgeInsetsMake(0, 20, 0, 20);
//    pageControl.contentHorizontalAlignment = UIControlContentHorizontalAlignmentCenter;
//    pageControl.contentVerticalAlignment = UIControlContentVerticalAlignmentCenter;
//    [pageControl addTarget:self action:@selector(pageControlValueChangeAction:) forControlEvents:UIControlEventValueChanged];
    [_pagerView addSubview:pageControl];
    _pageControl = pageControl;
    _pageControl.hidden = YES;

}

- (void)updateWithArray:(NSArray *)dataArray withShowVideo:(BOOL)video{
    _datas = dataArray;
    _isShowVideo = video;
    _pageControl.numberOfPages = _datas.count;
    [_pagerView reloadData];
}

- (void)loadData {
    NSMutableArray *datas = [NSMutableArray array];
    for (int i = 0; i < 7; ++i) {
        if (i == 0) {
            [datas addObject:[UIColor redColor]];
            continue;
        }
        [datas addObject:[UIColor colorWithRed:arc4random()%255/255.0 green:arc4random()%255/255.0 blue:arc4random()%255/255.0 alpha:arc4random()%255/255.0]];
    }
    _datas = [datas copy];
    _pageControl.numberOfPages = _datas.count;
    [_pagerView reloadData];
    //[_pagerView scrollToItemAtIndex:3 animate:YES];
}

- (void)viewConfigers {
    CGFloat value = 1.0;

    _pageControl.pageIndicatorSize = CGSizeMake(6*(1+value), 6*(1+value));
    _pageControl.currentPageIndicatorSize = CGSizeMake(8*(1+value), 8*(1+value));
    _pageControl.pageIndicatorSpaing = (1+value)*10;

}

#pragma mark - TYCyclePagerViewDataSource
- (NSInteger)numberOfItemsInPagerView:(TYCyclePagerView *)pageView {
    return _datas.count;
}

- (UICollectionViewCell *)pagerView:(TYCyclePagerView *)pagerView cellForItemAtIndex:(NSInteger)index {
    ZZA_HeaderImageCell *cell = [pagerView dequeueReusableCellWithReuseIdentifier:@"cellId" forIndex:index];
    cell.backgroundColor = UIColor.grayColor;
    [cell.carImageView sd_setImageWithURL:[NSURL URLWithString:self.datas[index]] placeholderImage:[UIImage imageNamed:@"car"]];
    cell.label.text = [NSString stringWithFormat:@"index->%ld",index];
    if (index == 0) {
        [cell configerCell:self.isShowVideo];
    }else {
        [cell configerCell:NO];
    }
    return cell;
}

- (TYCyclePagerViewLayout *)layoutForPagerView:(TYCyclePagerView *)pageView {
    TYCyclePagerViewLayout *layout = [[TYCyclePagerViewLayout alloc]init];
    layout.itemSize = CGSizeMake(CGRectGetWidth(pageView.frame)*1, CGRectGetHeight(pageView.frame)*1);
    layout.itemSpacing = 10;
    //layout.minimumAlpha = 0.3;
//    layout.itemHorizontalCenter = NO;
    return layout;
}



- (void)pagerView:(TYCyclePagerView *)pageView didSelectedItemCell:(__kindof UICollectionViewCell *)cell atIndex:(NSInteger)index{
    NSLog(@"click ->  %ld",index);
    if (self.imageDidClickBlock) {
        self.imageDidClickBlock(index);
    }
}


- (void)pagerView:(TYCyclePagerView *)pageView didScrollFromIndex:(NSInteger)fromIndex toIndex:(NSInteger)toIndex {
    _pageControl.currentPage = toIndex;
    //[_pageControl setCurrentPage:newIndex animate:YES];
    NSLog(@"%ld ->  %ld",fromIndex,toIndex);
    if (self.imageDidScrollBlock) {
        self.imageDidScrollBlock(fromIndex, toIndex);
    }
}


@end
