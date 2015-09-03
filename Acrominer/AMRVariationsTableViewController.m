//
//  AMRVariationsTableViewController.m
//  Acrominer
//
//  Created by Dave on 9/2/15.
//  Copyright (c) 2015 Dave. All rights reserved.
//

#import "AMRVariationsTableViewController.h"
#import "AMRLongFormTableViewCell.h"
#import "AMRVariation.h"

@interface AMRVariationsTableViewController ()

@end

@implementation AMRVariationsTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self.tableView registerNib:[UINib nibWithNibName:@"AMRLongFormTableViewCell" bundle:nil] forCellReuseIdentifier:LongFormCellReuseIdentifier];
    self.tableView.rowHeight = 64;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.variations.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    AMRLongFormTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:LongFormCellReuseIdentifier forIndexPath:indexPath];
    
    AMRVariation *variation = [self.variations objectAtIndex:indexPath.row];
    cell.nameLabel.text = variation.name;
    cell.sinceLabel.text = [NSString stringWithFormat:@"%ld", (long)variation.since];
    cell.frequencyLabel.text = [NSString stringWithFormat:@"%ld", (long)variation.frequency];
    cell.accessoryType = UITableViewCellAccessoryNone;
    
    return cell;
}

@end
