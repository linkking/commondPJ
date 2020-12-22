//
//  ZZA_MessageViewController.m
//  commondPJ
//
//  Created by zhulei on 2019/4/11.
//  Copyright © 2019 zhulei. All rights reserved.
//

#import "ZZA_MessageViewController.h"
#import <Lottie/Lottie.h>
#import <MJRefresh/MJRefresh.h>

@interface ZZA_MessageViewController ()<UITableViewDelegate,UITableViewDataSource,UIScrollViewDelegate>

@property (nonatomic, strong) UITableView *tableView;
@property(nonatomic, strong) NSMutableArray   *dataArray;

@property (nonatomic, strong) UIView *headerView;
@property (nonatomic, strong) UIButton *headerBtn;

@property (nonatomic, strong) UIView *bgHeaderView;

@property (nonatomic, assign) BOOL isShowHeaderView;
@property (nonatomic, assign) CGFloat lastContentOffset;

@property (nonatomic, assign) BOOL sectionCount;


@end


@implementation ZZA_MessageViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    //    [self addLottieView];
    self.navigationItem.title = @"消息";
    self.sectionCount = YES;
    [self addSubViews];
    [self addBackButton];
    [self addMJRefresh];
}

- (void)addLottieView{
    //tab_me_animate tab_message_animate tab_search_animate
    LOTAnimationView *lottieView = [LOTAnimationView animationNamed:@"tab_message_animate"];
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
}

- (void)addMJRefresh {
    self.tableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        
    }];
    self.tableView.mj_header.backgroundColor = [UIColor redColor];
    self.tableView.mj_header.ignoredScrollViewContentInsetTop = 200;
}


- (void)configerHeaderView {
    self.headerView = [[UIView alloc] initWithFrame:CGRectMake(0, -200, [UIScreen mainScreen].bounds.size.width, 200)];
    self.headerView.backgroundColor = UIColor.yellowColor;
    
    self.headerBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    self.headerBtn.frame = CGRectMake(20, 20, 60, 60);
    [self.headerBtn setTitle:@"按钮" forState:UIControlStateNormal];
    [self.headerBtn addTarget:self action:@selector(btnClick) forControlEvents:UIControlEventTouchUpInside];
    [self.headerView addSubview:self.headerBtn];
    
    [self.tableView addSubview:self.headerView];
    self.tableView.contentInset = UIEdgeInsetsMake(200, 0, 0, 0);
    //    self.tableView.tableHeaderView = self.headerView;
}

- (void)btnClick {
    NSLog(@"btnClick");
}

- (UITableView *)tableView {
    if (!_tableView) {
        _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 64, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height) style:UITableViewStylePlain];
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
    cell.textLabel.text = @"d熟知度动画覅";
    
    if (indexPath.section == 0) {
        cell.backgroundColor = UIColor.blueColor;
    }else {
        cell.backgroundColor = UIColor.redColor;
    }
    
    return cell;
}



- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}


- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    CGPoint point = scrollView.contentOffset;
    
    if (self.lastContentOffset > point.y) {
        // 向下滚动
    } else if (self.lastContentOffset < point.y) {
        // 向上滚动
        if (point.y >= self.headerView.frame.size.height + self.headerView.frame.origin.y) {
            NSLog(@"滚动");
            [self hiddenHeaderView];
            
        }
    }
    self.lastContentOffset = scrollView.contentOffset.y;
    
    
}


- (void)hiddenHeaderView {
    [self.headerView removeFromSuperview];
    [self.bgHeaderView removeFromSuperview];
    self.tableView.mj_header = nil ;
    
    MJRefreshHeader *header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        
    } ];
    [header setBackgroundColor:[UIColor redColor]];
    self.tableView.mj_header = header;
    
    self.tableView.contentInset = UIEdgeInsetsZero;
}

- (void)showHeaderView {

    [self.headerView removeFromSuperview];
    [self.bgHeaderView removeFromSuperview];
    self.tableView.contentInset = UIEdgeInsetsZero;
    
    
    CGPoint point = self.tableView.contentOffset;
    point.y = 0;
    
    
    self.bgHeaderView = [[UIView alloc]initWithFrame:CGRectMake(0, point.y - [UIScreen mainScreen].bounds.size.height,[UIScreen mainScreen].bounds.size.width ,[UIScreen mainScreen].bounds.size.height)];
    [self.bgHeaderView setBackgroundColor:[UIColor whiteColor]];
    [self.tableView addSubview:self.bgHeaderView];
    
    self.headerView.frame =  CGRectMake(0, point.y - 200, [UIScreen mainScreen].bounds.size.width, 200);
    [self.tableView addSubview:self.headerView];

    self.tableView.contentInset = UIEdgeInsetsMake(-(point.y - 200), 0, 0, 0);
    
    [self.tableView setContentOffset:CGPointMake(0,point.y - 200) animated:YES];

    self.tableView.mj_header = nil;
    MJRefreshHeader *header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        
    } ];
    [header setBackgroundColor:[UIColor redColor]];
    header.ignoredScrollViewContentInsetTop = - (point.y-200);
    self.tableView.mj_header = header;
    [self.tableView bringSubviewToFront:header];
    
}


@end
