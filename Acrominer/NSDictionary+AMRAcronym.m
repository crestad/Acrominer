//
//  NSDictionary+AMRAcronym.m
//  Acrominer
//
//  Created by Dave on 9/2/15.
//  Copyright (c) 2015 Dave. All rights reserved.
//

#import "NSDictionary+AMRAcronym.h"
#import "AMRBaseLongForm.h"

@implementation NSDictionary (AMRAcronym)

- (AMRAcronym *)asAMRAcronym {
    AMRAcronym *result = [[AMRAcronym alloc] init];
    result.shortForm = self[@"sf"];
    NSMutableArray *longForms = [NSMutableArray array];
    result.longForms = longForms;
    for (NSDictionary *dict in self[@"lfs"]) {
        [longForms addObject:[dict asAMRLongForm]];
    }
    return result;
}

- (void)populateLongForm:(AMRBaseLongForm *)longForm {
    longForm.name = self[@"lf"];
    NSNumber *freq = self[@"freq"];
    longForm.frequency = [freq integerValue];
    NSNumber *since = self[@"since"];
    longForm.since = [since integerValue];
}

- (AMRLongForm *)asAMRLongForm {
    AMRLongForm *result = [[AMRLongForm alloc] init];
    [self populateLongForm:result];
    NSMutableArray *vars = [NSMutableArray array];
    result.variations = vars;
    for (NSDictionary *dict in self[@"vars"]) {
        [vars addObject:[dict asAMRVariation]];
    }
    return result;
}

- (AMRVariation *)asAMRVariation {
    AMRVariation *result = [[AMRVariation alloc] init];
    [self populateLongForm:result];
    return result;
}


@end
