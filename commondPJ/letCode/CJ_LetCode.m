//
//  CJ_LetCode.m
//  commondPJ
//
//  Created by zhulei on 2019/3/5.
//  Copyright © 2019 zhulei. All rights reserved.
//

#import "CJ_LetCode.h"

@implementation CJ_LetCode


+ (NSInteger)binarySearchArray:(NSArray *)array result:(NSInteger)num{
    
    NSInteger low = 0;
    NSInteger heigh = array.count-1;
    while (low <= heigh) {
        NSInteger mid = (low + heigh) /2;
        NSInteger data =  [array[mid] integerValue];
        if (data == num) {
            return mid;
        }
        if (data > num) {
            heigh = mid - 1;
        }else{
            low = mid + 1;
        }
    }
    
    return -1;
}

+ (NSArray *)quickSort:(NSArray *)listArray {
    if (listArray.count < 2) {
       
        NSLog(@"listArray = %@",listArray);

        return listArray;
    }else{
        NSMutableArray *lessArray = [[NSMutableArray alloc]initWithCapacity:9];
        NSMutableArray *greaterArray = [[NSMutableArray alloc]initWithCapacity:9];
        NSInteger current =[listArray[0] integerValue];
        for (NSInteger i = 1; i<listArray.count; i++) {
            if ([listArray[i] integerValue] <= current) {
                [lessArray addObject:listArray[i]];
            }else{
                [greaterArray addObject:listArray[i]];
            }
        }
        
        NSMutableArray *lastArray = [[NSMutableArray alloc]initWithCapacity:9];
        
        [lastArray addObjectsFromArray:[self quickSort:lessArray]];
        [lastArray addObject:listArray[0]];
        [lastArray addObjectsFromArray:[self quickSort:greaterArray]];
        
//        NSLog(@"lastArray = %@",lastArray);
        return lastArray;
        }
    
}



@end
