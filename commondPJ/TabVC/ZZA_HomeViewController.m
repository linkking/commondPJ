//
//  ViewController.m
//  commondPJ
//
//  Created by zhulei on 2018/5/18.
//  Copyright © 2018年 zhulei. All rights reserved.
//

#import "ZZA_HomeViewController.h"
#import "ZZA_LoginViewController.h"
#import "ZZA_RACMainViewController.h"
#import "ZZA_GCDViewController.h"
#import "Person.h"
#import "CJ_LetCode.h"
#import <Lottie/Lottie.h>
#import <malloc/malloc.h>
#include <pthread.h>
#import "Student.h"
//#import "Student+test.h"
#import "ZZA_HeaderImageView.h"
#import <SDWebImage/SDWebImageManager.h>
#import <SDWebImage/SDImageCache.h>
@interface ZZA_HomeViewController ()

@property (nonatomic,strong) NSMutableSet *mutSet;
@property (nonatomic,strong) LOTAnimationView  *lottieView;
@property (nonatomic, strong) ZZA_HeaderImageView *headerView;
@property (nonatomic, strong) UIButton *jumpBtn;


@end

extern void _objc_autoreleasePoolPrint(void);

@implementation ZZA_HomeViewController

- (void)viewDidLoad {
    self.view.backgroundColor = [UIColor whiteColor];
    [super viewDidLoad];
    [self addSubView];
//
//    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(configerNotifi:) name:@"HomeNotification" object:nil];
//
//    NSOperationQueue *queue = [NSOperationQueue new];
//    queue.maxConcurrentOperationCount = 1;
//    queue.name = @"com.seir.sss";
//
//
//    [[NSNotificationCenter defaultCenter] addObserverForName:@"HomeNotification" object:nil queue:queue usingBlock:^(NSNotification * _Nonnull note) {
//         NSLog(@"block--通知来了,%@ ---%@",[NSThread currentThread],queue);
//        sleep(3);
//
//    }];
//    [queue addOperationWithBlock:^{
//        NSLog(@"block--queue,%@",[NSThread currentThread]);
//    }];
    

    Person *person = [[Person alloc]init];
    NSInteger result =  person.add(5).minus(4).result;
    NSLog(@"zhulei --result %ld",result);
    
    
    Person *otherP = person;

}

- (void)configerNotifi:(NSNotification *)notification {
    NSLog(@"start--通知来了,%@",[NSThread currentThread]);
    
    sleep(3);
//    dispatch_async(dispatch_get_global_queue(0, 0), ^{
//        sleep(3);
//        NSLog(@"mid--通知结束,%@",[NSThread currentThread]);
//    });
//
    dispatch_async(dispatch_get_main_queue(), ^{
        [self.jumpBtn setTitle:@"踢踢腿" forState:UIControlStateNormal];
    });
    
    
    NSLog(@"end--通知来了,%@",[NSThread currentThread]);

    
}

- (void)addSubView {
    UIButton *jumpBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [jumpBtn setTitle:@"跳转" forState:UIControlStateNormal];
    [jumpBtn setTitleColor:UIColor.blackColor forState:UIControlStateNormal];
    jumpBtn.frame = CGRectMake(100, 400, 60, 60);
    jumpBtn.backgroundColor = UIColor.grayColor;
    [jumpBtn addTarget:self action:@selector(jumpBtnClick) forControlEvents:UIControlEventTouchUpInside];
    self.jumpBtn = jumpBtn;
    [self.view addSubview:jumpBtn];
    
    UIButton *jumpBtn1 = [UIButton buttonWithType:UIButtonTypeCustom];
    [jumpBtn1 setTitle:@"跳转1" forState:UIControlStateNormal];
    [jumpBtn1 setTitleColor:UIColor.blackColor forState:UIControlStateNormal];
    jumpBtn1.frame = CGRectMake(200, 400, 60, 60);
    jumpBtn1.backgroundColor = UIColor.grayColor;
    [jumpBtn1 addTarget:self action:@selector(jumpBtnClick1) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:jumpBtn1];
    [self addHeadView];
    
}

- (void)addHeadView {
    CGFloat width = CGRectGetWidth(self.view.frame);
    CGFloat height = (width * 2/3);

    self.headerView = [[ZZA_HeaderImageView alloc] initWithFrame:CGRectMake(0, 40, width, height)];
    self.headerView.imageDidClickBlock = ^(NSInteger index) {
        NSLog(@"点击了图片---%ld",index);
    };
    
    self.headerView.imageDidScrollBlock = ^(NSInteger fromIndex, NSInteger toIndex) {
        NSLog(@"图片滚动到---%ld",toIndex);

    };
    [self.view addSubview:self.headerView];
    
    
    NSArray *imags = @[@"http://e.hiphotos.baidu.com/image/pic/item/a1ec08fa513d2697e542494057fbb2fb4316d81e.jpg",
    @"http://c1.xinstatic.com/c/20190416/1811/5cb5aa4a742fe992209_19.jpg",
    @"http://c6.xinstatic.com/o/20200111/0952/5e192a550d2b2309578_19.jpg",
    @"http://c1.xinstatic.com/o/20200111/0952/5e192a550d2b2309578_19.jpg",
    ];
    [self.headerView updateWithArray:imags withShowVideo:YES];
    
}

