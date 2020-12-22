//
//  Person.h
//  commondPJ
//
//  Created by zhulei on 2018/11/19.
//  Copyright © 2018 zhulei. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN


@interface Person : NSObject

typedef Person * _Nullable (^AddBlock)(NSInteger num);

@property (nonatomic, assign) NSInteger uid;
@property (nonatomic, strong) NSString *name;
@property (nonatomic, assign) NSInteger result;

//@property (nonatomic, copy) AddBlock add;
//@property (nonatomic, copy) Person*  (^minus)(NSInteger num);



- (instancetype)initWithID:(NSInteger)uid name:(NSString *)name;

- (Person * (^)(NSInteger))minus;
- (AddBlock)add;

@end

NS_ASSUME_NONNULL_END
