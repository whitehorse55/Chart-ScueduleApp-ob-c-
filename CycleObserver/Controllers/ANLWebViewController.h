//
//  ANLWebViewController.h
//  Chrono
//
//  Created by Amador Navarro Lucas on 14/10/14.
//  Copyright (c) 2014 Amador Navarro Lucas. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreLocation/CoreLocation.h>



@interface ANLWebViewController : UIViewController <UIWebViewDelegate, CLLocationManagerDelegate>

@property (weak, nonatomic) IBOutlet UIWebView *webView;

@end
