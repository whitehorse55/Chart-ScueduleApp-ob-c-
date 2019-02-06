//
//  ANLWebViewController.m
//  Chrono
//
//  Created by Amador Navarro Lucas on 14/10/14.
//  Copyright (c) 2014 Amador Navarro Lucas. All rights reserved.
//

#import <AddressBookUI/AddressBookUI.h>

#import "ANLWebViewController.h"
#import "ANLTabBar.h"



@interface ANLWebViewController ()

@property (strong, nonatomic) CLLocationManager *manager;
@property (strong, nonatomic) NSURL *webURL;
@property (strong, nonatomic) NSDictionary *URLs;
@property (strong, nonatomic) UIActivityIndicatorView *activityView;
@property (strong, nonatomic) UIView *fakeView;

@property (weak, nonatomic) IBOutlet UIBarButtonItem *closeButton;

@end



@implementation ANLWebViewController

- (void)viewDidLoad {
    
    [super viewDidLoad];
    //  Creamos una view en blanco para ocultar el fondo de la webView
    [self setFakeView:[[UIView alloc] initWithFrame:[[self view] bounds]]];
    [[self fakeView] setBackgroundColor:[UIColor colorForBackgroundGrey]];
    [[self view] addSubview:[self fakeView]];
    
    [self setWebURL:[NSURL URLWithString:[[self URLs] objectForKey:@"VOID"]]];
}

-(void)viewWillAppear:(BOOL)animated {
    
    [super viewWillAppear:animated];

    [(ANLTabBar *)[[self tabBarController] tabBar] hideTabBarAnimated:NO];
//    [self.tabBarController.tabBar setHidden:YES];
//    [[[self tabBarController] tabBar] setHidden:YES];
    
    
    [[self closeButton] setTitle:[Language stringForKey:@"webView.closeButton.title"]];
    
    CLAuthorizationStatus status = [CLLocationManager authorizationStatus];
    if (status != kCLAuthorizationStatusDenied && status != kCLAuthorizationStatusRestricted) {
        
        CLLocationManager *lm = [[CLLocationManager alloc] init];
        if ([lm respondsToSelector:@selector(requestWhenInUseAuthorization)]) {
            
            [lm requestWhenInUseAuthorization];
        }
        [lm setDelegate:self];
        [lm setDesiredAccuracy:kCLLocationAccuracyNearestTenMeters];
        [lm setDistanceFilter:10];
        [lm startUpdatingLocation];
        [self setManager:lm];
    }
}

-(void)viewDidDisappear:(BOOL)animated {
    
    [super viewDidDisappear:animated];
}

-(void)loadWeb {
    
    [[self webView] loadRequest:[NSURLRequest requestWithURL:[self webURL]]];
}

- (void)didReceiveMemoryWarning {
    
    [super didReceiveMemoryWarning];
}



#pragma mark - setters and getters

-(UIActivityIndicatorView *)activityView {
    
    if (_activityView) {
        
        return _activityView;
    }
    UIActivityIndicatorView *activity = [[UIActivityIndicatorView alloc]
                                         initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleWhiteLarge];
    
    [activity setFrame:CGRectMake(0, 0, 50, 50)];
    [activity setCenter:[[self view] center]];
    [activity setColor:[UIColor darkGrayColor]];
    
    [[self view] addSubview:activity];
    _activityView = activity;
    return _activityView;
}

-(void)setWebURL:(NSURL *)webURL {
    
    if (_webURL != webURL) {
        
        _webURL = webURL;
        [self loadWeb];
    }
}

-(NSDictionary *)URLs {
    
    if (_URLs) {
        
        return _URLs;
    } else {
        
        _URLs = @{@"ES" : @"http://www.institutolean.org/lean-app",
                  @"NL" : @"http://www.leaninstituut.nl",
                  @"US" : @"http://www.lean.org",
                  @"GB" : @"http://www.leanuk.org",
                  @"BR" : @"http://www.lean.org.br",
                  @"PL" : @"http://lean.org.pl",
                  @"FR" : @"http://www.lean.enst.fr",
                  @"AU" : @"http://www.lean.org.au",
                  @"CN" : @"http://www.leanchina.org",
                  @"TR" : @"http://www.yalinenstitu.org.tr",
                  @"IN" : @"http://www.yalinenstitu.org.tr",
                  @"ZA" : @"http://www.lean.org.za",
                  @"IT" : @"http://www.istitutolean.it",
                  @"IL" : @"http://www.worldview.biz",
                  @"HU" : @"http://www.lean.org.hu",
                  @"VOID" : @"http://www.leanglobal.org"};
    }
    return _URLs;
}



#pragma mark - Actions

- (IBAction)closeButtonPushed:(id)sender {
    
    [[self tabBarController] setSelectedIndex:0];
}



#pragma mark - UIWebViewDelegate

-(BOOL)webView:(UIWebView *)webView shouldStartLoadWithRequest:(NSURLRequest *)request
                                                navigationType:(UIWebViewNavigationType)navigationType {
    
    return [[[self webURL] host] isEqualToString:[[request URL] host]];
}

-(void)webViewDidStartLoad:(UIWebView *)webView {
    
    [[self activityView] startAnimating];
}

-(void)webViewDidFinishLoad:(UIWebView *)webView {
    
    [[self activityView] stopAnimating];
    [[self navigationItem] setTitle:[[[webView request] URL] host]];

    if ([self fakeView]) {
        
        [[self fakeView] removeFromSuperview];
        [self setFakeView:nil];
    }
}



#pragma mark - CLLocationManagerDelegate

-(void)locationManager:(CLLocationManager *)manager didUpdateLocations:(NSArray *)locations {
    
    CLGeocoder *geocoder = [[CLGeocoder alloc] init];
    [geocoder reverseGeocodeLocation:[locations lastObject] completionHandler:^(NSArray *placemarks, NSError *error) {
        
        NSDictionary *dic = [[placemarks objectAtIndex:0] addressDictionary];
        NSString *country = [dic objectForKey:@"CountryCode"];
        if (country) {
            
            [self setWebURL:[NSURL URLWithString:[[self URLs] objectForKey:country]]];
        }
    }];
    [[self manager] stopUpdatingLocation];
}

@end
