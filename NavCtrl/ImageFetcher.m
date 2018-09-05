//
//  ImageFetcher.m
//  NavCtrl
//
//  Created by Cristian Molina on 8/29/18.
//  Copyright © 2018 Aditya Narayan. All rights reserved.
//

#import "ImageFetcher.h"
#import "Companies.h"
@implementation ImageFetcher
- (void)showImageFor:(CompnayMO*)company
{
    //    _shownImage.image = [UIImage imageWithData:[NSData dataWithContentsOfURL:[NSURL URLWithString:@"https://www.google.com/images/srpr/logo6w.png"]]];
    NSString* urlString = company.logo;
    
    NSURL *url = [NSURL URLWithString:urlString];
    

    
    NSURLSessionDataTask *downloadTask = [[NSURLSession sharedSession]
                                          dataTaskWithURL:url completionHandler:^(NSData *data, NSURLResponse *response, NSError *error) {
                                               if (error) {
                                                   NSLog(@"ERRRROR");
                                                   return;
                                               }
                                              
//                                              UIImage *downloadedImage = [UIImage imageWithData: data];
                                              
                                            //  NSData* sendingData = data;
//                                              NSData *dataObj =UIImagePNGRepresentation(downloadedImage);
                                              dispatch_async(dispatch_get_main_queue(), ^{
                                           
//                                                  [Companies.theCompanies giveImage:company data:dataObj];

                                                  
                                                  
                                              });
                                              
                                          }];
    
    // 3
    [downloadTask resume];
    
    
    
}
@end
