//
//  NSArray+AMRAcronyms.m
//  Acrominer
//
//  Created by Dave on 9/2/15.
//  Copyright (c) 2015 Dave. All rights reserved.
//

#import "NSArray+AMRAcronyms.h"
#import "NSDictionary+AMRAcronym.h"

@implementation NSArray (AMRAcronyms)

- (NSArray *)asAMRAcronyms {
    NSMutableArray *result = [NSMutableArray array];
    for (NSDictionary *dict in self) {
        [result addObject:[dict asAMRAcronym]];
    }
    return result;
}

@end
