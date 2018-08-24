//
//  DOA.h
//  NavCtrl
//
//  Created by Cristian Molina on 8/16/18.
//  Copyright © 2018 Aditya Narayan. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "StockFetcherDelegate.h"
#import "Company.h"

@protocol UIUpdateDelegate <NSObject>

    -(void) updateUI;

@end


@class StockFetcher;
@interface Companies : NSObject <StockFetcherDelegate>

@property (nonatomic, retain) NSMutableArray<Company*>* companiesDataArray;
@property (strong, nonatomic) StockFetcher *stockFetcher;

@property (weak, nonatomic) id<UIUpdateDelegate> viewControllerDelegate;

+ (Companies*)theCompanies;

-(NSArray<Company*>*)getAllCompanies;

-(void)addCompany: (NSString*) name api:(NSString*)api logo: (NSString*) logo;
-(void)addProductForCompany:(NSString*)companyName prodcutName:(NSString*)name logo:(NSString*)logo andURL:(NSString*)URL;


-(void) deleteProduct:(Products*)deletedProduct company:(Company*)fromCompany;
-(void) deleteCompany:(Company*)deletedCompany; //changed
-(void) moveCompany:(Company*)movingCompany toIndex:(NSUInteger)toIndex;    //changed
-(NSArray<Products*>*)getAllProducts:(Company*)forCompany;
-(void) moveProduct:(Products*)movningProduct company:(Company*)fromCompany toIndex:(NSInteger)toIndex;  //changed
-(void) editCompany:(Company*)editedCompany editedName:(NSString*)editedName editedLogo:(NSString*)editedLogo;
-(void) getAllApi;



@end
