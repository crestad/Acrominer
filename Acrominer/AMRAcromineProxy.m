//
//  AMRAcromineProxy.m
//  Acrominer
//
//  Created by Dave on 9/2/15.
//  Copyright (c) 2015 Dave. All rights reserved.
//

#import "AMRAcromineProxy.h"
#import "AFNetworking.h"
#import "AFHTTPRequestOperation.h"
#import "NSArray+AMRAcronyms.h"

static const NSString *baseUrlString = @"http://www.nactem.ac.uk/software/acromine/dictionary.py?sf=";

@implementation AMRAcromineProxy

- (void)requestDetailsForAcronym:(NSString *)acronym withCompletionBlock:(ProxyRequestCompletionBlock)completionBlock {
    NSURL *url = [NSURL URLWithString:[baseUrlString stringByAppendingString:acronym]];
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    
    AFHTTPRequestOperation *operation = [[AFHTTPRequestOperation alloc] initWithRequest:request];
    operation.responseSerializer = [AFCompoundResponseSerializer serializer];
    
    [operation setCompletionBlockWithSuccess:^(AFHTTPRequestOperation *op, id response) {
        NSError *error = nil;
        id obj = [NSJSONSerialization JSONObjectWithData:response options:NSJSONReadingAllowFragments error:&error];
        if (error) {
            completionBlock(nil, error);
        } else {
            NSArray *result = [obj asAMRAcronyms];
            completionBlock(result, nil);
        }
    } failure:^(AFHTTPRequestOperation *op, NSError *error) {
        completionBlock(nil, error);
    }];
    [operation start];
}


@end

