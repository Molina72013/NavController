//
//  CoreDataManager.m
//  NavCtrl
//
//  Created by Cristian Molina on 8/27/18.
//  Copyright © 2018 Aditya Narayan. All rights reserved.
//

#import "CoreDataManager.h"
#import <CoreData/CoreData.h>
#import "CompnayMO+CoreDataClass.h"
#import "ImageFetcher.h"
#import "ImageFetcher.h"
#import "Product+CoreDataClass.h"



@implementation CoreDataManager

@synthesize persistentContainer = _persistentContainer;

- (NSPersistentContainer *)persistentContainer {
    
    @synchronized (self) {
        if (_persistentContainer == nil) {
            _persistentContainer = [[NSPersistentContainer alloc] initWithName:@"Model"];
            [_persistentContainer loadPersistentStoresWithCompletionHandler:^(NSPersistentStoreDescription *storeDescription, NSError *error) {
                if (error != nil) {
                    
                    NSLog(@"Unresolved error %@, %@", error, error.userInfo);
                    abort();
                }
            }];
        }
    }
    
    return _persistentContainer;
}

- (void)saveContext {
    NSError *error = nil;
    if ([self.context hasChanges] && ![self.context save:&error]) {

        NSLog(@"Unresolved error %@, %@", error, error.userInfo);
        abort();
    }
}


-(void)createCompanyMO:(NSString*)name logo:(NSString*)logo api:(NSString*)api;
{
    self.context = self.persistentContainer.viewContext;
    CompnayMO* company = [[CompnayMO alloc] initWithContext: self.context];
    company.name = name;
    company.logo = logo;
    company.api = api;
    NSArray* companies = [self basicFetch];

    CompnayMO* lastObj = [companies lastObject];
    company.index = lastObj.index + 1;
    
    
    [self saveContext];
    [company release];
}

-(void) createProductForCompany:(CompnayMO*)selectedCompany withName:(NSString*)name andImage:(NSString*)image andURL:(NSString*)url price:(float)price
{
    NSArray<CompnayMO*> *results = [self basicFetch];
    
    for(CompnayMO* comp in results)
    {
        if(comp == selectedCompany)
        {
            Product* p = [[Product alloc] initWithContext:self.context];
            p.name = name;
            p.image = image;
            p.prodcutURL = url;
            // create a fetch to prodcuts to add index
            p.price = price;
            p.owner = comp;
            NSArray<Product*>* productArray = [self productBasicFetchFor:comp];
            
            Product* lastProdInArray = [productArray lastObject];
            
            p.index = lastProdInArray.index + 1;
            
            [self saveContext];
            [p release];
        }
    }
    
    
}



-(NSArray*) basicFetch
{

    NSManagedObjectContext *moc = self.context;
    NSFetchRequest *request = [NSFetchRequest fetchRequestWithEntityName:@"Company"];
    NSSortDescriptor* descriptor = [NSSortDescriptor sortDescriptorWithKey:@"index" ascending:YES];
    request.sortDescriptors = @[descriptor];
    NSError *error = nil;
    NSArray<CompnayMO*> *results = [moc executeFetchRequest:request error:&error];
    if (!results) {
        NSLog(@"Error fetching Company objects: %@\n%@", [error localizedDescription], [error userInfo]);
        abort();
    }
    [self printArray:results];
    return results;
}

-(NSArray<Product*>*) productBasicFetchFor:(CompnayMO*)comp
{
    NSArray<CompnayMO*>* companies = [self basicFetch];
    NSArray<Product*>* results = [NSArray array];
    for(CompnayMO* company in companies)
    {
        if(comp == company)
        {
            NSSortDescriptor* descriptor = [NSSortDescriptor sortDescriptorWithKey:@"index" ascending:YES];
            results = [comp.products sortedArrayUsingDescriptors:@[descriptor]];
            continue;
        }
        
    }

    return results;
    
}

