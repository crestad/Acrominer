//
//  AMRLongFormTableViewCell.h
//  Acrominer
//
//  Created by Dave on 9/2/15.
//  Copyright (c) 2015 Dave. All rights reserved.
//

#import <UIKit/UIKit.h>

static NSString *LongFormCellReuseIdentifier = @"LongFormCell";

@interface AMRLongFormTableViewCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
@property (weak, nonatomic) IBOutlet UILabel *sinceLabel;
@property (weak, nonatomic) IBOutlet UILabel *frequencyLabel;

@end
