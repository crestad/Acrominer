//
//  NSDictionary+AMRAcronym.h
//  Acrominer
//
//  Created by Dave on 9/2/15.
//  Copyright (c) 2015 Dave. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "AMRAcronym.h"
#import "AMRLongForm.h"
#import "AMRVariation.h"

@interface NSDictionary (AMRAcronym)

- (AMRAcronym *)asAMRAcronym;
- (AMRLongForm *)asAMRLongForm;
- (AMRVariation *)asAMRVariation;

@end
