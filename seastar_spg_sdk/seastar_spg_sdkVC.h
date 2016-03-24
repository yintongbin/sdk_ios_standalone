//
//  seastar_spg_sdkVC.h
//  seastar_spg_sdk
//
//  Created by seastar on 16/3/4.
//  Copyright © 2016年 seastar. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <FBSDKLoginKit/FBSDKLoginKit.h>
#import <FBSDKCoreKit/FBSDKCoreKit.h>
#import "FacebookLoginInfo.h"
@protocol seastar_spg_sdkDelegate <NSObject>
-(UIViewController *)getController;
@end

@interface seastar_spg_sdkVC : UIViewController

@property (nonatomic,assign)id<seastar_spg_sdkDelegate>delegate;


@property (nonatomic,assign)BOOL Login;
//@property (nonatomic,strong)NSString *facebookLoginInfo;
+(seastar_spg_sdkVC *)Instance;

-(void)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions;
-(BOOL)application:(UIApplication *)application openURL:(NSURL *)url sourceApplication:(NSString *)sourceApplication annotation:(id)annotation;
-(void)activateApp;

-(void)ifacebookLoginWithViewController:(UIViewController *)viewController;
-(void)doFacebookLogin;

-(void)ifacebookLogOut;

-(void)igamecenterLoginWithViewController:(UIViewController *)viewController;
-(void)initWithDelegate:(id<seastar_spg_sdkDelegate>)delegate;

-(void)shareWithContentStr:(NSString *)contentStr ContentDescription:(NSString *)contentDescription ContentTitle:(NSString *)contentTitle ImageStr:(NSString *)imageStr WithViewController:(UIViewController *)viewController;
-(void)shareWithImageStr:(NSString *)imageStr WithViewController:(UIViewController *)viewController;
-(void)inviteFriendsWithAppLinkURLString:(NSString *)appLinkURLString WithAppImageURLString:(NSString *)appImageURLString WithViewController:(UIViewController *)viewController;


-(void)buyWithProduct:(NSString *)product;

-(void)addTransactionObserver;
-(void)removeTransactionObserver;



@end

void doLogin();
void doLoginCb();
