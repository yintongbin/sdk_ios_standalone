//
//  seastar_spg_sdkVC.m
//  seastar_spg_sdk
//
//  Created by seastar on 16/3/4.
//  Copyright © 2016年 seastar. All rights reserved.
//

#import "seastar_spg_sdkVC.h"
#import "FacebookHelper.h"
#import "GameCenterHelper.h"
#import "IAP.h"
@interface seastar_spg_sdkVC ()

@end
static seastar_spg_sdkVC *_instance;
@implementation seastar_spg_sdkVC
+(seastar_spg_sdkVC *)Instance
{
    if(!_instance)
    {
        _instance = [[seastar_spg_sdkVC alloc]init];
    }
    return _instance;
}

-(void)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    [[FacebookHelper Instance]application:application didFinishLaunchingWithOptions:launchOptions];
    
}

-(BOOL)application:(UIApplication *)application openURL:(NSURL *)url sourceApplication:(NSString *)sourceApplication annotation:(id)annotation
{
    return
    [[FacebookHelper Instance]application:application openURL:url sourceApplication:sourceApplication annotation:annotation];
}

-(void)activateApp
{
    [[FacebookHelper Instance]activateApp];
}

-(void)ifacebookLoginWithViewController:(UIViewController *)viewController
{
    [[FacebookHelper Instance]loginWithViewController:viewController];
}

-(void)ifacebookLogOut
{
    [[FacebookHelper Instance]logOut];
}

-(void)igamecenterLoginWithViewController:(UIViewController *)viewController
{
    [[GameCenterHelper Instance]authenticateLocalUserWithViewController:viewController];
}



-(void)shareWithContentStr:(NSString *)contentStr ContentDescription:(NSString *)contentDescription ContentTitle:(NSString *)contentTitle ImageStr:(NSString *)imageStr WithViewController:(UIViewController *)viewController
{
    [[FacebookHelper Instance]shareWithContentStr:contentStr ContentDescription:contentDescription ContentTitle:contentTitle ImageStr:imageStr WithViewController:viewController];
}

-(void)buyWithProduct:(NSString *)product
{
    [[IAP Instance]buyWithProduct:product];
}

-(void)initWithDelegate:(id<seastar_spg_sdkDelegate>)delegate
{
    self.delegate = delegate;
}

-(void)addTransactionObserver
{
    [[IAP Instance]addTransactionObserver];
}

-(void)removeTransactionObserver
{
    [[IAP Instance]removeTransactionObserver];
}

@end
