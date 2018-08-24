//
//  StockFetcher.m
//  Delegation
//
//  Created by Jesse Sahli on 3/8/17.
//  Copyright © 2017 turntotech. All rights reserved.
//

#import "StockFetcher.h"
#import "Company.h"
#import "Companies.h"

@implementation StockFetcher


//calling delegate methods during the fetching process so that the delegate can respond accordingly

-(void)fetchStockPriceForTicker: (Company*)forCompany {
    
    
    NSString* ticker = [NSString stringWithFormat:@"%@",forCompany.companyAPI];

    //responds to selector is necessary for optional methods in our delegate protocol "StockFetcherDelegate", if our delegate does not implement them and we try to call them.. the app will crash
    
    if ([self.companies respondsToSelector:@selector(stockFetchDidStart)]) {
        [self.companies stockFetchDidStart];
    }
    
    NSString *urlString = [NSString stringWithFormat:@"https://ws-api.iextrading.com/1.0/tops?symbols=%@", ticker];
    NSURL *url = [NSURL URLWithString:urlString];
    
    NSURLSessionDataTask *task = [[NSURLSession sharedSession] dataTaskWithURL:url completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        
        if (error) {
            if ([self.companies respondsToSelector:@selector(stockFetchDidFailWithError:)]) {
                
                //we are not on the main queue at this point so it is important to dispatch blocks
                dispatch_async(dispatch_get_main_queue(), ^{
                    
                   
                    [self.companies stockFetchDidFailWithError:error];
                });
            }
        } else {
          //  NSString *priceString = [[NSString alloc]initWithData:data encoding:NSUTF8StringEncoding];
            NSError* err;
            NSArray *jsonDict = [NSJSONSerialization JSONObjectWithData:data options: NSJSONReadingMutableContainers error: &err];

            if(!jsonDict || jsonDict.count == 0)
            {
                if ( [self.companies respondsToSelector:@selector(stockFetchDidFailWithError:)] ){
                    [self.companies stockFetchDidFailWithError:err];
                }
                NSLog(@"Empty Array");
                return;
            }
            NSDictionary* lol = [jsonDict objectAtIndex:0];
            

            
 
            
            NSString* price = [lol valueForKey:@"lastSalePrice"];
            

            dispatch_async(dispatch_get_main_queue(), ^{
                
                [self.companies stockFetchSuccessWithPriceString:price forCompany:forCompany];
                
                //communicate with the delegate that we have succeeded in fetching a stock price and giving the delegate the stockprice for further processing
                
               // [self.delegate stockFetchSuccessWithPriceString:price forCompany:forCompany];
            });
        }
    }];
    [task resume];
}

@end
