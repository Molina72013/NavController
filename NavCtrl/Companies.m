//
//  DOA.m
//  NavCtrl
//
//  Created by Cristian Molina on 8/16/18.
//  Copyright © 2018 Aditya Narayan. All rights reserved.
//

#import "Companies.h"
#import "Company.h"
#import "Products.h"


static Companies* theCompany = nil;

@implementation Companies
@synthesize companiesDataArray;

+ (Companies*) theCompanies {
    @synchronized(self) {
        if(theCompany == nil)
            theCompany = [[super allocWithZone:NULL] init];
    }
    return theCompany;
}

+ (id)allocWithZone:(NSZone *)zone {
    return [[self theCompanies] retain];
}

- (id)copyWithZone:(NSZone *)zone {
    return self;
}

- (id)retain {
    return self;
}

- (NSUInteger)retainCount {
    return UINT_MAX; //denotes an object that cannot be released
}

- (oneway void)release {
    // never release
}
- (id)autorelease {
    return self;
}
- (id)init {
    NSLog(@"The Companies DOA is initializing");
    if (self = [super init]) {
        self.companiesDataArray = [NSMutableArray array];
        [self initDefaultCompanies];

    }
    return self;
}



- (void)dealloc {
    // Should never be called, but just here for clarity really.
    [super dealloc];
}


-(void) initDefaultCompanies
{
    NSString* apple = @"Apple mobile devices";
    [self addCompany:apple logo:@"applelogo"];
    [self addProductForCompany:apple prodcutName:@"iPod" logo:@"ipodicon" andURL:@"https://www.apple.com/ipod-touch/"];
    [self addProductForCompany:apple prodcutName:@"iPad" logo:@"ipadicon" andURL:@"https://www.apple.com/ipad/"];

    
    
    [self addCompany:@"Samsung mobile devices" logo:@"samsunglogo"];
    
    
   // Company* apple = [[Company alloc]  initWith:@"Apple mobile devices" i:@"applelogo"];
    
    
//    [apple addProducts:@"iPhone" i:@"iphoneicon" u:@"https://www.apple.com/iphone/"];
//    [apple addProducts:@"iPad" i:@"ipadicon" u:@"https://www.apple.com/ipad/"];
//
//    Company* samsung = [[Company alloc] initWith:@"Samsung mobile devices" i:@"samsunglogo"];
//
//    [samsung addProducts:@"Galaxy S" i:@"galaxysicon" u:@"https://www.samsung.com/my/smartphones/galaxy-s/"];
//
//    [companiesDataArray addObject:samsung];
//    [companiesDataArray addObject:apple];
//    return self;
}

- (NSArray<Company *> *)getAllCompanies {
    NSArray<Company *> *arrayCopy = [[NSArray alloc] initWithArray:companiesDataArray];
    return arrayCopy;
}

- (void)addCompany:(NSString *)name logo:(NSString *)logo {
    
    Company *company = [[Company alloc] initWithName:name andLogo:logo];
    [companiesDataArray addObject:company];
    
}

-(void)addProductForCompany:(NSString*)companyName prodcutName:(NSString*)name logo:(NSString*)logo andURL:(NSString*)URL   //change after datamode is set Compnay* company
{
    Products* product = [[Products alloc] initWithName:name andLogo:logo andURL:URL];
    
    for(Company* company in companiesDataArray)
    {
        if ([company.companyName isEqualToString:companyName])
        {
            [company.companyProducts addObject:product];
            break;
        }
    }
    
}

-(void) deleteCompany:(Company*)deletedCompany   //changed
{
    
    for (Company* company in companiesDataArray)
    {
        if(company == deletedCompany)
        {
            [companiesDataArray removeObject:company];
            break;
        }
    }
}


-(void) deleteProduct:(Products*)deletedProduct company:(Company*)fromCompany
{

    for(Company* company in companiesDataArray)
    {
        for(Products* product in company.companyProducts)
        {
            
            if(company == fromCompany && product == deletedProduct)
            {
                [company.companyProducts removeObject:product];
                break;
            }
        }
    }
    
    
}


-(void) moveCompany:(Company*)movingCompany toIndex:(NSUInteger)toIndex     //changed
{

    
    for(Company* company in companiesDataArray)
    {
        if (company == movingCompany)
        {
            Company* oldCompany = company;
          //  NSUInteger oldCompanyIndex = [companiesDataArray indexOfObject:oldCompany];
            
            [self.companiesDataArray removeObject:movingCompany];
            
            [self.companiesDataArray insertObject:oldCompany atIndex:toIndex];
            break;
        }
    }
   
}


-(void) moveProduct:(Products*)movningProduct company:(Company*)fromCompany toIndex:(NSInteger)toIndex  //changed
{
    
    for(Company* company in companiesDataArray)
    {
        for(Products* product in company.companyProducts)
        {
            if(company == fromCompany && product == movningProduct)
            {
           //     NSUInteger oldProuctIndex = [company.companyProducts indexOfObject:product];
                Products* oldProduct = product;
                
                [company.companyProducts removeObject:product];
                [company.companyProducts insertObject:oldProduct atIndex:toIndex];
                
                break;
            }
                
        }
    }
    
    
    
    
}


-(NSArray<Products*>*)getAllProducts:(Company*)forCompany
{
    return [forCompany.companyProducts mutableCopy];
}

@end
