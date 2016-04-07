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
@property (nonatomic,assign)bool successShare;
//@property (nonatomic,strong)GameCenterLoginInfo *gamecenterLogininfo;
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

-(UIViewController *)viewController
{
    if(!_viewController)
    {
        _viewController = [UIViewController new];
    }
    return _viewController;
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

-(void)facebookLogin
{

    [[FacebookHelper Instance]loginWithViewController:self.viewController WithCallback:^(NSString *LoginJson, bool LoginSuccess) {
        const char *loginJson = [LoginJson UTF8String];
        bool success = LoginSuccess;
        //onFacebookLoginCallBack(success, loginJson);
    }];
}


-(void)ifacebookLogOut
{
    [[FacebookHelper Instance]logOut];
}


-(void)igameCenterLogin
{
    [[GameCenterHelper Instance]authenticateLocalUserWithViewController:self.viewController WithCallBack:^(NSString *jsonStr, bool loginSuccess) {
        const char *gameCenterLoginCallBack = [jsonStr UTF8String];
        bool success = loginSuccess;
        
    }];
}


-(void)shareWithContentStr:(NSString *)contentStr ContentDescription:(NSString *)contentDescription ContentTitle:(NSString *)contentTitle ImageStr:(NSString *)imageStr
{
    [[FacebookHelper Instance]shareWithContentStr:contentStr ContentDescription:contentDescription ContentTitle:contentTitle ImageStr:imageStr WithViewController:self.viewController];
//    [FacebookHelper Instance].successShare = ^(bool success)
//    {
//        self.successShare = success;
//    };
}

-(void)shareWithImageStr:(NSString *)imageStr
{
    [[FacebookHelper Instance]shareWithImageStr:imageStr WithVIewController:self.viewController];
}

-(void)inviteFriendsWithAppLinkURLString:(NSString *)appLinkURLString WithAppImageURLString:(NSString *)appImageURLString
{
    [[FacebookHelper Instance]inviteFriendsWithAppLinkURLString:appLinkURLString WithAppImageURLString:appImageURLString WithViewController:self.viewController];
}


-(void)buyWithProduct:(NSString *)product
{
    [[IAP Instance]buyWithProduct:product];
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

void doFacebookLogin()
{
    [[seastar_spg_sdkVC Instance] facebookLogin];
}

//void onFacebookLoginCallBack(bool loginSuccess,std::string loginJson )
//{
//    //登陆回调
//}








