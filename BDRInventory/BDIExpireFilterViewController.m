//
//  BDIExpireFilterViewController.m
//  BDRInventory
//
//  Created by Amr Lotfy on 7/2/15.
//  Copyright (c) 2015 Amr Lotfy. All rights reserved.
//

#import "BDIExpireFilterViewController.h"

@interface BDIExpireFilterViewController ()
@property(weak, nonatomic)
    IBOutlet UISegmentedControl *filterModeSegmentControl;

@property(weak, nonatomic) IBOutlet UIDatePicker *startDate;
@property(weak, nonatomic) IBOutlet UIDatePicker *endDate;

@property(weak, nonatomic) IBOutlet UILabel *fromLabel;
@property(weak, nonatomic) IBOutlet UILabel *toLabel;

@end

@implementation BDIExpireFilterViewController
- (IBAction)handleCancelAction:(id)sender {
  [self.delegate expireFilterViewControllerDidCancel:self];
}

- (IBAction)handleDoneAction:(id)sender {
  [self validateFilter];
  [self.delegate expireFilterViewController:self
                        didChooseFilterType:self.productFilter.expireFilterMode
                                  startDate:self.productFilter.startDate
                                    endDate:self.productFilter.endDate];
}

- (IBAction)expireFilterChangeAction:(id)sender {
  if ([self.filterModeSegmentControl selectedSegmentIndex] == 2) {
    [self.startDate setHidden:NO];
    [self.endDate setHidden:NO];
    [self.fromLabel setHidden:NO];
    [self.toLabel setHidden:NO];

  } else {
    [self.startDate setHidden:YES];
    [self.endDate setHidden:YES];
    [self.fromLabel setHidden:YES];
    [self.toLabel setHidden:YES];
  }
}

- (void)validateFilter {
  switch ([self.filterModeSegmentControl selectedSegmentIndex]) {
    case 0:
      NSLog(@"BDIProductExpired.");
      self.productFilter.expireFilterMode = BDIProductExpired;
      break;
    case 1:
      NSLog(@"BDIProductNonExpired. %u", BDIProductNonExpired);
      self.productFilter.expireFilterMode = BDIProductNonExpired;
      break;
    case 2:
      NSLog(@"BDIProductInRange.");
      self.productFilter.expireFilterMode = BDIProductInRange;
      self.productFilter.startDate = self.startDate.date;
      self.productFilter.endDate = self.endDate.date;
  }
}

- (void)viewDidLoad {
  [super viewDidLoad];
  // Do any additional setup after loading the view.
  UIBarButtonItem *rightButton =
      [[UIBarButtonItem alloc] initWithTitle:@"Done"
                                       style:UIBarButtonItemStyleDone
                                      target:self
                                      action:@selector(doneTabbed)];
  self.navigationItem.rightBarButtonItem = rightButton;

  switch (self.productFilter.expireFilterMode) {
    case BDIProductExpired:
      [self.filterModeSegmentControl setSelectedSegmentIndex:0];
      break;
    case BDIProductNonExpired:
      [self.filterModeSegmentControl setSelectedSegmentIndex:1];
      break;
    case BDIProductInRange:
      [self.filterModeSegmentControl setSelectedSegmentIndex:2];
      [self.startDate setDate:self.productFilter.startDate];
      [self.endDate setDate:self.productFilter.endDate];
      break;
  }

  //    [self.filterMode setSelectedSegmentIndex: self.storedFilterMode];
  //    if (self.storedStartDate) {
  //        [self.startDate setDate:self.storedStartDate];
  //        [self.endDate setDate:self.storedEndDate];
  //    }

  [self expireFilterChangeAction:nil];
}

- (void)doneTabbed {
  NSLog(@"done tabbed...");
  [self validateFilter];
  NSLog(@"filter mode: %u, start date: %@, end date: %@",
        self.productFilter.expireFilterMode, self.productFilter.startDate,
        self.productFilter.endDate);

  [self.delegate expireFilterViewController:self
                        didChooseFilterType:self.productFilter.expireFilterMode
                                  startDate:self.productFilter.startDate
                                    endDate:self.productFilter.endDate];
}

@end
