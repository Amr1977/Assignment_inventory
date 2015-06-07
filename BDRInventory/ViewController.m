//
//  ViewController.m
//  BDRInventory
//
//  Created by Amr Lotfy on 6/3/15.
//  Copyright (c) 2015 Amr Lotfy. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()
@property(nonatomic) BDInventory *inventoryModel;
@property(nonatomic) NSDictionary *lastResult;
@property(weak, nonatomic) IBOutlet UISegmentedControl *grouping;
@property(weak, nonatomic) IBOutlet UISegmentedControl *expireFilters;
@property(weak, nonatomic) IBOutlet UIDatePicker *startDatePicker;
@property(weak, nonatomic) IBOutlet UIDatePicker *endDatePicker;
@property(weak, nonatomic) IBOutlet UILabel *startDateLabel;
@property(weak, nonatomic) IBOutlet UILabel *endDatelabel;

@property(nonatomic) NSString *groupingMethod;

@end

@implementation ViewController

- (IBAction)expirySelection:(id)sender {
  if ([[self expireFilters] selectedSegmentIndex] == 2) {
    [[self startDatePicker] setHidden:false];
    [[self endDatePicker] setHidden:false];
    [[self startDateLabel] setHidden:false];
    [[self endDatelabel] setHidden:false];

  } else {
    [[self startDatePicker] setHidden:true];
    [[self endDatePicker] setHidden:true];
    [[self startDateLabel] setHidden:true];
    [[self endDatelabel] setHidden:true];
  }
}

- (void)applyFilters {
  NSInteger groupingIndex = [[self grouping] selectedSegmentIndex];
  NSString *groupingString;
  if (groupingIndex == 0) {
    groupingString = @"manufacturer";
    [self setGroupingMethod:@"Manufacturer"];
  } else if (groupingIndex == 1) {
    groupingString = @"category";
    [self setGroupingMethod:@"Category"];
  } else if (groupingIndex == 2) {
    groupingString = @"exporter";
    [self setGroupingMethod:@"Exporter"];

  } else {
    groupingString = @"no_group";
    [self setGroupingMethod:@""];
  }

  NSInteger selectedFiltering = [[self expireFilters] selectedSegmentIndex];
  NSString *filteringString;
  NSDate *startDAte;
  NSDate *endDAte;
  switch (selectedFiltering) {
    case 0:
      filteringString = @"expired";
      break;
    case 1:
      filteringString = @"non_expired";
      break;
    case 2:
      filteringString = @"in_range";
      startDAte = [[self startDatePicker] date];
      endDAte = [[self endDatePicker] date];
      break;
  }

  NSLog(@"grouping on: [%@] , filtering: [%@] , startDate: [%@], endDate: [%@]",
        groupingString, filteringString, startDAte, endDAte);

  [self
      setLastResult:[[self inventoryModel] getProductsByGrouping:groupingString
                                                    expireFilter:filteringString
                                                       startDate:startDAte
                                                         endDate:endDAte]];
}

- (void)viewDidLoad {
  [super viewDidLoad];
  if ([self inventoryModel]) {
    NSLog(@"Inventory model is alive.");
  } else {
    NSLog(@"Error Initializing inventory model.");
  }
  // Do any additional setup after loading the view, typically from a nib.
}

- (BDInventory *)inventoryModel {
  if (!_inventoryModel) {
    _inventoryModel = [BDInventory new];
    NSLog(@"Created a new Inventory model.");
  }
  return _inventoryModel;
}

- (void)didReceiveMemoryWarning {
  [super didReceiveMemoryWarning];
  // Dispose of any resources that can be recreated.
}

#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little
// preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
  // Get the new view controller using [segue destinationViewController].
  // Pass the selected object to the new view controller.
  [self applyFilters];

  [(BDInventoryFilterResults *)[segue destinationViewController]
      setResults:[self lastResult]];
  [(BDInventoryFilterResults *)[segue destinationViewController]
      setGroupingString:[self groupingMethod]];
  NSLog(@"ViewController: sent [%lu] group.", [[self lastResult] count]);
}

@end
