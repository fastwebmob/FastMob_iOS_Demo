//
//  WebViewController.m
//  FWMob_iOS_Demo
//
//  Created by fastweb on 9/25/15.
//  Copyright © 2015 fastweb. All rights reserved.
//

#import "WebViewController.h"
#import <FWMobSDK/FWMobService.h>

@interface WebViewController ()<UIWebViewDelegate>
@property (weak, nonatomic) IBOutlet UIWebView *webView;
@property (weak, nonatomic) IBOutlet UILabel *urlLoadTime;

@property (weak, nonatomic) IBOutlet UIButton *btnGoFirstPage;
@property (weak, nonatomic) IBOutlet UIButton *btnGoForward;
@property (weak, nonatomic) IBOutlet UIButton *btnGoBack;
@property (weak, nonatomic) IBOutlet UIButton *btnRefushStop;

@property (atomic, strong) NSDate *loadStartDate;
@property (atomic, assign) float currentLoadSize;
@property (atomic, assign) float currentOriginalSize;

- (IBAction)webGoFirstPage:(id)sender;
- (IBAction)webGoForward:(id)sender;
- (IBAction)webGoBack:(id)sender;
- (IBAction)webRefushStop:(id)sender;



@end

@implementation WebViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    _webView.delegate = self;
    _webView.scalesPageToFit = YES;
    [self.view addSubview:_webView];

}

-(void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(refreshLoadTimeDataSizeInfo:) name:FW_FM_DATASIZE_NOTIFICATION object:nil];
    
    _loadStartDate = [NSDate date];
    _currentLoadSize = 0;
    _currentOriginalSize = 0;
    NSURL *URL = [NSURL URLWithString:self.loadUrlString];
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:URL];
    [_webView loadRequest:request];
}

-(void)viewDidDisappear:(BOOL)animated
{
    [super viewDidDisappear:animated];
    [[NSNotificationCenter defaultCenter] removeObserver:self name:FW_FM_DATASIZE_NOTIFICATION object:nil];
}

-(void)refreshLoadTimeDataSizeInfo:(NSNotification *)notification
{
    NSDictionary *dict = notification.userInfo;
    if([dict.allKeys containsObject:FW_FM_RESPONSEDATASIZE_NOTI_KEY]){
        NSNumber *dataSizeNumber = [dict objectForKey:FW_FM_RESPONSEDATASIZE_NOTI_KEY];
        NSNumber *originalSizeNumber = [dict objectForKey:FW_FM_RESPONSESOURCEDATASIZE_NOTI_KEY];
        _currentLoadSize += dataSizeNumber.floatValue;
        _currentOriginalSize += originalSizeNumber.floatValue;
        
        NSString *loadDataSizeString;
        if(_currentLoadSize>=1024*1024){
            loadDataSizeString = [[NSString alloc]initWithFormat:@"%0.2fM",_currentLoadSize/(1024.0*1024.0)];
        }else if(_currentLoadSize>=1024){
            loadDataSizeString = [[NSString alloc]initWithFormat:@"%0.2fK",_currentLoadSize/1024.0];
        }else{
            loadDataSizeString = [[NSString alloc]initWithFormat:@"%0.2fB",_currentLoadSize];
        }
        
        NSString *oldDataSizeString;
        if(_currentOriginalSize>=1024*1024){
            oldDataSizeString = [[NSString alloc]initWithFormat:@"%0.2fM",_currentOriginalSize/(1024.0*1024.0)];
        }else if(_currentLoadSize>=1024){
            oldDataSizeString = [[NSString alloc]initWithFormat:@"%0.2fK",_currentOriginalSize/1024.0];
        }else{
            oldDataSizeString = [[NSString alloc]initWithFormat:@"%0.2fB",_currentOriginalSize];
        }
        
        NSTimeInterval timeInterval = 0 - [_loadStartDate timeIntervalSinceNow];
        NSNumber *urlLoadTime = [[NSNumber alloc]initWithLong:(long)(timeInterval*1000)];
        
        _urlLoadTime.text = [[NSString alloc]initWithFormat:@"Load time: %zims, Data size: %@, Original size: %@", urlLoadTime.intValue, loadDataSizeString, oldDataSizeString];
        
    }
}

#pragma mark - WebView Delegate
- (void)webViewDidStartLoad:(UIWebView *)webView{
    
    [self checkWebGoBack];
    [self checkWebGoForward];
    [[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:YES];
}

- (void)webViewDidFinishLoad:(UIWebView *)webView{
    [self checkWebGoBack];
    [self checkWebGoForward];
    [_btnRefushStop setTitle:@"刷新" forState:UIControlStateNormal];
    [[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:NO];
}

-(void)checkWebGoBack{
    if ([_webView canGoBack]) {
        [_btnGoBack setTitleColor:[[UIColor alloc] initWithRed:0 green:128/255.0 blue:1 alpha:1] forState:UIControlStateNormal];
        _btnGoBack.userInteractionEnabled = true;
    }else{
        [_btnGoBack setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
    }
}

-(void)checkWebGoForward{
    if ([_webView canGoForward]) {
        [_btnGoForward setTitleColor:[[UIColor alloc] initWithRed:0 green:128/255.0 blue:1 alpha:1] forState:UIControlStateNormal];
        _btnGoForward.userInteractionEnabled = true;
    }else{
        [_btnGoForward setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
    }
}

- (void)webView:(UIWebView *)webView didFailLoadWithError:(NSError *)error{
    [[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:NO];
}

#pragma mark - WebView ButtonAction
- (IBAction)webGoFirstPage:(id)sender {
    NSURL *url = [NSURL URLWithString:self.loadUrlString];
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    [_webView loadRequest:request];
}

- (IBAction)webGoForward:(id)sender {
    if ([_webView canGoForward]) {
        [_webView goForward];
        [_btnGoBack setTitleColor:[[UIColor alloc] initWithRed:0 green:128/255.0 blue:1 alpha:1] forState:UIControlStateNormal];
    }
    [self checkWebGoForward];
}

- (IBAction)webGoBack:(id)sender {
    if ([_webView canGoBack]) {
        [_webView goBack];
        [_btnGoForward setTitleColor:[[UIColor alloc] initWithRed:0 green:128/255.0 blue:1 alpha:1] forState:UIControlStateNormal];
    }
    [self checkWebGoBack];
}

- (IBAction)webRefushStop:(id)sender {
    UIButton *btn = sender;
    if ([btn.titleLabel.text isEqualToString:@"停止"]) {
        [btn setTitle:@"刷新" forState:UIControlStateNormal];
        [_webView stopLoading];
    }else{
        [btn setTitle:@"停止" forState:UIControlStateNormal];
        [_webView reload];
    }
}

@end
