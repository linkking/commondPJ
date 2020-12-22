//
//  ZZA_MineViewController.m
//  commondPJ
//
//  Created by zhulei on 2019/4/11.
//  Copyright © 2019 zhulei. All rights reserved.
//

#import "ZZA_MineViewController.h"
#import <Lottie/Lottie.h>
#import <MJRefresh/MJRefresh.h>

@interface ZZA_MineViewController ()<UITableViewDelegate,UITableViewDataSource,UIScrollViewDelegate>
@property (nonatomic, strong) UITableView *tableView;
@property(nonatomic, strong) NSMutableArray   *dataArray;

@property (nonatomic, strong) UIView *headerView;

@property (nonatomic, assign) BOOL isHiddenHeaderView;
@property (nonatomic, assign) CGFloat lastContentOffset;


@end

@implementation ZZA_MineViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    self.navigationItem.title = @"消息";
    [self addSubViews];
    [self addBackButton];

//    [self addMJRefresh];
}

- (void)addLottieView{
    //tab_me_animate tab_message_animate tab_search_animate
    LOTAnimationView *lottieView = [LOTAnimationView animationNamed:@"tab_me_animate"];
    lottieView.frame = CGRectMake(150, 300, 50, 50);
    [self.view addSubview:lottieView];
}


- (void)addBackButton {
    UIBarButtonItem *leftBackButton = [[UIBarButtonItem alloc] initWithTitle:@"点击" style:(UIBarButtonItemStylePlain) target:self action:@selector(clickBackBtn)];
    self.navigationItem.leftBarButtonItem = leftBackButton;
    
}

- (void)clickBackBtn {
    NSLog(@"点击了返回");
    [self showHeaderView];
}

- (void)addSubViews {
    [self.view addSubview:self.tableView];
    [self configerHeaderView];
//    [self.tableView setContentOffset:CGPointMake(0,200) animated:NO];

}

- (void)addMJRefresh {
    self.tableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        
    }];
    
}


- (void)configerHeaderView {
    self.headerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, 200)];
    self.headerView.backgroundColor = UIColor.yellowColor;
    
//    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(9, 9, 300, 200)];
//    label.textColor = UIColor.blackColor;
//    label.textAlignment = NSTextAlignmentLeft;
//    label.text = @"UIImage *leftButtonIcon = [[UIImage imageNamimageWithion:@selector(goToBack)]";
//    [self.headerView addSubview:label];
    
    self.tableView.tableHeaderView = self.headerView;
}

- (UITableView *)tableView {
    if (!_tableView) {
        _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 64, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height - 44 - 64) style:UITableViewStylePlain];
        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        _tableView.separatorColor =  UIColor.whiteColor;//_COLOR_HEX(0x999999);
        if (@available(iOS 11.0, *)) {
            _tableView.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
            _tableView.estimatedRowHeight = 0;
            _tableView.estimatedSectionFooterHeight = 0;
            _tableView.estimatedSectionHeaderHeight = 0;
        } else {
            if ([self respondsToSelector:@selector(automaticallyAdjustsScrollViewInsets)]) {
                self.automaticallyAdjustsScrollViewInsets = NO;
            }
        }
        _tableView.delegate = self;
        _tableView.dataSource = self;
    }
    return _tableView;
}

#pragma mark - UITableViewDelegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}

#pragma mark - UITableViewDataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 40;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = (UITableViewCell *)[tableView dequeueReusableCellWithIdentifier:@"CellWithIdentifier"];
    if (cell == nil) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"CellWithIdentifier" ];
    }
    cell.textLabel.text = @"熟知度动画覅";
    cell.backgroundColor = UIColor.blueColor;
   
    
    return cell;
}




- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    CGPoint point = scrollView.contentOffset;
    
    if (self.lastContentOffset > point.y) {
        // 向下滚动
    } else if (self.lastContentOffset < point.y) {
        // 向上滚动
        if (point.y >= 200.2 && self.isHiddenHeaderView == NO) {
            NSLog(@"滚动");
            [self hiddenHeaderView];

        }
    }
    self.lastContentOffset = scrollView.contentOffset.y;
    
    
}


- (void)hiddenHeaderView {
    self.headerView.frame = CGRectZero;
    [self.tableView setContentOffset:CGPointMake(0,0) animated:NO];
    [self.tableView reloadData];
    self.isHiddenHeaderView = YES;
}

- (void)showHeaderView {
    self.headerView.frame = CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, 200);
    [self.tableView reloadData];
    //        CGPoint point = self.tableView.contentOffset;
    //        point.y = point.y + 200;
    //        [self.tableView setContentOffset:point animated:NO];
    [self.tableView setContentOffset:CGPointMake(0,200) animated:NO];
    
    [self.tableView setContentOffset:CGPointMake(0,0) animated:YES];
    self.isHiddenHeaderView = NO;
   
    
  
}


@end
