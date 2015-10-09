//
//  WebViewController.m
//  FWMob_iOS_Demo
//
//  Created by fastweb on 9/25/15.
//  Copyright © 2015 fastweb. All rights reserved.
//

#import "WebViewController.h"

@interface WebViewController ()<UIWebViewDelegate>
@property (weak, nonatomic) IBOutlet UIWebView *webView;
@property (weak, nonatomic) IBOutlet UILabel *urlLoadTime;
@property (weak, nonatomic) IBOutlet UILabel *urlLoadData;

@property (weak, nonatomic) IBOutlet UIButton *btnGoFirstPage;
@property (weak, nonatomic) IBOutlet UIButton *btnGoForward;
@property (weak, nonatomic) IBOutlet UIButton *btnGoBack;
@property (weak, nonatomic) IBOutlet UIButton *btnRefushStop;
- (IBAction)webGoFirstPage:(id)sender;
- (IBAction)webGoForward:(id)sender;
- (IBAction)webGoBack:(id)sender;
- (IBAction)webRefushStop:(id)sender;



@end

@implementation WebViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(refushLoadTimeDataSize:) name:@"currentTimeAndDataNotification" object:nil];
    
    NSURL *URL = [NSURL URLWithString:self.loadUrlString];
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:URL];
    [_webView loadRequest:request];
    _webView.delegate = self;
    _webView.scalesPageToFit = YES;
    [self.view addSubview:_webView];

}
-(void)refushLoadTimeDataSize:(NSNotification *)notification{
    NSDictionary *dic = notification.userInfo;
    if([dic.allKeys containsObject:@"urlAllData"]){
        
        _urlLoadData.text = [[NSString alloc]initWithFormat:@"Data size: %@",[dic valueForKey:@"urlAllData"]];
    }
    if ([dic.allKeys containsObject:@"urlAllTime"]) {
        _urlLoadTime.text = [[NSString alloc]initWithFormat:@"Load time: %@s",[dic valueForKey:@"urlAllTime"]];
    }
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
