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

//-(NSArray *) getProductsByGrouping:(NSString *)grouping expireFilter:(NSString *) expireFilter;
-(NSDictionary *) getProductsByGrouping:(NSString *)grouping expireFilter:(NSString *) expireFilter startDate:(NSDate *) startDate endDate: (NSDate *) endDate;
-(NSArray *) getProductsByExpireFilter:(NSString *) expireFilter startDate:(NSDate *)startDate endDate: (NSDate *) endDate;

@end

@implementation BDInventory

NSMutableSet * manufacturers;
NSMutableSet * categories;
NSMutableSet * exporters;

-(NSDictionary *) getProductsByGrouping:(NSString *)grouping expireFilter:(NSString *) expireFilter startDate:(NSDate *) startDate endDate: (NSDate *) endDate{
    //TODO: the main method, performs filtering on expire filter then the result is regrouped by grouping filter
    NSArray * expireFilteredProducts=[self getProductsByExpireFilter:expireFilter startDate:startDate endDate:endDate];
    NSDictionary * groupedProducts=[self filterProducts:expireFilteredProducts byGroupingMethod:grouping];
    return groupedProducts;
}

-(NSArray *) getProductsByExpireFilter:(NSString *) expireFilter startDate:(NSDate *)startDate endDate: (NSDate *) endDate{
    NSArray * result;
    NSInteger index=[[BDInventory allowedExpireFiltering] indexOfObject:expireFilter];
    if (index!=NSNotFound){
        NSPredicate * expireFilter;
        switch (index) {
            case 0://expired
                expireFilter= [self expired];
                break;
            case 1://non expired
                expireFilter= [self nonExpired];
                break;
                
            case 2://in range
                 expireFilter = [self expiresInRangeStart:startDate RangeEnd:endDate reversed:false];
                break;
            default:
                break;
        }
        
        result=[[self products] filteredArrayUsingPredicate: expireFilter];
    }
    
    return result;
}



+(NSArray *) allowedGrouping{
    return [[NSArray alloc] initWithObjects:@"manufacturer",@"category",@"exporter", nil];
}

+(NSArray *) allowedExpireFiltering{
    return [[NSArray alloc] initWithObjects:@"expired",@"non_expired",@"in_range", nil];
}

-(NSPredicate *) expired{
    return [self expiresInRangeStart:[NSDate distantPast] RangeEnd:[NSDate date] reversed:false];

}

-(NSPredicate *) nonExpired{
     ;
    return [NSCompoundPredicate notPredicateWithSubpredicate:[self expired]];
   
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
                               BOOL result=true;
                               NSInteger index = [[BDInventory allowedGrouping] indexOfObject:group];
                               if(index!=NSNotFound){
                                   switch (index) {
                                       case 0://manufacturer
                                           return [[[(BDIProduct *)evaluatedObject manufacturer] lowercaseString]isEqualToString:[value lowercaseString]];
                                           break;
                                           
                                       case 1://category
                                           return [[[(BDIProduct *)evaluatedObject category] lowercaseString]isEqualToString:[value lowercaseString]];
                                           break;
                                           
                                       case 2:
                                           return [[[(BDIProduct *)evaluatedObject exporterID] lowercaseString]isEqualToString:[value lowercaseString]];
                                           break;
                                           
                                       default:
                                           NSLog(@"unknown grouping by: [%@]",group);
                                           break;
                                   }
                                   
                               }
                               return result;
                           }];
    
    return result;
}

-(NSArray *) filterProducts: (NSArray *)productsArray groupedBy:(NSString *)grouping withValue:(NSString *)value{
    return [productsArray filteredArrayUsingPredicate:[self groupingBy:grouping withValue:value]];
}

/**
 * returns a dictionary where the key is the the value that objects are grouped by, these objects are ararnged in an array in the value part of the dictionary
 */
-(NSDictionary *) filterProducts:(NSArray *)productsArray byGroupingMethod:(NSString *)grouping {
    NSMutableDictionary * result;
    NSInteger index= [[BDInventory allowedGrouping] indexOfObject:grouping];
    if (index!=NSNotFound) {
        result=[NSMutableDictionary new];
        NSMutableSet * groupingSet;
        NSString * groupingString=[BDInventory allowedGrouping][index];
        switch (index) {
            case 0://manufacturer
                groupingSet=manufacturers;
                break;
                
            case 1://category
                groupingSet=categories;
                break;
                
            case 2://exporter
                groupingSet=exporters;
                break;
        }
        
        for (NSString * groupingKey in groupingSet) {
            //create dictionary entry for each manufacturer with a value which is an array of the products that are produced by this manufacturer
            [result setValue:[self filterProducts:productsArray groupedBy:groupingString withValue:groupingKey]
                      forKey:groupingKey
             ];
        }
    } else{
        NSLog(@"unkown grouping method [%@].",grouping);
    }
    
    return [result copy];
}

/*
-(NSArray *) getGroupOfProducts:(NSArray *)productsArray byGrouping:(NSString *)grouping forValue:(NSString *) value{
    NSArray * result=[productsArray filteredArrayUsingPredicate:[self groupingBy:grouping withValue:value]];
    return result;
}
 */




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
                manufacturers=[[NSMutableSet alloc] init];
                categories=[[NSMutableSet alloc] init];
                exporters=[[NSMutableSet alloc] init];
                NSMutableArray * parsedProducts=[[NSMutableArray alloc] init];
                for (NSDictionary * productDictionary in data ) {
                    BDIProduct * product=[[BDIProduct alloc] initWithDictionary: productDictionary];
                    [parsedProducts addObject:product];
                    NSLog(@"=====================");
                    //TODO: fill the global sets !
                    if ([product manufacturer]) {
                        [manufacturers addObject:[product manufacturer]];
                        NSLog(@"number of manufacturers so far: %lu",(unsigned long)[manufacturers count]);
                    }
                    if ([product exporterID]) {
                        [exporters addObject:[product exporterID]];
                        NSLog(@"number of exporters so far: %lu",(unsigned long)[exporters count]);
                    }
                    if ([product category]) {
                        [categories addObject:[product category]];
                        NSLog(@"number of categories so far: %lu",(unsigned long)[categories count]);
                    }


                }
                _products=[parsedProducts copy];
                NSLog(@"Parsed [%lu] products, manufacturers: %lu, exporters: %lu, categories: %lu.",[_products count],(unsigned long)[manufacturers count],(unsigned long)[exporters count],(unsigned long)[categories count]);
            }
            
        }
        else
        {
            NSLog(@"File not found [%@]",path);
        }
    }else{
        NSLog(@"%@ Error initializing", [self class]);
    }
    NSLog(@"products grouped by manufacturer %@",[self filterProducts:[self products] byGroupingMethod:@"manufacturer"] );
    NSLog(@"non-expired products grouped by manufacturer %@",[self getProductsByGrouping:@"manufacturer" expireFilter:@"non_expired" startDate:nil endDate:nil] );
    return self;
}

@end
