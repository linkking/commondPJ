//
//  ZZA_GCDViewController.m
//  commondPJ
//
//  Created by zhulei on 2019/11/12.
//  Copyright © 2019 zhulei. All rights reserved.
//

#import "ZZA_GCDViewController.h"

@interface ZZA_GCDViewController ()

@end

@implementation ZZA_GCDViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = UIColor.whiteColor;
//    [self testGCD_Timer];
//    [self testGCD_2];
//    [self testGCD_4];

//    NSMutableArray *arry = [[NSMutableArray arrayWithObjects:@1,@2, nil];
    
//    [self test_SendNot];
    
    
    __weak typeof(self) weakself = self;
    //如果子线程执行这个返回，不会阻塞
    dispatch_queue_t serialQueue = dispatch_queue_create("com.testqueue.serial", DISPATCH_QUEUE_SERIAL);
    dispatch_async(serialQueue, ^{
        NSLog(@"%@",[NSThread currentThread]);
        sleep(5);
        [weakself test_5];
    });

    void(^blocks)(void) = ^{
        __strong typeof(weakself)strongself = weakself;
        [strongself test_5];
    };
//    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
//        blocks();
//    });
    
}



- (void)dealloc
{
    NSLog(@"%s",__func__);
}

- (void)doSomeThing{

    NSLog(@"invoke doSomeThing");
}

- (void)testGCD_Block{

    __weak typeof(self) weakSelf = self;
    void(^blocks)(void) = ^{
//        [self doSomeThing];
        [self performSelector:@selector(doSomeThing) withObject:self afterDelay:3];
    };
    blocks();
}

- (void)testGCD_Timer{
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(3 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        NSLog(@"do something after 3s");
//        [self doSomeThing];
    });
}


- (void)testGCD_2{
    //    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
    //        [self delayMethod];
    //    });
        
        dispatch_async(dispatch_get_global_queue(0, 0), ^{
            NSLog(@"1");
            [self performSelector:@selector(doSomeThing) withObject:nil afterDelay:0];
            NSLog(@"3");
            [[NSRunLoop currentRunLoop] addPort:[[NSPort alloc] init] forMode:NSDefaultRunLoopMode];
            [[NSRunLoop currentRunLoop] runMode:NSDefaultRunLoopMode beforeDate:[NSDate distantFuture]];
        });
}

- (void)testGCD_3{
    dispatch_queue_t quque = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
    
    // 串行队列的创建方法
    dispatch_queue_t queue1 = dispatch_queue_create("net.zza.testQueue", DISPATCH_QUEUE_SERIAL);
    dispatch_queue_t queue11 = dispatch_queue_create("net.zza.zhulie", DISPATCH_QUEUE_SERIAL);

    
    // 并发队列的创建方法
    dispatch_queue_t queue2 = dispatch_queue_create("net.zza.testQueue", DISPATCH_QUEUE_CONCURRENT);
    
    
    NSLog(@"111111");
    dispatch_async(quque, ^{
        NSLog(@"22222");
        dispatch_sync(quque, ^{
            NSLog(@"333333");
        });
    });
    NSLog(@"4444444");

    
}
- (void)testGCD_4{
    dispatch_queue_t serialQueue = dispatch_queue_create("com.testqueue.serial", DISPATCH_QUEUE_SERIAL);
    dispatch_sync(serialQueue, ^{
        NSLog(@"Task 1 begin.");

        dispatch_sync(dispatch_get_main_queue(), ^{
            dispatch_async(serialQueue, ^{
                NSLog(@"Task 2 begin.");
            });
        });

        NSLog(@"Task 1 complete.");
    });


    
}


- (void)test{
    dispatch_queue_t queue = dispatch_queue_create("com.hao123.www", DISPATCH_QUEUE_SERIAL);
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        dispatch_sync(queue, ^{
            NSLog(@"11 %@",[NSThread currentThread]);
        });
    });
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        dispatch_sync(queue, ^{
            NSLog(@"22 %@",[NSThread currentThread]);
        });
    });
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        [NSThread sleepForTimeInterval:4];
        dispatch_sync(queue, ^{
            NSLog(@"33 %@",[NSThread currentThread]);
        });
    });
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        dispatch_sync(queue, ^{
            NSLog(@"44 %@",[NSThread currentThread]);
        });
    });
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        dispatch_sync(queue, ^{
            NSLog(@"55 %@",[NSThread currentThread]);
        });
    });
}

- (void)test2{
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        dispatch_sync(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
            NSLog(@"11  %@",[NSThread currentThread]);
        });
    });
    
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        dispatch_sync(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
            NSLog(@"22  %@",[NSThread currentThread]);
        });
    });
    
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        dispatch_sync(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
            NSLog(@"33  %@",[NSThread currentThread]);
        });
    });
    
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        dispatch_sync(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
            NSLog(@"44  %@",[NSThread currentThread]);
        });
    });
    
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        dispatch_sync(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
            NSLog(@"55  %@",[NSThread currentThread]);
        });
    });
}


- (void)test_SendNot {
    
    dispatch_queue_t queue = dispatch_queue_create("com.zhulei.youxin", DISPATCH_QUEUE_SERIAL);

    NSLog(@"开始-gcd");
    dispatch_sync(queue, ^{
        [[NSNotificationCenter defaultCenter] postNotificationName:@"HomeNotification" object:nil];
        NSLog(@"中-gcd ,%@",[NSThread currentThread]);
    });
    
    dispatch_sync(queue, ^{
        NSLog(@"中22-gcd ,%@",[NSThread currentThread]);
    });
    NSLog(@"结束-gcd");

}


- (void)test_5{
    
    int a = 10;
    dispatch_async(dispatch_get_main_queue(), ^{
        NSLog(@"%d",a);
    });
    a = 20;
    
    
}

@end
