//
//  FacebookHelper.h
//  seastar_spg_sdk
//
//  Created by seastar on 16/3/4.
//  Copyright © 2016年 seastar. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <FBSDKCoreKit/FBSDKCoreKit.h>
#import <FBSDKLoginKit/FBSDKLoginKit.h>
#import <FBSDKShareKit/FBSDKShareKit.h>
#import "FacebookLoginInfo.h"

@interface FacebookHelper : NSObject
//@property (nonatomic,copy)void(^FacebookLoginCallBack)(BOOL facebookLogin,FacebookLoginInfo *facebookLoginInfo);

@property (nonatomic,copy)void(^facebookLoginCallBack)(FacebookLoginInfo *info);
@property (nonatomic,copy)void(^successShare)(bool success);
+(FacebookHelper *)Instance;

-(void)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions;
-(BOOL)application:(UIApplication *)application openURL:(NSURL *)url sourceApplication:(NSString *)sourceApplication annotation:(id)annotation;
-(void)activateApp;

-(void)loginWithViewController:(UIViewController *)viewController;
-(void)logOut;

-(void)shareWithContentStr:(NSString *)contentStr ContentDescription:(NSString *)contentDescription ContentTitle:(NSString *)contentTitle ImageStr:(NSString *)imageStr WithViewController:(UIViewController *)viewController;
-(void)shareWithImageStr:(NSString *)imageStr WithVIewController:(UIViewController *)viewController;

-(void)inviteFriendsWithAppLinkURLString:(NSString *)appLinkURLString WithAppImageURLString:(NSString *)appImageURLString WithViewController:(UIViewController *)viewController;

@end
