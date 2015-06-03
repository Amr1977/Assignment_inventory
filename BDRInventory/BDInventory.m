//
//  BDInventory.m
//  BDRInventory
//
//  Created by Amr Lotfy on 6/3/15.
//  Copyright (c) 2015 Amr Lotfy. All rights reserved.
//

#import "BDInventory.h"

@interface BDInventory()


@property (nonatomic) NSArray * products;

-(NSArray *) getProductsByGrouping:(NSString *)grouping expireFilter:(NSString *) expireFilter;
-(NSArray *) getProductsByGrouping:(NSString *)grouping expireFilter:(NSString *) expireFilter startDate:(NSDate *) startDate endDate: (NSDate *) endDate;


@end

@implementation BDInventory

-(NSArray *) getProductsByGrouping:(NSString *)grouping expireFilter:(NSString *) expireFilter{
    return [self getProductsByGrouping:grouping expireFilter:expireFilter startDate:nil endDate:nil];
}


-(NSArray *) getProductsByGrouping:(NSString *)grouping expireFilter:(NSString *) expireFilter startDate:(NSDate *) startDate endDate: (NSDate *) endDate{

    return nil;
}


-(instancetype) init{
    self =[super init];
    if (self){
       //load data from data source
        NSString *bundlePath = [[NSBundle mainBundle]bundlePath]; //Path of your bundle
        NSString *path = [bundlePath stringByAppendingPathComponent:@"inventory_data.plist"];
        NSFileManager *fileManager = [NSFileManager defaultManager];
        
        NSArray *data;
        
        if ([fileManager fileExistsAtPath: path])
        {
            NSLog(@"File found [%@]",path);
            data = [NSArray  arrayWithContentsOfFile: path];  // if file exist at path initialise your dictionary with its data
            
        }
        else
        {
            NSLog(@"File not found [%@]",path);
        }
    }else{
        NSLog(@"%@ Error initializing", [self class]);
    }
    
    return self;
}

@end
