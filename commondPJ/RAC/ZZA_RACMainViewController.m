//
//  ZZA_RACMainViewController.m
//  commondPJ
//
//  Created by zhulei on 2018/7/16.
//  Copyright © 2018 zhulei. All rights reserved.
//

#import "ZZA_RACMainViewController.h"
@interface ZZA_RACMainViewController ()

@end

@implementation ZZA_RACMainViewController

- (UIStatusBarStyle)preferredStatusBarStyle{
    return UIStatusBarStyleLightContent;
}



- (BOOL)prefersStatusBarHidden{
    return NO;
}


- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    
//    [self coldSribeSignal];
//    [self hotScribeSignal];
//    [self sequenceCase];
//    [self hotOrColdCase];
//    [self subjectDealloc];
//    [self signalSelect];
//    [self commondCase];
//    [self countSignalNewStyle];
//    [self mappingCase];
//    [self filteringCase];
//    [self concatenatingCase];
//    [self flatteningCase];
    [self mappingAndFlatteningCase];
    [self sequencingCase];
//    [self mergingCase];
//    [self combininglatestCase];
//    [self switchingCase];
}
-(void)coldSribeSignal{
    RACSignal *signal = [RACSignal createSignal:^RACDisposable * _Nullable(id<RACSubscriber>  _Nonnull subscriber) {
        
        NSLog(@"请求数据");
        [subscriber sendNext:@"1"];
        [subscriber sendNext:@"2"];
        [subscriber sendCompleted];
        return nil;
        
    }];

    [[RACScheduler mainThreadScheduler] afterDelay:0.1 schedule:^{
        [signal subscribeNext:^(id  _Nullable x) {
            NSLog(@"signal -----%@",x);
        }];

    }];

    [[RACScheduler mainThreadScheduler] afterDelay:1 schedule:^{
        [signal subscribeNext:^(id  _Nullable x) {
            NSLog(@"signal -----%@",x);
        }];
    }];

   
    
    RACMulticastConnection *connection = [signal multicast:[RACReplaySubject subject] ];
    [connection connect];
    [connection.signal subscribeNext:^(id  _Nullable x) {
        NSLog(@"connect sub11 %@",x);
    }];
    [connection.signal subscribeNext:^(id  _Nullable x) {
        NSLog(@"connect sub22 %@",x);
    }];

    
    RACMulticastConnection *otherCon = [signal publish];
    [otherCon.signal subscribeNext:^(id  _Nullable x) {
        NSLog(@"other connect %@",x);
    }];
    [otherCon.signal subscribeNext:^(id  _Nullable x) {
        NSLog(@"other connect2 %@",x);
    }];
    [otherCon connect];
    
    
 
}

-(void)hotScribeSignal{
    
//    RACSubject *subject = [RACSubject subject];
    RACBehaviorSubject *subject = [RACBehaviorSubject subject]; //发送上次的消息
    
//    RACReplaySubject *subject = [RACReplaySubject subject];
   
    [[RACScheduler mainThreadScheduler]afterDelay:1 schedule:^{
        [subject sendNext:@"1"];
    }];
    [[RACScheduler mainThreadScheduler]afterDelay:2 schedule:^{
        [subject sendNext:@"2"];
    }];
    [[RACScheduler mainThreadScheduler]afterDelay:3 schedule:^{
        [subject sendNext:@"3"];
    }];
    
    [[RACScheduler mainThreadScheduler]afterDelay:1.1 schedule:^{
        [subject subscribeNext:^(id  _Nullable x) {
            NSLog(@"1st Sub : %@",x);
        }];
    }];
    
    [[RACScheduler mainThreadScheduler]afterDelay:2.1 schedule:^{
        [subject subscribeNext:^(id  _Nullable x) {
            NSLog(@"2st Sub : %@",x);
        }];
    }];
    
    [[RACScheduler mainThreadScheduler]afterDelay:3.1 schedule:^{
        [subject subscribeNext:^(id  _Nullable x) {
            NSLog(@"3st Sub : %@",x);
        }];
    }];
    
    [subject sendCompleted];
    
}

-(void)subjectDealloc{
    RACReplaySubject *subject = [RACReplaySubject subject];

    [subject.rac_willDeallocSignal subscribeCompleted:^{
        NSLog(@"subject dealloc");
    }];
    
    [[subject map:^id _Nullable(id  _Nullable value) {
        return @([value integerValue] * 3);
    }] subscribeNext:^(id  _Nullable x) {
        NSLog(@"next = %@",x);
    }];
    
//    [subject subscribeNext:^(id  _Nullable x) {
//        NSLog(@"next = %@",x);
//    }];
    [subject sendNext:@"1"];
    [subject sendNext:@"3"];
}

