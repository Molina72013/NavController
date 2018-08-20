//
//  DOA.h
//  NavCtrl
//
//  Created by Cristian Molina on 8/16/18.
//  Copyright © 2018 Aditya Narayan. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "Company.h"

@interface Companies : NSObject

@property (nonatomic, retain) NSMutableArray<Company*>* companiesDataArray;


+ (Companies*)theCompanies;

-(NSArray<Company*>*)getAllCompanies;

-(void)addCompany: (NSString*) name logo: (NSString*) logo;
-(void)addProductForCompany:(NSString*)companyName prodcutName:(NSString*)name logo:(NSString*)logo andURL:(NSString*)URL;


-(void) deleteProduct:(Products*)deletedProduct company:(Company*)fromCompany;
-(void) deleteCompany:(Company*)deletedCompany; //changed
-(void) moveCompany:(Company*)movingCompany toIndex:(NSUInteger)toIndex;    //changed
-(NSArray<Products*>*)getAllProducts:(Company*)forCompany;
-(void) moveProduct:(Products*)movningProduct company:(Company*)fromCompany toIndex:(NSInteger)toIndex;  //changed



@end
