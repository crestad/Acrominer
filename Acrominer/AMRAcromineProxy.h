//
//  AMRAcromineProxy.h
//  Acrominer
//
//  Created by Dave on 9/2/15.
//  Copyright (c) 2015 Dave. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef void(^ProxyRequestCompletionBlock)(NSArray *acronyms, NSError *error);

@interface AMRAcromineProxy : NSObject

- (void)requestDetailsForAcronym:(NSString *)acronym withCompletionBlock:(ProxyRequestCompletionBlock)completionBlock;


@end
