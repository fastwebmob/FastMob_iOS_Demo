//
//  ViewController.m
//  FWMob_iOS_Demo
//
//  Created by fastweb on 9/24/15.
//  Copyright © 2015 fastweb. All rights reserved.
//

#import "ViewController.h"
#import "WebViewController.h"
#import <FWMobSDK/FWMobService.h>
#import "Constants.h"

@interface ViewController ()<UITableViewDataSource,UITableViewDelegate>{
    NSArray *urlArray;
    WebViewController *webVC;
}
@property (weak, nonatomic) IBOutlet UITextField *urlEditText;

@property (weak, nonatomic) IBOutlet UITableView *urlTableView;
- (IBAction)clearCacheData:(id)sender;
- (IBAction)loadUrlAction:(id)sender;
- (IBAction)maaSwitch:(id)sender;
- (IBAction)accelerationSwitch:(id)sender;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationController.tabBarController.tabBar.hidden = true;

    urlArray = [[NSArray alloc]initWithObjects:@"http://demo.fwmob.com/", nil];
    self.urlTableView.delegate = self;
    self.urlTableView.dataSource = self;
}

#pragma mark - 加载网址URL
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *ID = @"fwmob_list_identifier";

    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];

    if (cell == nil){
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:ID];
    }
    cell.textLabel.text = [urlArray objectAtIndex:indexPath.row];
    return cell;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return urlArray.count;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [self loadVCFromStoryboard];
    webVC.loadUrlString = (NSString*)[urlArray objectAtIndex:indexPath.row];
    [self.navigationController pushViewController:webVC animated:true];
}

-(void)loadVCFromStoryboard{
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    webVC = [storyboard instantiateViewControllerWithIdentifier:@"fastweb.web"];
}

#pragma mark - Clear Cache

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex{
    if (buttonIndex == 1) {
        [self clearCacheAndExitAPP];
    }
}
-(void)clearCacheAndExitAPP{
    dispatch_async(
                   dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0)
                   , ^{
                       NSString *cachPath = [NSSearchPathForDirectoriesInDomains(NSCachesDirectory,NSUserDomainMask, YES) objectAtIndex:0];
                       
                       NSArray *files = [[NSFileManager defaultManager] subpathsAtPath:cachPath];
                       
                       for (NSString *p in files) {
                           NSError *error;
                           NSString *path = [cachPath stringByAppendingPathComponent:p];
                           if ([[NSFileManager defaultManager] fileExistsAtPath:path]) {
                               [[NSFileManager defaultManager] removeItemAtPath:path error:&error];
                           }
                       }
                       [self performSelectorOnMainThread:@selector(clearCacheSuccess) withObject:nil waitUntilDone:YES];});
}

-(void)clearCacheSuccess
{
    exit(0);
}

- (IBAction)clearCacheData:(id)sender {
    UIAlertView *alertview = [[UIAlertView alloc]initWithTitle:@"警告!" message:@"为确保彻底清除缓存，需要退出应用，确定清缓存吗？" delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"确定", nil];
    
    [alertview show];
}

- (IBAction)loadUrlAction:(id)sender {
    [self loadVCFromStoryboard];
    webVC.loadUrlString = self.urlEditText.text;
    [self.navigationController pushViewController:webVC animated:true];
}

- (IBAction)maaSwitch:(id)sender {
    UISwitch *maaSwitchBtn = (UISwitch*)sender;
    if ([maaSwitchBtn isOn]) {
        [FWMobService start:APP_DEV_KEY];
    }else{
        [FWMobService stop];
    }
}

- (IBAction)accelerationSwitch:(id)sender {
    UISwitch *acceleSwitch = (UISwitch*)sender;
    [FWMobService enableAccelerate:acceleSwitch.on];
}
@end
