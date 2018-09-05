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
#import "CoreDataManager.h"
#import "ImageFetcher.h"
#import "Product+CoreDataProperties.h"
@protocol UIUpdateDelegate <NSObject>

    -(void) updateUI;

@end


@class StockFetcher;
@interface Companies : NSObject <StockFetcherDelegate>
+ (Companies*)theCompanies;
@property (nonatomic, retain) NSMutableArray<Company*>* companiesDataArray;
@property (strong, nonatomic) StockFetcher *stockFetcher;
@property (nonatomic, retain) CoreDataManager* coreDataManager;
@property (weak, nonatomic) id<UIUpdateDelegate> viewControllerDelegate;

//RETURNING VALUE FUNCTIONS
-(NSArray<Product*>*) getProdcutsForComp:(CompnayMO*)comp;
-(NSArray<CompnayMO*>*)getAllCompanies;


//FUNCTIONS
-(void)addCompany: (NSString*) name api:(NSString*)api logo: (NSString*) logo;
-(void) deleteProduct:(Product*)deletedProduct company:(CompnayMO*)fromCompany;
-(void) deleteCompany:(CompnayMO*)deletedCompany; //changed
-(void) moveCompany:(CompnayMO*)movingCompany from:(NSInteger)from toIndex:(NSUInteger)toIndex;
-(void) moveProduct:(Product*)movningProduct company:(CompnayMO*)fromCompany from:(NSInteger)from toIndex:(NSInteger)toIndex;
-(void) editCompany:(CompnayMO*)editedCompany editedName:(NSString*)editedName editedLogo:(NSString*)editedLogo edittedApi:(NSString*)edittedApi;
-(void) getAllApi;
-(void)addProductForCompany:(CompnayMO*)company prodcutName:(NSString*)name logo:(NSString*)logo andURL:(NSString*)URL price:(float)price;
-(void) editProduct:(Product*)product forCompany:(CompnayMO*)company withName:(NSString*)name andLogo:(NSString*)logo andURL:(NSString*)uRL price:(float)price;
@end
