//
//  BDITableViewController.m
//  BDRInventory
//
//  Created by Amr Lotfy on 6/29/15.
//  Copyright (c) 2015 Amr Lotfy. All rights reserved.
//

#import "BDIProductsTableViewController.h"

@interface BDIProductsTableViewController ()

@end

@implementation BDIProductsTableViewController


- (void)tableView:(UITableView *)tableView
    didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
  NSLog(@"entered didSelectRowAtIndexPath: section: %ld , row: %ld",
        (long)indexPath.section, (long)indexPath.row);
  NSString *key = ([self.results allKeys])[indexPath.section];
  NSLog(@"selected key: %@", key);

  self.product = (self.results[key])[indexPath.row];
  NSLog(@"selected product: %@", self.product);
}



#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
  // Return the number of sections.

  return ([self.results count]);
}

- (NSInteger)tableView:(UITableView *)tableView
 numberOfRowsInSection:(NSInteger)section {
  // Return the number of rows in the section.
  NSArray *keys = [self.results allKeys];
  NSString *key = keys[section];
  return [self.results[key] count];
}

- (NSString *)tableView:(UITableView *)tableView
titleForHeaderInSection:(NSInteger)section {
  return [self.results allKeys][section];
}

- (UITableViewCell *)tableView:(UITableView *)tableView
         cellForRowAtIndexPath:(NSIndexPath *)indexPath {
  UITableViewCell *cell =
      [tableView dequeueReusableCellWithIdentifier:@"productCell"
                                      forIndexPath:indexPath];

  // Configure the cell...
  if (cell == nil) {
    cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle
                                  reuseIdentifier:@"productCell"];
  }

  NSArray *keys = [self.results allKeys];
  NSString *key = keys[indexPath.section];

  BDIProduct *product = self.results[key][indexPath.row];

  cell.textLabel.text = [product name];

  cell.detailTextLabel.text = [product category];

  return cell;
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
  if ([segue.identifier isEqual:@"getDetails"]) {
    NSIndexPath *indexPath = [self.tableView indexPathForCell:sender];
    NSString *key = ([self.results allKeys])[indexPath.section];
    NSLog(@"selected key: %@", key);

    self.product = (self.results[key])[indexPath.row];
    NSLog(@"going to details controller ....");
    BDIProductDetailsViewController *detailsViewController =
        segue.destinationViewController;

    NSLog(@"table selected product: %@", self.product);
      detailsViewController.product = [self.product copy];

    NSLog(@"detailsViewController.product: %@", detailsViewController.product);

  } else {
    NSLog(@"not going to details controller ....");
  }
}

@end
