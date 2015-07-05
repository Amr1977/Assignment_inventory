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
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
}

-(void) tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    NSLog(@"entered didSelectRowAtIndexPath: section: %ld , row: %ld",(long)indexPath.section, (long)indexPath.row );
    NSString * key= ([BDInventory.inventory.getResults allKeys])[indexPath.section];
    NSLog(@"selected key: %@",key);

    //UIStoryboard *mainStoryboard = [UIStoryboard storyboardWithName:@"Main"   bundle: nil];
    
  //  BDIProductDetailsViewController * detailsVC = (BDIProductDetailsViewController *) [mainStoryboard instantiateViewControllerWithIdentifier: @"details"];

    //[detailsVC setProduct:(BDInventory.inventory.getResults[key])[indexPath.row]];
    
    BDInventory.inventory.product = (BDInventory.inventory.getResults[key])[indexPath.row];
    NSLog(@"selected product: %@",BDInventory.inventory.product );
//    [[self navigationController] pushViewController:detailsVC animated:YES];
    //[self performSegueWithIdentifier:@"getDetails" sender: BDInventory.inventory.product  ];
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

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    // Return the number of rows in the section.
    NSArray * keys= [BDInventory.inventory.getResults allKeys];
    NSString * key=keys[section];
    NSLog(@"section: %ld , entries: %ld",section,[BDInventory.inventory.getResults[key] count] );
    return [BDInventory.inventory.getResults[key] count];
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
    return [[[BDInventory inventory] getResults] allKeys][section];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"productCell" forIndexPath:indexPath];
    
    // Configure the cell...
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:@"productCell"];
    }
    
    NSArray * keys= [BDInventory.inventory.getResults allKeys];
    NSString * key = keys[indexPath.section];
    
    BDIProduct * product= BDInventory.inventory.getResults[key][indexPath.row];
    
    cell.textLabel.text = [product name];
    
    cell.detailTextLabel.text = [product category];
    
    return cell;
}


/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath {
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/


#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    NSLog(@"entered prepareForSegue: segue id %@", [segue identifier]);
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
    //UIStoryboard *mainStoryboard = [UIStoryboard storyboardWithName:@"Main"   bundle: nil];
    
    //BDIProductDetailsViewController * detailsVC = (BDIProductDetailsViewController *) [mainStoryboard instantiateViewControllerWithIdentifier: @"details"];
    //[[self navigationController] pushViewController:detailsVC animated:YES];
}


@end