-(void)sequenceCase{
    NSArray *strings = @[ @"A", @"B", @"C" ];
    RACSequence *sequence = [strings.rac_sequence map:^(NSString *str) {
        NSLog(@"%@", str);
        return [str stringByAppendingString:@"_"];
    }];
    NSString *concatA = sequence.head;
    NSString *concatB = sequence.tail.head;
    NSString *concatB2 = sequence.tail.head;
    
    RACSequence *derivedSequence = [sequence map:^(NSString *str) {
        return [@"_" stringByAppendingString:str];
    }];
    
    NSString *concatB3 = derivedSequence.tail.head;

    NSLog(@"concatA = %@",concatA);
    NSLog(@"concatB = %@",concatB);
    NSLog(@"concatB2 = %@",concatB2);
    NSLog(@"concatB3 = %@",concatB3);

}

- (void)signalSelect{
    // 1.代替代理
    // 需求：自定义redView,监听红色view中按钮点击
// 之前都是需要通过代理监听，给红色View添加一个代理属性，点击按钮的时候，通知代理做事情
// rac_signalForSelector:把调用某个对象的方法的信息转换成信号，就要调用这个方法，就会发送信号。
// 这里表示只要redV调用btnClick:,就会发出信号，订阅就好了。
    UIView *redV = [[UIView alloc]initWithFrame:CGRectMake(100, 100, 200, 200)];
    redV.backgroundColor = [UIColor redColor];
    [self.view addSubview:redV];
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    btn.frame = CGRectMake(10, 10, 50, 50);
    btn.backgroundColor = [UIColor greenColor];
    [btn addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchUpInside];
    [redV addSubview:btn];
    
    [[self rac_signalForSelector:@selector(btnClick:)] subscribeNext:^(id x) {
        NSLog(@"点击红色按钮");
    }];
    
    
}

- (void)btnClick:(UIButton *)sender{
    NSLog(@"按钮");
}

- (void)commondCase{
    RACCommand *command = [[RACCommand alloc]initWithSignalBlock:^RACSignal * _Nonnull(NSNumber *  _Nullable input) {
        return [RACSignal createSignal:^RACDisposable *
                _Nullable(id<RACSubscriber>  _Nonnull subscriber) {
                    NSInteger integer = [input integerValue];
                    for (NSInteger i = 0; i<integer; i++) {
                        [subscriber sendNext:@(i)];
                    }
                    [subscriber sendCompleted];
                    return nil;
        }];
    }];
    
    [[command.executionSignals switchToLatest]subscribeNext:^(id  _Nullable x) {
        NSLog(@"----%@",x);
    }];
    
    [command execute:@1];
    
    [RACScheduler.mainThreadScheduler afterDelay:1 schedule:^{
        [command execute:@2];
    }];

    [RACScheduler.mainThreadScheduler afterDelay:2 schedule:^{
        [command execute:@3];
    }];
    
}


- (void)countSignalNewStyle{
    RACSignal *signal =
    [[[[[[RACSignal return:@1]
         repeat] take: 100]
       scanWithStart:@0 reduce:^id(NSNumber *running,
                                   NSNumber *next) {
           return @(running.integerValue + next.integerValue);
       }]
      map:^id(NSNumber *value) {
          return [[RACSignal return:value]
                  delay:1];
      }]
     concat];
    
    [signal subscribeNext:^(id  _Nullable x) {
        NSLog(@"%@",x);
    }];
}


//
- (void)mappingCase{
    RACSequence *letters = [@"A B C D E F G H I" componentsSeparatedByString:@" "].rac_sequence;
    
    // Contains: AA BB CC DD EE FF GG HH II
    RACSequence *mapped = [letters map:^(NSString *value) {
        return [value stringByAppendingString:value];
    }];
    
    [mapped.signal subscribeNext:^(NSString *letter) {
        NSLog(@"%@",letter);
    }];
}

//过滤
- (void)filteringCase{
    RACSequence *numbers = [@"1 2 3 4 5 6 7 8 9" componentsSeparatedByString:@" "].rac_sequence;
    
    // Contains: 2 4 6 8
    RACSequence *filtered = [numbers filter:^ BOOL (NSString *value) {
        return (value.intValue % 2) == 0;
    }];
    
    [filtered.signal subscribeNext:^(id  _Nullable x) {
        NSLog(@"%@",x);
    }];
}

