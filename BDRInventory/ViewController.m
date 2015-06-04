//
//  ViewController.m
//  BDRInventory
//
//  Created by Amr Lotfy on 6/3/15.
//  Copyright (c) 2015 Amr Lotfy. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()
@property (nonatomic) BDInventory * inventoryModel;
@property (weak, nonatomic) IBOutlet UISegmentedControl *grouping;
@property (weak, nonatomic) IBOutlet UISegmentedControl *expireFilters;
@property (weak, nonatomic) IBOutlet UITextView *textView;
@property (weak, nonatomic) IBOutlet UIDatePicker *startDatePicker;
@property (weak, nonatomic) IBOutlet UIDatePicker *endDatePicker;
@property (weak, nonatomic) IBOutlet UILabel *startDateLabel;
@property (weak, nonatomic) IBOutlet UILabel *endDatelabel;


@end

@implementation ViewController
- (IBAction)expirySelection:(id)sender {
    if ([[self expireFilters] selectedSegmentIndex]==2) {
        [[self startDatePicker] setHidden:false];
        [[self endDatePicker] setHidden:false];
        [[self startDateLabel] setHidden:false];
        [[self endDatelabel] setHidden:false];

    }else{
        [[self startDatePicker] setHidden:true];
        [[self endDatePicker] setHidden:true];
        [[self startDateLabel] setHidden:true];
        [[self endDatelabel] setHidden:true];
    }
}

- (IBAction)apply:(id)sender {
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    if ([self inventoryModel]){
        NSLog(@"Initialized inventory model.");
        
    }else{
        NSLog(@"Error Initializing inventory model.");
    }
    // Do any additional setup after loading the view, typically from a nib.
}

-(BDInventory *) inventoryModel{
    if(!_inventoryModel){
        _inventoryModel=[BDInventory new];
    }
    return _inventoryModel;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
