//
//  FacebookHelper.m
//  seastar_spg_sdk
//
//  Created by seastar on 16/3/4.
//  Copyright © 2016年 seastar. All rights reserved.
//

#import "FacebookHelper.h"
#import "seastar_spg_sdkVC.h"
@interface FacebookHelper()<UINavigationControllerDelegate,UIImagePickerControllerDelegate>
@property (nonatomic,strong)FBSDKLoginManager *loginManager;
@property (nonatomic,strong)UIImagePickerController *imagePickerController;
@end
static FacebookHelper *_instance;
@implementation FacebookHelper

+(FacebookHelper *)Instance
{
    if(!_instance)
    {
        _instance = [[FacebookHelper alloc]init];
    }
    return _instance;
}

-(UIImagePickerController *)imagePickerController
{
    if(!_imagePickerController)
    {
        _imagePickerController = [[UIImagePickerController alloc]init];
    }
    return _imagePickerController;
}

-(void)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    [[FBSDKApplicationDelegate sharedInstance]application:application didFinishLaunchingWithOptions:launchOptions];
}
-(BOOL)application:(UIApplication *)application openURL:(NSURL *)url sourceApplication:(NSString *)sourceApplication annotation:(id)annotation
{
    return
    [[FBSDKApplicationDelegate sharedInstance]application:application openURL:url sourceApplication:sourceApplication annotation:annotation];
}
-(void)activateApp
{
    [FBSDKAppEvents activateApp];
}







-(FBSDKLoginManager *)loginManager
{
    if(!_loginManager)
    {
        _loginManager = [[FBSDKLoginManager alloc]init];
    }
    return _loginManager;
}






-(void)loginWithViewController:(UIViewController *)viewController
{
    [self.loginManager logInWithReadPermissions:@[@"public_profile"] fromViewController:viewController handler:^(FBSDKLoginManagerLoginResult *result, NSError *error) {
        if(error)
        {
            NSLog(@"Process error");
        }else if (result.isCancelled)
        {
            NSLog(@"Cancelled");
        }else
        {
            NSLog(@"logged in");
        }
        
    }];

    
}


//-(void)login
//{
//    UIViewController *mainVC = [[seastar_spg_sdkVC Instance].delegate getController];
//    [self.loginManager logInWithReadPermissions:@[@"public_profile"] fromViewController:mainVC handler:^(FBSDKLoginManagerLoginResult *result, NSError *error) {
//        if(error)
//        {
//            NSLog(@"Process error");
//        }else if (result.isCancelled)
//        {
//            NSLog(@"Cancelled");
//        }else
//        {
//            NSLog(@"logged in");
//        }
//        
//    }];
//}

-(void)logOut
{
    [self.loginManager logOut];
}



-(void)shareWithContentStr:(NSString *)contentStr ContentDescription:(NSString *)contentDescription ContentTitle:(NSString *)contentTitle ImageStr:(NSString *)imageStr WithViewController:(UIViewController *)viewController
{
    FBSDKShareLinkContent *content = [[FBSDKShareLinkContent alloc]init];
    content.contentURL = [[NSURL alloc]initWithString:contentStr];
    content.contentDescription = contentDescription;
    content.contentTitle = contentTitle;
    content.imageURL = [[NSURL alloc]initWithString:imageStr];
    //UIViewController *mainVC = [[seastar_spg_sdkVC Instance].delegate getController];
    [FBSDKShareDialog showFromViewController:viewController withContent:content delegate:nil];
}

-(void)shareWithImage:(UIImage *)image ContentDescription:(NSString *)contentDescription ContentTitle:(NSString *)contentTitle ImageStr:(NSString *)imageStr WithViewController:(UIViewController *)viewController
{
    FBSDKShareLinkContent *content = [[FBSDKShareLinkContent alloc]init];
    
}















@end
