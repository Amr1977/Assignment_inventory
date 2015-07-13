//
//  BDIMainViewController.m
//  BDRInventory
//
//  Created by Amr Lotfy on 7/2/15.
//  Copyright (c) 2015 Amr Lotfy. All rights reserved.
//

#import "BDIMainViewController.h"
#import "BDIExpireFilterViewController.h"

@interface BDIMainViewController ()
@property(weak, nonatomic) IBOutlet UILabel *expireFilterState;
@property(nonatomic) BDInventoryGropingMode groupingMode;
@property(nonatomic) BDIExpireFilterMode expireFilterMode;
@property(nonatomic) NSDate *startDate;
@property(nonatomic) NSDate *endDate;
@end

@implementation BDIMainViewController

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
  if ([segue.identifier isEqual:@"expireFilter"]) {
    BDIExpireFilterViewController *viewController =
        segue.destinationViewController;
    viewController.delegate = self;
    viewController.productFilter = [[BDIProductFilter alloc]
        initProductFilterWithGroupingMode:self.groupingMode
                         expireFilterMode:self.expireFilterMode
                                startDate:self.startDate
                                  enddate:self.endDate];

    // self.productFilter;
  } else if ([segue.identifier isEqualToString:@"getResults"]) {
    BDIProductsTableViewController *tableViewController =
        segue.destinationViewController;
    // feed table controller with needed data
    tableViewController.results =
        [[BDInventory inventory] getProductsByGrouping:self.groupingMode
                                          expireFilter:self.expireFilterMode
                                             startDate:self.startDate
                                               endDate:self.endDate];
  }
}

- (void)adjustView {
  NSDateFormatter *format = [[NSDateFormatter alloc] init];
  [format setDateFormat:@"dd/MMM/yyyy"];
  NSLog(@"adjustView: expireFilterMode: %u", self.expireFilterMode);

  switch (self.expireFilterMode) {
    case BDIProductExpired:
      self.expireFilterState.text = @"Expired";
      break;

    case BDIProductNonExpired:
      self.expireFilterState.text = @"Not Expired";
      break;

    case BDIProductInRange:
      self.expireFilterState.text =
          [NSString stringWithFormat:@"[%@] : [%@]",
                                     [format stringFromDate:self.startDate],
                                     [format stringFromDate:self.endDate]];
      break;
  }
}

- (void)viewWillAppear:(BOOL)animated {
  [super viewWillAppear:animated];
  [self adjustView];
}

#pragma delegate methods

- (void)expireFilterViewController:
            (BDIExpireFilterViewController *)viewController
               didChooseFilterType:(BDIExpireFilterMode)expireFilterMode
                         startDate:(NSDate *)startDate
                           endDate:(NSDate *)endDate {
  if (!self.productFilter) {
    NSLog(@">>>>>>>>>>>>>>>>>>self.productFilter was nill !!! "
          @"<<<<<<<<<<<<<<<<<<<<");
    self.productFilter = [BDIProductFilter new];
    self.productFilter.groupingMode = self.groupingMode;
  }
  NSLog(@"called delegate method..");
  self.expireFilterMode = expireFilterMode;
  NSLog(@"expireFilterMode: %u, self.expireFilterMode: %u", expireFilterMode,
        self.expireFilterMode);
  self.productFilter.expireFilterMode = expireFilterMode;
  NSLog(@"expireFilterMode: %u, self.productFilter.expireFilterMode: %u",
        expireFilterMode, self.productFilter.expireFilterMode);
  self.startDate = startDate;
  self.endDate = endDate;
  [self adjustView];
  [self.navigationController popViewControllerAnimated:YES];
}

- (void)expireFilterViewControllerDidCancel:
    (BDIExpireFilterViewController *)viewController {
  [self.navigationController popViewControllerAnimated:YES];
}

@end
