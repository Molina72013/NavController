//
//  CompanyVC.m
//  NavCtrl
//
//  Created by Jesse Sahli on 2/7/17.
//  Copyright © 2017 Aditya Narayan. All rights reserved.
//

#import "CompanyVC.h"
#import "Companies.h"
#import "Companies.h"
@interface CompanyVC ()

@end

@implementation CompanyVC

- (void)viewDidLoad {
    [super viewDidLoad];
   // [self refreshCompanyList];

    //Bar Button
    UIBarButtonItem *editButton = [[UIBarButtonItem alloc]initWithTitle:@"Edit" style:UIBarButtonItemStylePlain target:self action:@selector(toggleEditMode)];
    self.navigationItem.leftBarButtonItem = editButton;
    self.title = @"Mobile device makers";
    
    
}

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:true];
    [self refreshCompanyList];
    
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
    return [self.companyList count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
    }
    

    Company *company = [self.companyList objectAtIndex:indexPath.row];
    
    cell.textLabel.text = company.companyName;
    cell.imageView.image = [UIImage imageNamed:company.companyLogoName];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;

    return cell;
}


//ADD DELETING VERB
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        
        Company* selectedCompany = [self.companyList objectAtIndex:indexPath.row];
       
        [Companies.theCompanies deleteCompany:selectedCompany];
        [self refreshCompanyList];
       
        
        //remove the corresponding object from your data source array before this or else you will get a crash
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
    
    if(self.productViewController==nil){
        self.productViewController = [[ProductVC alloc]init];
       // self.productViewController.currentCompany = [[Company alloc] init];
    }
    
    
    Company* currCompany = [self.companyList objectAtIndex:indexPath.row];
    
    self.productViewController.title = currCompany.companyName;
    self.productViewController.currentCompany = currCompany;
    
    [self.navigationController
     pushViewController:self.productViewController
     animated:YES];
    
}
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath{
    
    return YES;
}

-(void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath{
    //Manipulate your data array.
    Company* movingCompany = [self.companyList objectAtIndex:fromIndexPath.row];
    
    [Companies.theCompanies moveCompany:movingCompany toIndex:toIndexPath.row];
    [self refreshCompanyList];
    
}

-(id) initCompanyLogo
{
    UIImage* appleLogo = [UIImage imageNamed:@"applelogo"];
    UIImage* samsungLogo = [UIImage imageNamed:@"samsunglogo"];
    UIImage* blackBerryLogo = [UIImage imageNamed:@"blackberrylogo"];
    UIImage* windowsLogo = [UIImage imageNamed:@"windowslogo"];

    self.companyLogos = [[NSMutableArray alloc] init];
    
    [self.companyLogos addObject: appleLogo];
    [self.companyLogos addObject: samsungLogo];
    [self.companyLogos addObject:blackBerryLogo];
    [self.companyLogos addObject:windowsLogo];
    
    return self;
}


-(id) initCompanies
{
//    //self.companyList = @[@"Apple mobile devices",@"Samsung mobile devices",@"BlackBerry mobile devices",@"Windows mobile devices"];
//    self.companyList = [NSMutableArray array];
//    [_companyList addObject:@"Apple mobile devices"];
//    [_companyList addObject:@"Samsung mobile devices"];
//    [_companyList addObject:@"BlackBerry mobile devices"];
//    [_companyList addObject:@"Windows mobile devices"];

    return self;
}


-(void) refreshCompanyList
{
    self.companyList = [Companies.theCompanies getAllCompanies];
}



/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

- (void)dealloc {
    [_tableView release];
    [super dealloc];
}
@end
