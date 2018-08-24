//
//  CreationAndEditionVC.m
//  NavCtrl
//
//  Created by Cristian Molina on 8/20/18.
//  Copyright © 2018 Aditya Narayan. All rights reserved.
//

#import "CreationAndEditionVC.h"
#import "Companies.h"
#import "CompanyVC.h"
#import "NavControllerAppDelegate.h"

@interface CreationAndEditionVC () {

    int distance;
  //  CGRect oldFrame;
    CGRect newFrame;
    
}
@end

@implementation CreationAndEditionVC

- (void)viewDidLoad {
    [super viewDidLoad];
   UIBarButtonItem *cancelButton = [[UIBarButtonItem alloc]initWithTitle:@"Cancel" style:UIBarButtonItemStylePlain target:self action:@selector(cancel)];
    UIBarButtonItem *saveButton = [[UIBarButtonItem alloc]initWithTitle:@"Save" style:UIBarButtonItemStylePlain target:self action:@selector(save)];
    
    self.navigationItem.rightBarButtonItem = saveButton;
    self.navigationItem.leftBarButtonItem = cancelButton;

    
    //making the textfield confrom the the textfielddelegates
    self.companyNameInput.delegate = self;
    self.companyURLInput.delegate = self;
    self.apiInput.delegate = self;
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWasShown:) name:UIKeyboardWillShowNotification object:nil];
    
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keybaordWillHide:) name:UIKeyboardWillHideNotification object:nil];
    // Do any additional setup after loading the view from its nib.

    [self updateTextFields];

}

-(void) viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:true];
    [self.view endEditing:true];



    if(_currCompany != nil)
    {
        _companyNameInput.text = _currCompany.companyName;
        _companyURLInput.text = _currCompany.companyLogoURL;
    } else
    {
        _companyNameInput.text = @"";
        _companyURLInput.text = @"";
    }
    

    
    
    //[self.companyNameInput endEditing:YES];
    
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    UIWindow *window = UIApplication.sharedApplication.keyWindow;
    
    NSLog(@"view y: %f", window.safeAreaInsets.top);
    NSLog(@"view y: %f", self.navigationItem.titleView.frame.size.height);
     NSLog(@"view y: %f", self.theView.frame.origin.y);
}

-(void) updateTextFields
{
    _apiInput.placeholder = @"Company API";
    _companyNameInput.placeholder = @"Name Of Company";
    _companyURLInput.placeholder = @"Company Image for Logo URL";

}

-(void) viewDidDisappear:(BOOL)animated
{
    [super viewDidDisappear:true];
 //    [[NSNotificationCenter defaultCenter] removeObserver:self name:UIKeyboardWillShowNotification object:nil];
//    [[NSNotificationCenter defaultCenter] removeObserver:self name:UIKeyboardWillHideNotification object:nil];
//

    
}


-(void) keyboardWasShown:(NSNotification *)notification
{

//    //GET THE FRAME FOR THE KEYBOARD

    NSValue* keyboardEndFramValue = [[notification userInfo] objectForKey:UIKeyboardFrameEndUserInfoKey];
    CGRect keybaordEngFrame = [keyboardEndFramValue CGRectValue];

    //GET THE KEYBAORD DUATION TIME
    NSNumber* animationDurationNumber = [[notification userInfo] objectForKey:UIKeyboardAnimationDurationUserInfoKey];
    NSTimeInterval animationDuration = [animationDurationNumber doubleValue];

    NSNumber* animationCurveNumber = [[notification userInfo] objectForKey:UIKeyboardAnimationCurveUserInfoKey];
    UIViewAnimationCurve animationCurve = [animationCurveNumber intValue];
    UIViewAnimationOptions animationOptions = animationCurve << 16;

    [UIView animateWithDuration:animationDuration //NSTimeInterval
                          delay:0.0
                        options:animationOptions //UIViewAnimationOptions
                     animations:^{
                          CGRect textFieldFrame = newFrame;
   
                         textFieldFrame.origin.y = (textFieldFrame.origin.y - keybaordEngFrame.origin.y) +
                         textFieldFrame.size.height + 5;
                         //self.theView.frame = textFieldFrame;
                        // distance = self.theView.frame.origin.y;
                         CGRect theViewFrame = self.theView.frame;
                         //
                         //
                         theViewFrame.origin.y = (int)-textFieldFrame.origin.y;
                  
                         //distance = (int)-textFieldFrame.origin.y;

                         [self.theView setTranslatesAutoresizingMaskIntoConstraints:true];

                         self.theView.frame = theViewFrame;

                     }
                     completion:^(BOOL finished) {

                   }];
    
}

