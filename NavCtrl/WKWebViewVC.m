//
//  WKWebViewVC.m
//  NavCtrl
//
//  Created by Cristian Molina on 8/15/18.
//  Copyright © 2018 Aditya Narayan. All rights reserved.
//

#import "WKWebViewVC.h"
#import <WebKit/WebKit.h>
#import "CreationAndEditionVC.h"


@implementation WKWebViewVC

- (void)viewDidLoad {
    UIBarButtonItem *editButton = [[UIBarButtonItem alloc]initWithTitle:@"Edit" style:UIBarButtonItemStylePlain target:self action:@selector(editButton)];
    self.navigationItem.rightBarButtonItem = editButton;

    [editButton release];
    [super viewDidLoad];
   
}

-(void) editButton
{
    CreationAndEditionVC* vc = [[CreationAndEditionVC alloc] init];
    vc.currCompanyForProduct = self.wKPCompany;
    vc.currProductForCompany = self.wkProdcut;

    [self.navigationController pushViewController:vc animated:YES];
    [vc release];
    
}

-(void) viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];

    NSURL *url = [NSURL URLWithString:_wkProdcut.prodcutURL];
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    
    _mainWebView = [[WKWebView alloc] initWithFrame:self.view.frame];
    [_mainWebView loadRequest:request];
    UIWindow *window = UIApplication.sharedApplication.keyWindow;
    CGFloat topPadding = window.safeAreaInsets.top;
    CGFloat navHeight =  self.navigationController.navigationBar.frame.size.height;
    
    float total = topPadding + navHeight;

//    (x,y,w,h)
    _mainWebView.frame = CGRectMake(self.view.frame.origin.x,total, self.view.frame.size.width, self.view.frame.size.height);
    [self.view addSubview:_mainWebView];
    
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

- (void)dealloc {
    [_mainWebView release];
    [_productURL release];
    [_wKPCompany release];
    [_wkProdcut release];
    [super dealloc];
}


@end
