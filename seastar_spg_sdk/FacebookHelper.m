//
//  FacebookHelper.m
//  seastar_spg_sdk
//
//  Created by seastar on 16/3/4.
//  Copyright © 2016年 seastar. All rights reserved.
//

#import "FacebookHelper.h"
#import "seastar_spg_sdkVC.h"
@interface FacebookHelper()<FBSDKSharingDelegate>
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

-(void)shareWithImageStr:(NSString *)imageStr WithVIewController:(UIViewController *)viewController
{
    FBSDKSharePhoto *photo = [[FBSDKSharePhoto alloc]init];
    photo.image = [UIImage imageNamed:imageStr];
    photo.userGenerated = YES;
    FBSDKSharePhotoContent *content = [[FBSDKSharePhotoContent alloc]init];
    content.photos = @[photo];
    FBSDKShareDialog *shareDialog = [[FBSDKShareDialog alloc]init];
    shareDialog.shareContent = content;
    shareDialog.delegate = self;
    shareDialog.fromViewController = viewController;
    [shareDialog show];
}


#pragma FBSDKSharingDelegate

-(void)sharer:(id<FBSDKSharing>)sharer didCompleteWithResults:(NSDictionary *)results
{
    NSLog(@"分享成功%@",results);
}

-(void)sharer:(id<FBSDKSharing>)sharer didFailWithError:(NSError *)error
{
    NSLog(@"分享失败%@",error);
}

-(void)sharerDidCancel:(id<FBSDKSharing>)sharer
{
    NSLog(@"取消分享");
}

-(void)inviteFriendsWithAppLinkURLString:(NSString *)appLinkURLString WithAppImageURLString:(NSString *)appImageURLString WithViewController:(UIViewController *)viewController
{
    FBSDKAppInviteContent *content = [[FBSDKAppInviteContent alloc]init];
    content.appLinkURL = [NSURL URLWithString:appLinkURLString];
    content.appInvitePreviewImageURL = [NSURL URLWithString:appImageURLString];
    [FBSDKAppInviteDialog showFromViewController:viewController withContent:content delegate:nil];
    
}













@end