-(void) keybaordWillHide:(NSNotification *)notification
{

//    NSNumber *animationDurationNumber = [[notification userInfo] objectForKey:UIKeyboardAnimationDurationUserInfoKey];
//    NSTimeInterval animationDuration = [animationDurationNumber doubleValue];
//
//    NSNumber *animationCurveNumber = [[notification userInfo] objectForKey:UIKeyboardAnimationCurveUserInfoKey];
//    UIViewAnimationCurve animationCurve = [animationCurveNumber intValue];
//    UIViewAnimationOptions animationOptions = animationCurve << 16;
//
//    [UIView animateWithDuration:animationDuration
//                          delay:0.0
//                        options:animationOptions
//                     animations:^{
//
//                     }
//                     completion:^(BOOL finished){
//                         [self.theView setTranslatesAutoresizingMaskIntoConstraints:false];
//
//                     }];
    [self.theView setTranslatesAutoresizingMaskIntoConstraints:false];

    
}



//- (void) animateUp: (BOOL) up
//{
//    CGRect screenRect = [[UIScreen mainScreen] bounds];
//   // CGFloat screenWidth = screenRect.size.width;
//    CGFloat screenHeight = screenRect.size.height;
//
//    const int movementDistance = screenHeight / distance ; // tweak as needed
//    const float movementDuration = 0.2f; // tweak as needed
//
//    int movement = (up ? -movementDistance : movementDistance);
//
//    [UIView beginAnimations: @"anim" context: nil];
//    [UIView setAnimationBeginsFromCurrentState: YES];
//    [UIView setAnimationDuration: movementDuration];
//    self.view.frame = CGRectOffset(self.view.frame, 0, movement);
//    [UIView commitAnimations];
//}




//  Activates when keybaord pops out
- (void)textFieldDidBeginEditing:(UITextField *)textField
{

    newFrame = textField.frame;

}

- (void)textFieldDidEndEditing:(UITextField *)textField
{

}


-(BOOL) textFieldShouldReturn:(UITextField *)textField
{

    [textField resignFirstResponder];
    
    return true;
}





-(void) cancel
{
    
    
//
    [self.view endEditing:true];

    [self dismissViewControllerAnimated:NO completion:nil];
    [self.navigationController popToRootViewControllerAnimated:YES];

}

-(void) save
{
    if(_currCompany == nil)
    {
        if(![_companyNameInput.text  isEqual: @""] && ![_companyURLInput.text  isEqual: @""])
        {
            [Companies.theCompanies addCompany:_companyNameInput.text api:_apiInput.text logo:_companyURLInput.text];
            NSLog(@"Runnign this");
            [self.view endEditing:true];
            [self dismissViewControllerAnimated:NO completion:nil];
            [self.navigationController popToRootViewControllerAnimated:YES];

        }
    }
        
    else
    {
        //[Companies.theCompanies addCompany:_companyNameInput.text logo:_companyURLInput.text];
        
        if(![_companyNameInput.text  isEqual: @""] && ![_companyURLInput.text  isEqual: @""])
        {
            [Companies.theCompanies editCompany:_currCompany editedName:_companyNameInput.text editedLogo:_companyURLInput.text];
            //  NSLog(@"Nothing on name and url");
            [self.view endEditing:true];
            [self dismissViewControllerAnimated:NO completion:nil];
            [self.navigationController popToRootViewControllerAnimated:YES];
            
        }
        
    }

}





- (void)dealloc {
    
    [[ NSNotificationCenter defaultCenter ] removeObserver:self ];

    
    [_companyNameInput release];
    [_companyURLInput release];
    [_apiInput release];
    [_currCompany release];
    [_scrollView release];
    [_theView release];
    [_topConstraint release];
    [_centercon release];
    [super dealloc];
}
@end
