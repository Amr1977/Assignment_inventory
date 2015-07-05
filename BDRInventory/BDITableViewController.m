//
//  BDITableViewController.m
//  BDRInventory
//
//  Created by Amr Lotfy on 6/29/15.
//  Copyright (c) 2015 Amr Lotfy. All rights reserved.
//

#import "BDITableViewController.h"

@interface BDITableViewController ()

@end

@implementation BDITableViewController

- (void)viewDidLoad {
  [super viewDidLoad];

  // Uncomment the following line to preserve selection between presentations.
  // self.clearsSelectionOnViewWillAppear = NO;

  // Uncomment the following line to display an Edit button in the navigation
  // bar for this view controller.
  // self.navigationItem.rightBarButtonItem = self.editButtonItem;
    self.navigationItem.rightBarButtonItem = nil;
    
}

- (void)tableView:(UITableView *)tableView
    didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
  NSLog(@"entered didSelectRowAtIndexPath: section: %ld , row: %ld",
        (long)indexPath.section, (long)indexPath.row);
  NSString *key =
      ([BDInventory.inventory.getResults allKeys])[indexPath.section];
  NSLog(@"selected key: %@", key);

  BDInventory.inventory.product =
      (BDInventory.inventory.getResults[key])[indexPath.row];
  NSLog(@"selected product: %@", BDInventory.inventory.product);
}

- (void)didReceiveMemoryWarning {
  [super didReceiveMemoryWarning];
  // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
  // Return the number of sections.

  return ([BDInventory.inventory.getResults count]);
}

- (NSInteger)tableView:(UITableView *)tableView
 numberOfRowsInSection:(NSInteger)section {
  // Return the number of rows in the section.
  NSArray *keys = [BDInventory.inventory.getResults allKeys];
  NSString *key = keys[section];
  return [BDInventory.inventory.getResults[key] count];
}

- (NSString *)tableView:(UITableView *)tableView
titleForHeaderInSection:(NSInteger)section {
  return [[[BDInventory inventory] getResults] allKeys][section];
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

  NSArray *keys = [BDInventory.inventory.getResults allKeys];
  NSString *key = keys[indexPath.section];

  BDIProduct *product = BDInventory.inventory.getResults[key][indexPath.row];

  cell.textLabel.text = [product name];

  cell.detailTextLabel.text = [product category];

  return cell;
}

@end