- (void)concatenatingCase{
//    RACSequence *letters = [@"A B C D E F G H I" componentsSeparatedByString:@" "].rac_sequence;
//    RACSequence *numbers = [@"1 2 3 4 5 6 7 8 9" componentsSeparatedByString:@" "].rac_sequence;
//
//    // Contains: A B C D E F G H I 1 2 3 4 5 6 7 8 9
//    RACSequence *concatenated = [letters concat:numbers];
//
//    [concatenated.signal subscribeNext:^(id  _Nullable x) {
//        NSLog(@"%@",x);
//    }];
    
    //网络请求a b ，a返回处理a， b返回处理b
    
    //组合:信号的组合
    
    RACSignal *signalA = [RACSignal createSignal:^RACDisposable * _Nullable(id<RACSubscriber>  _Nonnull subscriber) {
        
        [subscriber sendNext:@"数据A"];
        
        //告诉A发送完毕，组合信号才走下面的信号
        [subscriber sendCompleted];
        
        //[subscriber sendNext:nil];  error不可以。a完整结束，才会走b
        
        return nil;
    }];
    
    RACSignal *signalB = [RACSignal createSignal:^RACDisposable * _Nullable(id<RACSubscriber>  _Nonnull subscriber) {
        
        [subscriber sendNext:@"数据B"];
        [subscriber sendCompleted];
        
        return nil;
    }];
    
    RACSignal *signalC = [RACSignal createSignal:^RACDisposable * _Nullable(id<RACSubscriber>  _Nonnull subscriber) {
        
        [subscriber sendNext:@"数据C"];
        [subscriber sendCompleted];
        
        return nil;
    }];
    
    //创建组合信号 concat，按顺序组合
    //按照A C B 顺序执行
    
    //    RACSignal *concatSignal =  [[signalA concat:signalB] concat:signalC];
    RACSignal *concatSignal =  [RACSignal concat:@[signalA,signalC,signalB] ];
    
    
    //订阅组合信号
    [concatSignal subscribeNext:^(id  _Nullable x) {
        
        NSLog(@"%@",x);
    }];
}

- (void)flatteningCase{
//    RACSequence *letters = [@"A B C D E F G H I" componentsSeparatedByString:@" "].rac_sequence;
//    RACSequence *numbers = [@"1 2 3 4 5 6 7 8 9" componentsSeparatedByString:@" "].rac_sequence;
//    RACSequence *sequenceOfSequences = @[ letters, numbers ].rac_sequence;
//
//    // Contains: A B C D E F G H I 1 2 3 4 5 6 7 8 9
//    RACSequence *flattened = [sequenceOfSequences flatten];
//    [flattened.signal subscribeNext:^(id  _Nullable x) {
//        NSLog(@"%@",x);
//    }];
    
    RACSubject *letters = [RACSubject subject];
    RACSubject *numbers = [RACSubject subject];
    RACSignal *signalOfSignals = [RACSignal createSignal:^ RACDisposable * (id<RACSubscriber> subscriber) {
        [subscriber sendNext:letters];
        [subscriber sendNext:numbers];
        [subscriber sendCompleted];
        return nil;
    }];
    
    RACSignal *flattened = [signalOfSignals flatten];
    
    // Outputs: A 1 B C 2
    [flattened subscribeNext:^(NSString *x) {
        NSLog(@"%@", x);
    }];
    
    [letters sendNext:@"A"];
    [numbers sendNext:@"1"];
    [letters sendNext:@"B"];
    [letters sendNext:@"C"];
    [numbers sendNext:@"2"];
    

}

/*
 -flattenMap: is used to transform each of a stream's values into a new stream. Then, all of the streams returned will be flattened down into a single stream. In other words, it's -map: followed by -flatten.
 */
- (void)mappingAndFlatteningCase{
//    RACSequence *numbers = [@"1 2 3 4 5 6 7 8 9" componentsSeparatedByString:@" "].rac_sequence;
//
//    // Contains: 1 1 2 2 3 3 4 4 5 5 6 6 7 7 8 8 9 9
//    RACSequence *extended = [numbers flattenMap:^(NSString *num) {
//        return @[ num, num ].rac_sequence;
//    }];
//
//    // Contains: 1_ 3_ 5_ 7_ 9_
//    RACSequence *edited = [numbers flattenMap:^(NSString *num) {
//        if (num.intValue % 2 == 0) {
//            return [RACSequence empty];
//        } else {
//            NSString *newNum = [num stringByAppendingString:@"_"];
//            return [RACSequence return:newNum];
//        }
//    }];
//
//    [extended.signal subscribeNext:^(id  _Nullable x) {
//        NSLog(@"%@",x);
//    }];
//    [edited.signal subscribeNext:^(id  _Nullable x) {
//        NSLog(@"%@",x);
//    }];
    
    RACSignal *letters = [@"A B C D E F G H I" componentsSeparatedByString:@" "].rac_sequence.signal;

    [[letters
      flattenMap:^(NSString *letter) {
          NSString *value = [NSString stringWithFormat:@"处理：%@",letter];
          return [RACSignal return:value];
      }]subscribeNext:^(id  _Nullable x) {
          NSLog(@"%@",x);
      } completed:^{
          NSLog(@"All database entries saved successfully.");
      }];
    

}

