//
//  seastar_spg_sdkVC.h
//  seastar_spg_sdk
//
//  Created by seastar on 16/3/4.
//  Copyright © 2016年 seastar. All rights reserved.
//
#include <string>
#import <UIKit/UIKit.h>
#import <FBSDKLoginKit/FBSDKLoginKit.h>
#import <FBSDKCoreKit/FBSDKCoreKit.h>

@interface seastar_spg_sdkVC : UIViewController

@property (nonatomic,strong)UIViewController *viewController;
@property (nonatomic,assign)BOOL Login;
+(seastar_spg_sdkVC *)Instance;

-(void)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions;
-(BOOL)application:(UIApplication *)application openURL:(NSURL *)url sourceApplication:(NSString *)sourceApplication annotation:(id)annotation;
-(void)activateApp;

-(void)facebookLogin;

-(void)ifacebookLogOut;

-(void)igamecenterLoginWithViewController:(UIViewController *)viewController;

-(void)shareWithContentStr:(NSString *)contentStr ContentDescription:(NSString *)contentDescription ContentTitle:(NSString *)contentTitle ImageStr:(NSString *)imageStr WithViewController:(UIViewController *)viewController;
-(void)shareWithImageStr:(NSString *)imageStr WithViewController:(UIViewController *)viewController;
-(void)inviteFriendsWithAppLinkURLString:(NSString *)appLinkURLString WithAppImageURLString:(NSString *)appImageURLString WithViewController:(UIViewController *)viewController;


-(void)buyWithProduct:(NSString *)product;

-(void)addTransactionObserver;
-(void)removeTransactionObserver;


@end


void onFacebookLoginCallBack(bool loginSuccess,std::string loginJson);

