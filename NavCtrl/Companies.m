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
#import "StockFetcher.h"
#import "CoreDataManager.h"
#import "CompnayMO+CoreDataClass.h"


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
        
        StockFetcher *stockFetcher = [[StockFetcher alloc]init];
        self.stockFetcher = stockFetcher;
        [stockFetcher release];
        
        
        self.stockFetcher.companies = self;
        _coreDataManager = [[CoreDataManager alloc] init];

        
        companiesDataArray = [[NSMutableArray alloc] initWithArray:[_coreDataManager basicFetch]];

//        [self initDefaultCompanies];

    }
    return self;
}



- (void)dealloc {
    // Should never be called, but just here for clarity really.
    [_coreDataManager release];
    [_stockFetcher release];
    [companiesDataArray release];
    [super dealloc];
}


- (NSArray<CompnayMO *> *)getAllCompanies {
    
    NSArray<CompnayMO *> *arrayCopy = [_coreDataManager basicFetch];
    return arrayCopy;
}


-(NSArray<Product*>*) getProdcutsForComp:(CompnayMO*)comp
{
    NSArray<Product*>* products = [_coreDataManager productBasicFetchFor:comp];
    return products;
}

- (void)addCompany:(NSString *)name api:(NSString*)api logo:(NSString *)logo {
    
    [_coreDataManager createCompanyMO:name logo:logo api:api];
    
}

-(void)addProductForCompany:(CompnayMO*)company prodcutName:(NSString*)name logo:(NSString*)logo andURL:(NSString*)URL price:(float)price
{
    [_coreDataManager createProductForCompany:company withName:name andImage:logo andURL:URL price:price];
}

-(void) deleteCompany:(CompnayMO*)deletedCompany   //changed
{
    [_coreDataManager deleteObject:deletedCompany];
}


-(void) deleteProduct:(Product*)deletedProduct company:(CompnayMO*)fromCompany
{
    [_coreDataManager deleteProdcut:deletedProduct from:fromCompany];
}


-(void) moveCompany:(CompnayMO*)movingCompany from:(NSInteger)from toIndex:(NSUInteger)toIndex     //changed
{

    [_coreDataManager moveCompany:movingCompany from:from to:toIndex];
}


-(void) moveProduct:(Product*)movningProduct company:(CompnayMO*)fromCompany from:(NSInteger)from toIndex:(NSInteger)toIndex  //changed
{
    [_coreDataManager moveProduct:movningProduct forComp:fromCompany from:from to:toIndex];
}

-(void) editCompany:(CompnayMO*)editedCompany editedName:(NSString*)editedName editedLogo:(NSString*)editedLogo edittedApi:(NSString*)edittedApi
{
    [_coreDataManager editComany:editedCompany name:editedName logo:editedLogo api:edittedApi];
}

-(void) editProduct:(Product*)product forCompany:(CompnayMO*)company withName:(NSString*)name andLogo:(NSString*)logo andURL:(NSString*)uRL price:(float)price
{
    [_coreDataManager editProduct:product for:company withName:name imageLogo:logo andProductURL:uRL price:price];
}


-(NSArray<Products*>*)getAllProducts:(Company*)forCompany
{
    return [[forCompany.companyProducts mutableCopy] autorelease];
}

-(void)stockFetchSuccessWithPriceString:(NSString *)priceString forCompany:(CompnayMO*)forCompany {
    NSLog(@"Stock price received");
    for(CompnayMO* company in companiesDataArray)
    {
        if(company == forCompany)
        {
            company.apiValue = [priceString floatValue];
            break;
        }
    }
    NSLog(@"%@", priceString);

    if(self.viewControllerDelegate){
        [self.viewControllerDelegate updateUI];
    }
}


#pragma mark Optional Delegate Methods

-(void)stockFetchDidFailWithError:(NSError *)error {
    //if(error)
   // NSLog(@"Couldn't fetch stock price, this is a description of the error:%@", error.localizedDescription);
    //do some sort of error handling here
}

-(void)stockFetchDidStart {
    NSLog(@"Initiating stock fetch...");
    //could start an activity indicator here
}




-(void) getAllApi
{
    for(CompnayMO* compnay in companiesDataArray)
    {
        [self.stockFetcher fetchStockPriceForTicker:compnay];
        
    }
}





@end
