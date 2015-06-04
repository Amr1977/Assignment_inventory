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

-(NSPredicate *) expired{
    return [self expiresInRangeStart:[NSDate distantPast] RangeEnd:[NSDate date] reversed:false];

}

-(NSPredicate *) nonExpired{
    return [self expiresInRangeStart:[NSDate distantPast] RangeEnd:[NSDate date] reversed:false];
   
}



- (NSPredicate *)expiresInRangeStart:(NSDate *)expireRangeStartDate RangeEnd:(NSDate *)expireRangeEndDate reversed:(BOOL)reversedFlag {
    NSPredicate *result = [NSPredicate
                           predicateWithBlock:^BOOL(id evaluatedObject, NSDictionary *bindings) {
                               BOOL inRange=false;
                               BOOL afterOrEqualFirstDate=false;
                               BOOL beforeOrEqualEndDate=false;
                               NSDate * productExpireDate=[(BDIProduct *)evaluatedObject expireDate];
                               NSComparisonResult result = [productExpireDate compare: expireRangeStartDate];
                               afterOrEqualFirstDate=((result == NSOrderedDescending) || (result == NSOrderedSame) );
                               if (!afterOrEqualFirstDate){
                                   return (reversedFlag? true: false);
                               }
                               result = [productExpireDate compare: expireRangeEndDate];
                               beforeOrEqualEndDate=((result == NSOrderedAscending) || (result == NSOrderedSame) );
                               
                               inRange=(afterOrEqualFirstDate && beforeOrEqualEndDate);
                               return ( reversedFlag? !inRange : inRange ) ;
                           }];
    
    return result;
}

- (NSPredicate *)groupingBy:(NSString *)group  withValue:(NSString *)value {
    NSPredicate *result = [NSPredicate
                           predicateWithBlock:^BOOL(id evaluatedObject, NSDictionary *bindings) {
                               BOOL result;
                               
                               
                               
                               
                               return result;
                           }];
    
    return result;
}

-(NSArray *) getProductsByGrouping:(NSString *)grouping expireFilter:(NSString *) expireFilter{
    return [self getProductsByGrouping:grouping expireFilter:expireFilter startDate:nil endDate:nil];
}


-(NSArray *) getProductsByGrouping:(NSString *)grouping expireFilter:(NSString *) expireFilter startDate:(NSDate *) startDate endDate: (NSDate *) endDate{
    NSMutableArray * result=[[NSMutableArray alloc] init];
    
    
    
    return [result copy];
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
            if (data) {
                NSMutableArray * parsedProducts=[[NSMutableArray alloc] init];
                for (NSDictionary * productDictionary in data ) {
                    BDIProduct * product=[[BDIProduct alloc] initWithDictionary: productDictionary];
                    [parsedProducts addObject:product];
                    NSLog(@"=====================");

                }
                _products=[parsedProducts copy];
                NSLog(@"Parsed [%lu] products.",[_products count]);
            }
            
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
