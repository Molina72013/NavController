//
//  CompanyVC.m
//  NavCtrl
//
//  Created by Jesse Sahli on 2/7/17.
//  Copyright © 2017 Aditya Narayan. All rights reserved.
//

#import "CompanyVC.h"
//#import "CompnayMO+CoreDataClass.h"

static NSString *CellIdentifier = @"Cell";

@interface CompanyVC () <UIUpdateDelegate>

@end

@implementation CompanyVC

- (void)viewDidLoad {
    [super viewDidLoad];

    UIBarButtonItem *editButton = [[UIBarButtonItem alloc]initWithTitle:@"Edit" style:UIBarButtonItemStylePlain target:self action:@selector(toggleEditMode)];
    UIBarButtonItem *plusButton = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemAdd target:self action:@selector(plusButtonHit)];

    self.navigationItem.rightBarButtonItem = plusButton;
    self.navigationItem.leftBarButtonItem = editButton;
    self.title = @"Watch List";

    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSLog(@"%@", [paths objectAtIndex:0]);
    [self everyMinute];
    self.navigationController.navigationBar.barTintColor = [UIColor colorWithRed:125.0/255.0 green:181.0/255.0 blue:6.0/255.0 alpha:1.0];
    self.navigationController.navigationBar.tintColor = UIColor.whiteColor;
    self.navigationController.navigationBar.titleTextAttributes = @{NSForegroundColorAttributeName : [UIColor whiteColor],
                                                                    NSFontAttributeName: [UIFont fontWithName:@"HelveticaNeue-Bold" size:20]
                                                                    };
    Companies.theCompanies.viewControllerDelegate = self;
    [editButton release];
    [plusButton release];

}
-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:true];
    [self refreshCompanyList];
    [self.tableView setEditing:NO animated:YES];
    self.navigationItem.leftBarButtonItem.title = @"Edit";
    [_tableView reloadData];
}


-(void) plusButtonHit
{

    CreationAndEditionVC *vc =  [[CreationAndEditionVC alloc]init];
    vc.currCompany = nil;
    
    [self.navigationController
     pushViewController:vc
     animated:YES];
    [vc release];
    
}



- (void)toggleEditMode {
    
    if (self.tableView.editing) {
        [self.tableView setEditing:NO animated:YES];
        self.navigationItem.leftBarButtonItem.title = @"Edit";
    } else {
        [self.tableView setEditing:YES animated:NO];
        self.navigationItem.leftBarButtonItem.title = @"Done";
        _tableView.allowsSelectionDuringEditing = true;
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

    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    CompnayMO* company = [self.companyList objectAtIndex:indexPath.row];
    NSURL *url = [NSURL URLWithString:company.logo];

    
    
    if (cell == nil) {
        cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:CellIdentifier] autorelease];

    }

    
    [cell.textLabel setFont:[UIFont systemFontOfSize:24]];
    [cell.detailTextLabel setFont:[UIFont boldSystemFontOfSize:14]];
    
    if([company.api isEqualToString:@""])
    {
        cell.textLabel.text = [NSString stringWithFormat:@"%@",company.name];

    } else
    {
        cell.textLabel.text = [NSString stringWithFormat:@"%@ (%@)",company.name, company.api];

    }
    cell.detailTextLabel.textColor  = [[UIColor blackColor] colorWithAlphaComponent:0.75f];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.detailTextLabel.text = [NSString stringWithFormat:@"%.2f",company.apiValue];
    
    
    cell.imageView.image = nil;

    
    NSURLSessionDataTask* cellImaging = [[NSURLSession sharedSession] dataTaskWithURL:url completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        if(!data)
        {
            return;
        }

        dispatch_sync(dispatch_get_main_queue(), ^{
            cell.imageView.image = [UIImage imageWithData:data];
            CGSize itemSize = CGSizeMake(60, 60);
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

    
    
    


- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 75;
}
//ADD DELETING VERB
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    
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


#pragma mark - Table view delegate

// In a xib-based application, navigation from a table can be handled in -tableView:didSelectRowAtIndexPath:
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    CompnayMO* currCompany = [self.companyList objectAtIndex:indexPath.row];// autorelease];

    
    
    if (self.tableView.editing)
    {
//        if(self.creationViewController==nil){
//            self.creationViewController = [[CreationAndEditionVC alloc]init];
//        }

        CreationAndEditionVC *vc =  [[CreationAndEditionVC alloc]init];
        
   //     CompnayMO* currCompany = [self.companyList objectAtIndex:indexPath.row];
        
        vc.currCompany = currCompany;
        [self.navigationController
         pushViewController:vc
         animated:YES];

        [vc release];



        
        }
     else
    {
        ProductVC* pvc = [[ProductVC alloc] init];
        pvc.currentCompany = currCompany;
        pvc.title = currCompany.name;
        
        [self.navigationController
         pushViewController:pvc
         animated:YES];
        
        self.navigationItem.backBarButtonItem = [[[UIBarButtonItem alloc] initWithTitle:@"" style:UIBarButtonItemStylePlain target:nil action:nil] autorelease];
        [pvc release];
    }
}



- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath{
    
    return YES;
}



-(void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath{

    
    CompnayMO* selectedCompany = [_companyList objectAtIndex:fromIndexPath.row];
    [Companies.theCompanies moveCompany:selectedCompany from:fromIndexPath.row toIndex:toIndexPath.row];
    [self refreshCompanyList];
    [self.tableView reloadData];
}





-(void) refreshCompanyList
{
    self.companyList = [Companies.theCompanies getAllCompanies];
    NSLog(@" THE COUNT IS %lu", _companyList.count);
    
    if(_companyList.count > 0)
    {
        [_emptyArrayView setHidden:true];
    } else
    {
        [_emptyArrayView setHidden:false];

    }
}


- (void)dealloc {
    [_tableView release];
    [_companyList release];
    [_emptyArrayView release];
    [_productViewController release];
    [super dealloc];
}

- (void)updateUI {
    [self refreshCompanyList];
    [_tableView reloadData];
}


-(void) everyMinute
{
     NSDate *d = [NSDate dateWithTimeIntervalSinceNow: 0.0];
    NSTimer *t = [[NSTimer alloc] initWithFireDate: d
                                          interval: 60
                                            target: self
                                          selector:@selector(onTick:)
                                          userInfo:nil repeats:YES];
    
    NSRunLoop *runner = [NSRunLoop currentRunLoop];
    [runner addTimer:t forMode: NSDefaultRunLoopMode];
    [t release];
}


-(void) onTick:(NSTimer *)timer {
{
    NSLog(@"onTick");
    [Companies.theCompanies getAllApi];
    
}
    
    
}
    
- (IBAction)addButton:(id)sender {
    [self plusButtonHit];
}
@end


