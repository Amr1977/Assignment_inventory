//
//  BDIExpireFilterViewController.m
//  BDRInventory
//
//  Created by Amr Lotfy on 7/2/15.
//  Copyright (c) 2015 Amr Lotfy. All rights reserved.
//

#import "BDIExpireFilterViewController.h"

@interface BDIExpireFilterViewController ()
@property (weak, nonatomic) IBOutlet UISegmentedControl *filterMode;

@property (weak, nonatomic) IBOutlet UIDatePicker *startDate;

@property (weak, nonatomic) IBOutlet UIDatePicker *endDate;
@property (weak, nonatomic) IBOutlet UILabel *fromLabel;
@property (weak, nonatomic) IBOutlet UILabel *toLabel;

@end

@implementation BDIExpireFilterViewController

- (IBAction)expireFilterChangeAction:(id)sender {
    if ([self.filterMode selectedSegmentIndex]==2) {
        [self.startDate setHidden:NO];
        [self.endDate setHidden:NO];
        [self.fromLabel setHidden:NO];
        [self.toLabel setHidden:NO];
    }else{
        [self.startDate setHidden:YES];
        [self.endDate setHidden:YES];
        [self.fromLabel setHidden:YES];
        [self.toLabel setHidden:YES];
        
    }
    
    self.storedFilterMode = [self.filterMode selectedSegmentIndex];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self.filterMode setSelectedSegmentIndex: self.storedFilterMode];
    if (self.storedStartDate) {
        [self.startDate setDate:self.storedStartDate];
        [self.endDate setDate:self.storedEndDate];
    }
    
    [self expireFilterChangeAction:nil];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
    BDIExpireFilterMode expirefilterMode;
    switch ([self.filterMode selectedSegmentIndex]) {
        case 0:
            expirefilterMode = BDIProductExpired;
            break;
            
        case 1:
            expirefilterMode = BDIProductNonExpired;
            break;
            
        case 2:
            expirefilterMode = BDIProductInRange;
            break;
            
        default:
            break;
    }
    
    [(BDIMainViewController *)[segue destinationViewController] setExpireFilterMode:expirefilterMode];
    NSLog(@"Destination VC: %@",[segue.destinationViewController title]);
}


@end
