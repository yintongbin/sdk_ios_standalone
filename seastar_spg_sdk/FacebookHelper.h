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
#import <UIKit/UIKit.h>

typedef void(^LoginCallBack)(NSString *LoginJson,bool LoginSuccess);
typedef void(^shareContentCallBack)(bool shareContentSuccess);
typedef void(^shareImageCallBack)(bool shareImageSuccess);
typedef void(^inviteFriends)(bool inviteSuccess);
typedef void(^friendlist)(NSString *friendlist,bool friendSuccess);
@interface FacebookHelper : NSObject

+(FacebookHelper *)Instance;

@property (nonatomic,strong)LoginCallBack Logincallback;
@property (nonatomic,strong)shareContentCallBack shareContentCallBack;
@property (nonatomic,strong)shareImageCallBack shareImageCallBack;
@property (nonatomic,strong)inviteFriends inviteCallBack;
@property (nonatomic,strong)friendlist friendCallBack;

-(void)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions;
-(BOOL)application:(UIApplication *)application openURL:(NSURL *)url sourceApplication:(NSString *)sourceApplication annotation:(id)annotation;
-(void)activateApp;

-(void)loginWithViewController:(UIViewController *)viewController WithCallback:(LoginCallBack)callback;
-(void)logOut;

-(void)shareWithContentStr:(NSString *)contentStr ContentDescription:(NSString *)contentDescription ContentTitle:(NSString *)contentTitle ImageStr:(NSString *)imageStr WithViewController:(UIViewController *)viewController;

-(void)shareWithContentStr:(NSString *)contentStr ContentDescription:(NSString *)contentDescription ContentTitle:(NSString *)contentTitle ImageStr:(NSString *)imageStr WithViewController:(UIViewController *)viewController WithCallback:(shareContentCallBack)callback;

-(void)shareWithImageStr:(NSString *)imageStr WithVIewController:(UIViewController *)viewController;

-(void)shareWithImageStr:(NSString *)imageStr WithVIewController:(UIViewController *)viewController WithCallback:(shareImageCallBack)callback;

-(void)inviteFriendsWithAppLinkURLString:(NSString *)appLinkURLString WithAppImageURLString:(NSString *)appImageURLString WithViewController:(UIViewController *)viewController;

-(void)inviteFriendsWithAppLinkURLString:(NSString *)appLinkURLString WithAppImageURLString:(NSString *)appImageURLString WithViewController:(UIViewController *)viewController WithCallback:(inviteFriends)callback;

-(void)getFriendsListWithHeight:(int)height WithWidth:(int)width WithLimit:(int)limit With:(friendlist)callback;

@end
