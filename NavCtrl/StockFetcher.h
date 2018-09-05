//
//  StockFetcher.h
//  Delegation
//
//  Created by Jesse Sahli on 3/8/17.
//  Copyright © 2017 turntotech. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "StockFetcherDelegate.h"
#import "CompnayMO+CoreDataClass.h"

@interface StockFetcher : NSObject
@property (weak, nonatomic) id<StockFetcherDelegate> companies;


//FUNCTIONS
-(void)fetchStockPriceForTicker: (CompnayMO*) ticker;
@end
