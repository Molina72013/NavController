//
//  CoreDataManager.h
//  NavCtrl
//
//  Created by Cristian Molina on 8/27/18.
//  Copyright © 2018 Aditya Narayan. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>
#import "CompnayMO+CoreDataClass.h"


@interface CoreDataManager : NSObject


@property (readonly, strong) NSPersistentContainer *persistentContainer;

@property (nonatomic, assign) NSManagedObjectContext* context;




//RETURNING VALUE FUNCTIONS
-(NSArray*) basicFetch;
-(NSArray<Product*>*) productBasicFetchFor:(CompnayMO*)comp;
//FUNCTIONS
-(void)createCompanyMO:(NSString*)name logo:(NSString*)logo api:(NSString*)api;
- (void) deleteObject:(CompnayMO*)deltedCompany;
-(void)moveCompany:(CompnayMO*)selectedCompnay from:(NSInteger)from to:(NSInteger)to;
-(void) editComany:(CompnayMO*)company name:(NSString*)name logo:(NSString*)logo api:(NSString*)api;
- (void)saveContext;
-(void) createProductForCompany:(CompnayMO*)selectedCompany withName:(NSString*)name andImage:(NSString*)image andURL:(NSString*)url price:(float)price;
-(void) deleteProdcut:(Product*)selectedProcut from:(CompnayMO*)selectedCompany;
-(void) editProduct:(Product*)selectedProdcut for:(CompnayMO*)selectedCompnay withName:(NSString*)name imageLogo:(NSString*)logo andProductURL:(NSString*)URL price:(float)price;

-(void) moveProduct:(Product*)prodcut forComp:(CompnayMO *)selectedCompnay from:(NSInteger)from to:(NSInteger)to;

@end
