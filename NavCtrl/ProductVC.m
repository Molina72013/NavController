//
//  ProductVC.m
//  NavCtrl
//
//  Created by Jesse Sahli on 2/7/17.
//  Copyright © 2017 Aditya Narayan. All rights reserved.
//

#import "ProductVC.h"


@interface ProductVC ()

@end

@implementation ProductVC

- (void)viewDidLoad {
    [super viewDidLoad];
    UIBarButtonItem *editButton = [[UIBarButtonItem alloc]initWithTitle:@"Edit" style:UIBarButtonItemStylePlain target:self action:@selector(toggleEditMode)];
    self.navigationItem.rightBarButtonItem = editButton;
    // Do any additional setup after loading the view from its nib.
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

- (void)viewWillAppear:(BOOL)animated {
    
    [super viewWillAppear:animated];
    
    
    
    
    if ([self.title isEqualToString:@"Apple mobile devices"]) {
        [self initProdcuts:@"apple"];
        [self initProductLogo:@"apple"];
        [self getUrlForProducts:@"apple"];
    } else if ([self.title isEqualToString:@"Samsung mobile devices"]) {
        [self initProdcuts:@"samsung"];
        [self initProductLogo:@"samsung"];
        [self getUrlForProducts:@"samsung"];
    } else if ([self.title isEqualToString:@"BlackBerry mobile devices"]) {
        [self initProdcuts:@"blackberry"];
    } else {
        [self initProdcuts:@"windows"];
    }
    [self.tableView reloadData];
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
    return [self.products count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
    }
    // Configure the cell...
    cell.textLabel.text = [self.products objectAtIndex:[indexPath row]];
    
    
    cell.imageView.image = [_logoPicuture objectAtIndex:indexPath.row];

    return cell;
}
//ADD DELETING VERB
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {

    if (editingStyle == UITableViewCellEditingStyleDelete) {
        [self.products removeObjectAtIndex:indexPath.row];//or something similar to this based on your data source array structure
        //remove the corresponding object from your data source array before this or else you will get a crash
        //Everthing is being controlled through indexPath
        [self.productURLS removeObjectAtIndex:indexPath.row];
        [self.logoPicuture removeObjectAtIndex: indexPath.row];
        [tableView deleteRowsAtIndexPaths:[NSArray arrayWithObject:indexPath] withRowAnimation:UITableViewRowAnimationFade];
    }
}




//HIDE THE SWIPING DELETE
- (UITableViewCellEditingStyle)tableView:(UITableView *)aTableView editingStyleForRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Detemine if it's in editing mode
    if (self.tableView.editing)
    {
        return UITableViewCellEditingStyleDelete;
    }

    return UITableViewCellEditingStyleNone;
}


/*
 // Override to support conditional editing of the table view.
 - (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
 {
 // Return NO if you do not want the specified item to be editable.
 return YES;
 }
 */

/*
 // Override to support editing the table view.
 - (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
 {
 if (editingStyle == UITableViewCellEditingStyleDelete) {
 // Delete the row from the data source
 [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
 }
 else if (editingStyle == UITableViewCellEditingStyleInsert) {
 // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
 }
 }
 */

/*
 // Override to support rearranging the table view.
 - (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath
 {
 }
 */

/*
 // Override to support conditional rearranging of the table view.
 - (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath
 {
 // Return NO if you do not want the item to be re-orderable.
 return YES;
 }
 */


 #pragma mark - Table view delegate
 
 // In a xib-based application, navigation from a table can be handled in -tableView:didSelectRowAtIndexPath:
 - (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
 {

     self.wkwebViewController = [[WKWebViewVC alloc] init];
     self.wkwebViewController.productURL = [_productURLS objectAtIndex:indexPath.row];
     
     [self.navigationController
      pushViewController:self.wkwebViewController
      animated:YES];

}
 
-(id) initProdcuts:(NSString*)s
{
    
    NSArray* apple = @[@"iPad", @"iPod Touch",@"iPhone"];
    NSArray* samsung = @[@"Galaxy S4", @"Galaxy Note", @"Galaxy Tab"];
    NSArray* blackBerry = @[@"BlackBerry Leap", @"BlackBerry Passport ", @"BlackBerry Z4"];
    NSArray* windows = @[@"Dell Venue Pro", @"HTC 7 Pro", @"LG Optimus 7"];
    
    if([s isEqualToString:@"apple"])
    {
        self.products = [[NSMutableArray alloc] initWithArray:apple];
    } else if([s isEqualToString:@"samsung"])
    {
        self.products = [[NSMutableArray alloc] initWithArray:samsung];
    } else if([s isEqualToString:@"blackberry"])
    {
        self.products = [[NSMutableArray alloc] initWithArray:blackBerry];
    } else if([s isEqualToString:@"windos"])
    {
        self.products = [[NSMutableArray alloc] initWithArray:windows];
    }

    return self;
}


-(id) getUrlForProducts:(NSString*)s
{
    if([s isEqualToString:@"apple"])
    {
        NSString* ipadUrl = @"https://www.apple.com/ipad/";
        NSString* ipodTouchUrl = @"https://www.apple.com/ipod-touch/";
        NSString* iphoneURL = @"https://www.apple.com/iphone/";
        
        self.productURLS = [[NSMutableArray alloc] init];
        
        [self.productURLS addObject:ipadUrl];
        [self.productURLS addObject:ipodTouchUrl];
        [self.productURLS addObject:iphoneURL];
        
    } else if([s isEqualToString:@"samsung"])
    {
        NSString* galaxyS4Url = @"https://www.samsung.com/my/smartphones/galaxy-s/";
        NSString* galaxyNoteUrl = @"https://www.samsung.com/us/mobile/galaxy-note9/";
        NSString* galaxyTabURL = @"https://www.samsung.com/us/mobile/tablets/";
        
        self.productURLS = [[NSMutableArray alloc] init];
        
        [self.productURLS addObject:galaxyS4Url];
        [self.productURLS addObject:galaxyNoteUrl];
        [self.productURLS addObject:galaxyTabURL];
    }
    
    
    
    
    return self;
}

-(id) initProductLogo:(NSString*)s
{
    if ([s isEqualToString:@"apple"])
    {
        UIImage* ipadPic = [UIImage imageNamed:@"ipadicon"];
        UIImage* ipodPic = [UIImage imageNamed:@"ipodicon"];
        UIImage* iphonePic = [UIImage imageNamed:@"iphoneicon"];
        
        
        self.logoPicuture = [[NSMutableArray alloc] init];
        [self.logoPicuture addObject: ipadPic];
        [self.logoPicuture addObject: ipodPic];
        [self.logoPicuture addObject: iphonePic];
    } else if ([s isEqualToString:@"samsung"])
    {
        UIImage* galaxySPic = [UIImage imageNamed:@"galaxysicon"];
        UIImage* galaxyNotePic = [UIImage imageNamed:@"galaxynoteicon"];
        UIImage* galaxyTab = [UIImage imageNamed:@"galaxytabicon"];
        
        
        self.logoPicuture = [[NSMutableArray alloc] init];
        [self.logoPicuture addObject: galaxySPic];
        [self.logoPicuture addObject: galaxyNotePic];
        [self.logoPicuture addObject: galaxyTab];
        
    }
    return self;

}

- (void)dealloc {
    [_tableView release];
    [super dealloc];
}
@end
