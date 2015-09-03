//
//  AMRMessageDisplayViewController.m
//  Acrominer
//
//  Created by Dave on 9/2/15.
//  Copyright (c) 2015 Dave. All rights reserved.
//

#import "AMRMessageDisplayViewController.h"

@interface AMRMessageDisplayViewController ()

@property (weak, nonatomic) IBOutlet UILabel *messageLabel;

@end

@implementation AMRMessageDisplayViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    CALayer *layer = self.view.layer;
    [layer setMasksToBounds:YES];
    [layer setCornerRadius: 4.0];
    [layer setBorderWidth:1.0];
    [layer setBorderColor:[[UIColor colorWithWhite: 0.8 alpha: 1.0] CGColor]];
    
    self.messageLabel.text = self.message;
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    self.messageLabel.frame = self.messageRect;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

@end
