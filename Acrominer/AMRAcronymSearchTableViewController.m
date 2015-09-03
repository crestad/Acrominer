//
//  AMRAcronymSearchTableViewController.m
//  Acrominer
//
//  Created by Dave on 9/2/15.
//  Copyright (c) 2015 Dave. All rights reserved.
//

#import "AMRAcronymSearchTableViewController.h"
#import "MBProgressHUD.h"
#import "AMRAcromineProxy.h"
#import "AMRAcronym.h"
#import "AMRLongForm.h"
#import "AMRVariation.h"
#import "AMRLongFormTableViewCell.h"
#import "AMRVariationsTableViewController.h"
#import "AMRPrimaryViewController.h"

@interface AMRAcronymSearchTableViewController ()
{
    NSMutableArray *longForms;
}

@property (weak, nonatomic) IBOutlet UISearchBar *searchBar;

@end

@implementation AMRAcronymSearchTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    longForms = [NSMutableArray array];
    [self.tableView registerNib:[UINib nibWithNibName:@"AMRLongFormTableViewCell" bundle:nil] forCellReuseIdentifier:LongFormCellReuseIdentifier];
    self.tableView.rowHeight = 64;
    self.searchBar.delegate = self;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

- (void)dealloc {
    self.searchBar.delegate = nil;
}

- (void)searchForAcronym:(NSString *)acronym {
    [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    AMRAcromineProxy *proxy = [[AMRAcromineProxy alloc] init];
    [proxy requestDetailsForAcronym:acronym withCompletionBlock:^(NSArray *acronyms, NSError *error) {
        [longForms removeAllObjects];
        if (error) {
            [[NSNotificationCenter defaultCenter] postNotificationName:AMRMessageDisplayNotification object:error.localizedDescription];
            NSLog(@"Error: %@", error.localizedDescription);
        } else {
            for (AMRAcronym *acronym in acronyms) {
                for (AMRLongForm *longForm in acronym.longForms) {
                    [longForms addObject:longForm];
                }
            }
            if (longForms.count == 0) {
                [[NSNotificationCenter defaultCenter] postNotificationName:AMRMessageDisplayNotification object:@"No results found"];
            }
        }
        [self.tableView reloadData];
        [MBProgressHUD hideHUDForView:self.view animated:YES];
    }];
}


#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return longForms.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    AMRLongFormTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:LongFormCellReuseIdentifier forIndexPath:indexPath];
    
    AMRLongForm *longForm = [longForms objectAtIndex:indexPath.row];
    cell.nameLabel.text = longForm.name;
    cell.sinceLabel.text = [NSString stringWithFormat:@"%ld", (long)longForm.since];
    cell.frequencyLabel.text = [NSString stringWithFormat:@"%ld", (long)longForm.frequency];
    if (longForm.variations.count == 0) {
        cell.accessoryType = UITableViewCellAccessoryNone;
    } else {
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    }
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
    if (cell.accessoryType != UITableViewCellAccessoryNone) {
        [self performSegueWithIdentifier:@"displayVariations" sender:self];
    }
}


#pragma mark - Navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if ([segue.identifier isEqualToString:@"displayVariations"]) {
        AMRVariationsTableViewController *destinationController = [segue destinationViewController];
        NSIndexPath *indexPath = [self.tableView indexPathForSelectedRow];
        AMRLongForm *longForm = [longForms objectAtIndex:indexPath.row];
        destinationController.variations = longForm.variations;
        destinationController.title = [NSString stringWithFormat:@"Variations for %@", longForm.name];
    }
}


#pragma mark - UISearchBarDelegate methods

- (void)searchBar:(UISearchBar *)searchBar textDidChange:(NSString *)searchText {
    if ([searchText isEqualToString:@""]) {
        [longForms removeAllObjects];
        [self.tableView reloadData];
    }         
}

- (void)searchBarSearchButtonClicked:(UISearchBar *)searchBar {
    [searchBar resignFirstResponder];
    [self searchForAcronym:searchBar.text];
}

@end
