//
//  BDInventoryFilterResults.m
//  BDRInventory
//
//  Created by Amr Lotfy on 6/4/15.
//  Copyright (c) 2015 Amr Lotfy. All rights reserved.
//

#import "BDInventoryResultsViewController.h"

@interface BDInventoryResultsViewController ()

@property(weak, nonatomic) IBOutlet UITextView *textView;

@end

@implementation BDInventoryResultsViewController

- (void)viewDidLoad {
  [super viewDidLoad];
  NSLog(@"BDInventoryFilterResults: Recieved [%lu] group.",
        [[self results] count]);

  [self formatOutput];

  // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
  [super didReceiveMemoryWarning];
  // Dispose of any resources that can be recreated.
}

- (void)formatOutput {
  NSMutableString *resultString = [NSMutableString new];
  for (NSString *key in [self results]) {
    if ([self.results[key] count]) {  // only if this key has associated data
      [resultString appendFormat:@"%@ [%@]: \n", [self groupingString], key];
      for (BDIProduct *product in self.results[key]) {
          [resultString appendFormat:@"%@ \n", [self formatProduct:product] ];
      }
      [resultString appendFormat:@"================================\n"];
    }
  }

  [[self textView] setText:[resultString copy]];
}

/** This method formats a product properties
 */
- (NSString *)formatProduct:(BDIProduct *) product {
    NSDateFormatter *format = [[NSDateFormatter alloc] init];
    [format setDateFormat:@"dd/MMM/yyyy"];
    
    NSNumberFormatter *currencyFormatter = [[NSNumberFormatter alloc] init];
    [currencyFormatter setNumberStyle:NSNumberFormatterCurrencyStyle];
    
    NSNumberFormatter *numberFormatter = [[NSNumberFormatter alloc] init];
    //[numberFormatter setNumberStyle:NSnu];
    [numberFormatter
     setGroupingSeparator:[[NSLocale currentLocale]
                           objectForKey:NSLocaleGroupingSeparator]];
    [numberFormatter setUsesGroupingSeparator:YES];
    
    return [NSString
            stringWithFormat:
            @"\n[%@] in [%@] \n "  //[self name],[self category],
            @"[%@] %@ \n"  //([self isExpired]?@"Expired":@"Not-Expired"),[self
            // expireDate],
            @"[%@] items. [%@] \n"  //(unsigned long)[self quantity],[self price],
            @"[%@]\n",              //[self manufacturer]
            [product name],
            [product category], ([product isExpired] ? @"Expired" : @"Not-Expired"),
            [format stringFromDate:[product expireDate]],
            [numberFormatter
             stringFromNumber:[NSNumber numberWithInteger:[product quantity]]],
            [currencyFormatter stringFromNumber:[product price]], [product manufacturer]
            
            ];
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little
preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