- (void)sequencingCase{
//    RACSignal *letters = [@"A B C D E F G H I" componentsSeparatedByString:@" "].rac_sequence.signal;

    // The new signal only contains: 1 2 3 4 5 6 7 8 9
    //
    // But when subscribed to, it also outputs: A B C D E F G H I
//    RACSignal *sequenced = [[letters
//                             doNext:^(NSString *letter) {
//                                 NSLog(@"%@", letter);
//                             }]
//                            then:^{
//                                return [@"1 2 3 4 5 6 7 8 9" componentsSeparatedByString:@" "].rac_sequence.signal;
//                            }];
//    [sequenced subscribeNext:^(id  _Nullable x) {
//        NSLog(@"---%@",x);
//    }];
    
//    RACSignal *sequenced11 = [letters then:^RACSignal * _Nonnull{
//        return [@"1 2 3 4 5 6 7 8 9" componentsSeparatedByString:@" "].rac_sequence.signal;
//    }];
//    [sequenced11 subscribeNext:^(id  _Nullable x) {
//        NSLog(@"11---%@",x);
//    }];
//
    
    RACSignal *signalA = [RACSignal createSignal:^RACDisposable * _Nullable(id<RACSubscriber>  _Nonnull subscriber) {

        [subscriber sendNext:@"数据A"];
        [subscriber sendCompleted];

        return nil;
    }];

    RACSignal *signalB = [RACSignal createSignal:^RACDisposable * _Nullable(id<RACSubscriber>  _Nonnull subscriber) {

        [subscriber sendNext:@"数据B"];
        [subscriber sendCompleted];

        return nil;
    }];

    //忽略前面的信号，a信号数据发送完毕，忽略完毕，接收b的数据。
    //b的信号依赖a发送完毕。对于a的结果不关心，直接忽略掉！
    RACSignal *signal = [signalA then:^RACSignal * _Nonnull{

        return signalB;
    }];

    [signal subscribeNext:^(id  _Nullable x) {

        NSLog(@"~~~~~~%@",x);
    }];
}

- (void)mergingCase{
    RACSubject *letters = [RACSubject subject];
    RACSubject *numbers = [RACSubject subject];
    RACSignal *merged = [RACSignal merge:@[ letters, numbers ]];
    
    // Outputs: A 1 B C 2
    [merged subscribeNext:^(NSString *x) {
        NSLog(@"%@", x);
    }];
    
    [letters sendNext:@"A"];
    [numbers sendNext:@"1"];
    [letters sendNext:@"B"];
    [letters sendNext:@"C"];
    [numbers sendNext:@"2"];
}

- (void)combininglatestCase{
    RACSubject *letters = [RACSubject subject];
    RACSubject *numbers = [RACSubject subject];
    RACSignal *combined = [RACSignal
                           combineLatest:@[ letters, numbers ]
                           reduce:^(NSString *letter, NSString *number) {
                               return [letter stringByAppendingString:number];
                           }];
    
    // Outputs: B1 B2 C2 C3 D3 D4
    [combined subscribeNext:^(id x) {
        NSLog(@"%@", x);
    }];
    
    [letters sendNext:@"A"];
    [letters sendNext:@"B"];
    [numbers sendNext:@"1"];
    [numbers sendNext:@"2"];
    [letters sendNext:@"C"];
    [numbers sendNext:@"3"];
    [letters sendNext:@"D"];
    [numbers sendNext:@"4"];
    
    
    /**
     | letter |-  A  -  B  -  -   -   C  -    -   D
     | number |-  -  - -  1  -   2    -   3   -   -    4
     | new   |-  -  -  -  B1 -  B2 - C2 -  C3 -  D3 D4
     -------------- time ----------------------->
     可以发现letter信号的A值被更新的B值覆盖了,所以接下来接收到number信号的1时候,合并,输出信号B1.
     当接收到C的时候,与number的最新的值2合并,输出信号C2.
     */
    
}

- (void)switchingCase{
    RACSubject *letters = [RACSubject subject];
    RACSubject *numbers = [RACSubject subject];
    RACSubject *signalOfSignals = [RACSubject subject];
    
    RACSignal *switched = [signalOfSignals switchToLatest];
    
    // Outputs: A B 1 D
    [switched subscribeNext:^(NSString *x) {
        NSLog(@"%@", x);
    }];
    
    [signalOfSignals sendNext:letters];
    
    [letters sendNext:@"A"];
    [letters sendNext:@"B"];
    
    [signalOfSignals sendNext:numbers];
    [letters sendNext:@"C"];
    [numbers sendNext:@"1"];
    
    [signalOfSignals sendNext:letters];
    [numbers sendNext:@"2"];
    [letters sendNext:@"D"];
    

}

@end
