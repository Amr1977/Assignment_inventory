//
//  BDInventoryFilterResults.m
//  BDRInventory
//
//  Created by Amr Lotfy on 6/4/15.
//  Copyright (c) 2015 Amr Lotfy. All rights reserved.
//

#import "BDInventoryFilterResults.h"

@interface BDInventoryFilterResults ()

@property(weak, nonatomic) IBOutlet UITextView *textView;

@end

@implementation BDInventoryFilterResults

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
        [resultString appendFormat:@"%@ \n", product];
      }
      [resultString appendFormat:@"================================\n"];
    }
  }

  [[self textView] setText:[resultString copy]];
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