- (void)addLottieView{
    //tab_me_animate tab_message_animate tab_search_animate
    self.lottieView = [LOTAnimationView animationNamed:@"tab_search_animate"];
    self.lottieView.frame = CGRectMake(150, 300, 50, 50);
    [self.view addSubview:self.lottieView];
}

- (void)delayMethod {
    NSLog(@"delayMethod");
}

- (void)jumpBtnClick {
    
    [self jumpGCDVC];
//    [self.lottieView pause];
    
//    NSArray *imags = @[@"http://c5.xinstatic.com/c/20190416/1811/5cb5aa4a742fe992209_19.jpg",
//    @"http://c1.xinstatic.com/c/20190416/1811/5cb5aa4a742fe992209_19.jpg",
//    @"http://c6.xinstatic.com/o/20200111/0952/5e192a550d2b2309578_19.jpg",
//    @"http://c1.xinstatic.com/o/20200111/0952/5e192a550d2b2309578_19.jpg",
//    @"http://c1.xinstatic.com/c/20190416/1811/5cb5aa4a742fe992209_19.jpg",
//    @"http://c6.xinstatic.com/o/20200111/0952/5e192a550d2b2309578_19.jpg",
//    @"http://c1.xinstatic.com/o/20200111/0952/5e192a550d2b2309578_19.jpg",
//    @"http://e.hiphotos.baidu.com/image/pic/item/a1ec08fa513d2697e542494057fbb2fb4316d81e.jpg",
//    @"http://e.hiphotos.baidu.com/image/pic/item/a1ec08fa513d2697e542494057fbb2fb4316d81e.jpg"
//
//    ];
//    [self.headerView updateWithArray:imags withShowVideo:NO];
    
}


- (void)jumpBtnClick1 {
//
//    NSArray *imags = @[
//    @"http://e.hiphotos.baidu.com/image/pic/item/a1ec08fa513d2697e542494057fbb2fb4316d81e.jpg"
//
//
//    ];
//    [self.headerView updateWithArray:imags withShowVideo:YES];
    
    
    NSLog(@"开始");
    [[NSNotificationCenter defaultCenter] postNotificationName:@"HomeNotification" object:nil];
    NSLog(@"结束");

    
}

- (void)jumpLoginVC{
    ZZA_LoginViewController *loginVC = [[ZZA_LoginViewController alloc]init];
    [self.navigationController pushViewController:loginVC animated:YES];
}

- (void)jumpRACVC{
    ZZA_RACMainViewController *racVC = [[ZZA_RACMainViewController alloc]init];
    [self.navigationController pushViewController:racVC animated:YES];
}

- (void)jumpGCDVC{
    ZZA_GCDViewController *gcdVC = [[ZZA_GCDViewController alloc]init];
    [self.navigationController pushViewController:gcdVC animated:YES];
}


- (void)testLetCode{
//   NSInteger index =  [CJ_LetCode binarySearchArray:@[@1,@2,@3,@4,@6,@8,@10] result:1];
//    NSLog(@"index = %ld",index);
    
    
    NSArray *array = [CJ_LetCode quickSort:@[@6,@5,@37,@4,@51,@2,@10,@32,@33,@42,@25]];
    NSLog(@"array = %@",array);
    NSDictionary *dic = [NSDictionary dictionaryWithObjectsAndKeys:[UIImage imageNamed:@"233232"],@"23232" ,nil]; //  @{@"minge":[UIImage imageNamed:@"233232"]};
    NSLog(@"dic = %@",dic);
    
    NSArray *listArray = [NSArray arrayWithObjects:[UIImage imageNamed:@"233232"],[UIImage imageNamed:@"233332"], nil];
    NSLog(@"listArray = %@",listArray);

    NSArray *listArray2 = [[NSArray alloc]initWithObjects:[UIImage imageNamed:@"233232"],[UIImage imageNamed:@"233332"], nil];
    NSLog(@"listArray2 = %@",listArray2);
    
    

}

- (void)testCopyAndMutableCopy {
    
   
    
    NSMutableArray * dataArray2=[NSMutableArray arrayWithObjects:
                                 [NSMutableString stringWithString:@"one"],
                                 [NSMutableString stringWithString:@"two"],
                                 [NSMutableString stringWithString:@"three"],
                                 [NSMutableString stringWithString:@"four"],
                                 nil
                                 ];
    
    NSMutableArray * dataArray3;
    NSMutableString * mStr;
    
    dataArray3=[dataArray2 mutableCopy];
    mStr = dataArray2[0];
//    mStr = [dataArray2[0] mutableCopy];
    [mStr appendString:@"--ONE"];
    [dataArray2 addObject:@"five"];
//    [dataArray2 removeObjectAtIndex:1];
//
//    [dataArray3 addObject:@"five"];
//    [dataArray3 removeObjectAtIndex:0];
    NSLog(@"dataArray3：%@  ~~~~ %p",dataArray3,&dataArray3);
    NSLog(@"dataArray2：%@  ~~~~ %p",dataArray2,&dataArray2);
    
    
    NSMutableArray *array4 = [[NSMutableArray alloc] initWithArray:@[@1]];
    
    NSArray *array5 = [array4 copy];
    
    array4[0] = @(2);
    
    NSLog(@"内存地址:%p---%p", array4,array5);

    NSLog(@"值:%@---%@", array4,array5);

    
}

@end
