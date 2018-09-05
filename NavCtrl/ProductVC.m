//
//  ProductVC.m
//  NavCtrl
//
//  Created by Jesse Sahli on 2/7/17.
//  Copyright © 2017 Aditya Narayan. All rights reserved.
//

#import "ProductVC.h"
#import "Companies.h"
#import "Products.h"



@interface ProductVC ()

@end

@implementation ProductVC

- (void)viewDidLoad {
    self.navigationItem.backBarButtonItem = [[[UIBarButtonItem alloc] initWithTitle:@"" style:UIBarButtonItemStylePlain target:nil action:nil] autorelease];
    UIWindow *window = UIApplication.sharedApplication.keyWindow;
    CGFloat topPadding = window.safeAreaInsets.top;
    CGFloat navHeight =  self.navigationController.navigationBar.frame.size.height;

    float total = topPadding + navHeight;
    self.topConstraint.constant = total;

    [UIView animateWithDuration:0.3 animations:^{
        [self.view layoutIfNeeded];
    }];
    
    
    UIBarButtonItem *addButton = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemAdd target:self action:@selector(addProductToComp)];

    self.navigationItem.rightBarButtonItem = addButton;

    NSURL *url = [NSURL URLWithString:_currentCompany.logo];

    NSURLSessionDataTask* cellImaging = [[NSURLSession sharedSession] dataTaskWithURL:url completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        if(!data)
        {
            return;
        }
        //                UIImage* img = [[UIImage alloc]initWithData:data];
        dispatch_sync(dispatch_get_main_queue(), ^{
            _companyImage.image = [UIImage imageWithData:data];
            [_companyImage setNeedsLayout];
            //                    [img release];
            //            [tableView reloadData];
        });
        
    }];
    
    [cellImaging resume];
    NSString* labelText = [NSString stringWithFormat:@"%@ (%@)",_currentCompany.name, _currentCompany.api];

    self.companyLabel.text = labelText;
    [addButton release];
    [super viewDidLoad];
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 70;
}
- (void)toggleEditMode {

    if (self.tableView.editing) {
        [self.tableView setEditing:NO animated:YES];
        self.navigationItem.rightBarButtonItem.title = @"Edit";
    } else {
        [self.tableView setEditing:YES animated:NO];
        self.navigationItem.rightBarButtonItem.title = @"Done";

    }
}


-(void) addProductToComp
{
    CreationAndEditionVC* vc = [[CreationAndEditionVC alloc] init];
    
    vc.currCompanyForProduct = self.currentCompany;
    
    [self.navigationController
     pushViewController:vc
     animated:YES];
    
    [vc release];
    
    
}

- (void)viewWillAppear:(BOOL)animated {
    
    [super viewWillAppear:animated];
    
    [self refreshProductList];
    [self.tableView reloadData];

    
}


- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath{
    
    return YES;
}

-(void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath{
    //Manipulate your data array.

    
    Product* chosenProudct = [self.products objectAtIndex:fromIndexPath.row];
    
    
    [Companies.theCompanies moveProduct:chosenProudct company:_currentCompany from:fromIndexPath.row toIndex:toIndexPath.row];
    [self refreshProductList];
    
    

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
#warning Potentially incomplete method implementation.
    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
#warning Incomplete method implementation.
    // Return the number of rows in the section.
    return self.products.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:CellIdentifier] autorelease];
    }
//    // Configure the cell...
//
    Product* product = [self.products objectAtIndex:indexPath.row];
//
    cell.textLabel.text = product.name;

    cell.detailTextLabel.text = [NSString stringWithFormat:@"$%.2f", product.price];
    cell.imageView.image = nil;
    
    NSURL *url = [NSURL URLWithString:product.image];

    NSURLSessionDataTask* cellImaging = [[NSURLSession sharedSession] dataTaskWithURL:url completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        if(!data)
        {
            return;
        }
        
        //        UIImage* img = [[UIImage alloc]initWithData:data];
        
        dispatch_sync(dispatch_get_main_queue(), ^{
            cell.imageView.image = [UIImage imageWithData:data];
            CGSize itemSize = CGSizeMake(50, 60);
            UIGraphicsBeginImageContextWithOptions(itemSize, NO, UIScreen.mainScreen.scale);
            CGRect imageRect = CGRectMake(0.0, 0.0, itemSize.width, itemSize.height);
            [cell.imageView.image drawInRect:imageRect];
            cell.imageView.image = UIGraphicsGetImageFromCurrentImageContext();
            UIGraphicsEndImageContext();
            [cell setNeedsLayout];
            
        });
        
    }];
    [cellImaging resume];
    
    
    return cell;
}
//ADD DELETING VERB
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {

    if (editingStyle == UITableViewCellEditingStyleDelete) {
        
        Product* p = [_products objectAtIndex:indexPath.row];
        
        [Companies.theCompanies deleteProduct:p company:_currentCompany];
        [self refreshProductList];
        [tableView deleteRowsAtIndexPaths:[NSArray arrayWithObject:indexPath] withRowAnimation:UITableViewRowAnimationFade];
    }
}




//HIDE THE SWPING DELETE
- (UITableViewCellEditingStyle)tableView:(UITableView *)aTableView editingStyleForRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Detemine if it's in editing mode
    if (self.tableView.editing)
    {
        return UITableViewCellEditingStyleDelete;
    }

    return UITableViewCellEditingStyleNone;
}


 #pragma mark - Table view delegate
 
 // In a xib-based application, navigation from a table can be handled in -tableView:didSelectRowAtIndexPath:
 - (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
 {
     

     WKWebViewVC* wkvc  = [[WKWebViewVC alloc] init];
     
     Product* currProduct = [self.products objectAtIndex:indexPath.row];
     
     wkvc.wkProdcut = currProduct;
     wkvc.wKPCompany = _currentCompany;
     wkvc.title = @"Product Link";
     
     [self.navigationController
      pushViewController:wkvc
      animated:YES];
     
     [wkvc release];
}


-(void) refreshProductList
{
    self.products = [Companies.theCompanies getProdcutsForComp:_currentCompany];
    
    
    if (_products.count > 0)
    {
        [_emptyProductArrayView setHidden:true];
    } else
    {
        [_emptyProductArrayView setHidden:false];

    }


}
- (IBAction)addButton:(id)sender {
    [self addProductToComp];
}
- (void)dealloc {
    [_tableView release];
    [_companyImage release];
    [_companyLabel release];
    [_topConstraint release];
    [_emptyProductArrayView release];
    [_currentCompany release];
    [_products release];
    [_wkwebViewController release];
//    [_addButton release];
    [super dealloc];
}

@end