-(void)moveCompany:(CompnayMO*)selectedCompnay from:(NSInteger)from to:(NSInteger)to
{

    NSArray<CompnayMO*> *results = [self basicFetch];
    NSMutableArray<CompnayMO*>* copy = [NSMutableArray arrayWithArray:results];
    
    CompnayMO* selected = selectedCompnay;
    NSInteger oldIndex = [copy indexOfObject:selected];
    
    [copy removeObjectAtIndex:oldIndex];
    [copy insertObject:selected atIndex:to];
    
    for(CompnayMO* copyCat in copy)
    {

        for(CompnayMO* comp in results)
        {
            if(comp == copyCat)
            {
                comp.index = (int)[copy indexOfObject:copyCat] + 1;
                continue;
            }
        }
    }

     [self saveContext];
}

-(void) moveProduct:(Product*)prodcut forComp:(CompnayMO *)selectedCompnay from:(NSInteger)from to:(NSInteger)to
{
    NSArray<Product*>* products = [self productBasicFetchFor:selectedCompnay];
    NSMutableArray<Product*>* prodcutsCopy = [NSMutableArray arrayWithArray:products];
    
    
    Product* movingProduct = prodcut;
    NSUInteger oldIndexForProduct = [prodcutsCopy indexOfObject:movingProduct];
    
    [prodcutsCopy removeObjectAtIndex:oldIndexForProduct];
    [prodcutsCopy insertObject:movingProduct atIndex:to];
    
    for(Product* p in prodcutsCopy)
    {
        for(Product* realP in products)
        {
            if(p == realP)
            {
                realP.index = [prodcutsCopy indexOfObject:p] + 1;
                continue;
            }
        }
    }
}

-(void) printArray:(NSArray<CompnayMO*>*)array
{
    for (CompnayMO* company in array)
    {
        NSLog(@"companyName:%@  logoName: %@", company.name, company.logo);
    }
}


-(instancetype)init
{
    if (self = [super init]) {
        self.context = self.persistentContainer.viewContext;
    }
    return self;
}

-(void) editComany:(CompnayMO*)company name:(NSString*)name logo:(NSString*)logo api:(NSString*)api
{
    NSManagedObjectContext *moc = self.context;
    NSFetchRequest *request = [NSFetchRequest fetchRequestWithEntityName:@"Company"];
    NSError* error;
    NSArray<CompnayMO*> *results = [moc executeFetchRequest:request error:&error];
    
    for(CompnayMO* comp in results)
    {
        if(company == comp)
        {
            comp.name = name;
            comp.logo = logo;
            comp.api = api;
            [self saveContext];
            break;
        }
    }
}


-(void) editProduct:(Product*)selectedProdcut for:(CompnayMO*)selectedCompnay withName:(NSString*)name imageLogo:(NSString*)logo andProductURL:(NSString*)URL price:(float)price
{
    NSArray<CompnayMO*>* companies = [self basicFetch];
    
    for(CompnayMO* comp in companies)
    {
        if(comp == selectedCompnay)
        {
            NSArray<Product*>* companysProducts = [self productBasicFetchFor:comp];
            
            for(Product* product in companysProducts)
            {
                if(product == selectedProdcut)
                {
                    product.name = name;
                    product.image = logo;
                    product.prodcutURL = URL;
                    product.price = price;
                    [self saveContext];
                    break;
                }
            }
        }
    }
}




- (void) deleteObject:(CompnayMO*)deltedCompany
{
    NSManagedObjectContext *moc = self.context;
    NSFetchRequest *request = [NSFetchRequest fetchRequestWithEntityName:@"Company"];

    NSError* error;
    NSArray<CompnayMO*> *results = [moc executeFetchRequest:request error:&error];
    
    for(CompnayMO* company in results)
    {
        if(company == deltedCompany)
        {
            [self.context deleteObject:company];
        }
    }

    [self saveContext];
}

-(void) deleteProdcut:(Product*)selectedProcut from:(CompnayMO*)selectedCompany
{
    NSArray<CompnayMO*>* companies = [self basicFetch];
   
    
    for(CompnayMO* comp in companies)
    {
        if(comp == selectedCompany)
        {
             NSArray<Product*>* companysProducts = [self productBasicFetchFor:comp];
            for(Product* p in companysProducts)
            {
                if(p  == selectedProcut)
                {
                    [self.context deleteObject:p];
                    [self saveContext];
                    break;
                }
            }
        }
    }
    
}


-(void) dealloc
{
    [_persistentContainer release];
    [super dealloc];

}


@end
