//
//  BDIMainViewController.m
//  BDRInventory
//
//  Created by Amr Lotfy on 7/2/15.
//  Copyright (c) 2015 Amr Lotfy. All rights reserved.
//

#import "BDIMainViewController.h"

@interface BDIMainViewController ()
@property(weak, nonatomic) IBOutlet UILabel *expireFilterState;

@end

@implementation BDIMainViewController

- (void)viewDidLoad {
  [super viewDidLoad];
}

- (void)didReceiveMemoryWarning {
  [super didReceiveMemoryWarning];
  // Dispose of any resources that can be recreated.
}

- (void)viewWillAppear:(BOOL)animated {
  [super viewWillAppear:animated];
  // do something
  NSDateFormatter *format = [[NSDateFormatter alloc] init];
  [format setDateFormat:@"dd/MMM/yyyy"];

  NSString *title = [[self navigationController] title];

  if ([title isEqualToString:@"Manufacturer"]) {
    [[BDInventory inventory] setGroupingMode:ManufacturersGrouping];
    NSLog(@"Grouping by: Manufacturers.");
  } else if ([title isEqualToString:@"Exporter"]) {
    [[BDInventory inventory] setGroupingMode:ExporterGrouping];
    NSLog(@"Grouping by: Exporter.");
  } else if ([title isEqualToString:@"Category"]) {
    [[BDInventory inventory] setGroupingMode:CategoryGrouping];
    NSLog(@"Grouping by: Category.");
  } else {
    [[BDInventory inventory] setGroupingMode:NoGroup];
    NSLog(@"No Grouping filter.");
  }

  UITabBarController *rootTabBarController = (UITabBarController
                                                  *)[[(AppDelegate *)[
      [UIApplication sharedApplication] delegate] window] rootViewController];

  NSUInteger selectedIndex = rootTabBarController.selectedIndex;
  NSLog(@"selected index: %lu", (unsigned long)selectedIndex);

  switch ([[BDInventory inventory] expireFilterMode]) {
    case BDIProductExpired:
      self.expireFilterState.text = @"Expired";
      break;

    case BDIProductNonExpired:
      self.expireFilterState.text = @"Not Expired";
      break;
    case BDIProductInRange:
      self.expireFilterState.text = [NSString
          stringWithFormat:
              @"[%@] : [%@]",
              [format stringFromDate:[[BDInventory inventory] startDate]],
              [format stringFromDate:[[BDInventory inventory] endDate]]];
      break;
  }

 // self.expireFilterMode = [[BDInventory inventory] expireFilterMode];
}

@end
