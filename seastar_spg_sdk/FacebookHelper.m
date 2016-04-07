//
//  FacebookHelper.m
//  seastar_spg_sdk
//
//  Created by seastar on 16/3/4.
//  Copyright © 2016年 seastar. All rights reserved.
//

#import "FacebookHelper.h"
@interface FacebookHelper()<FBSDKSharingDelegate>
@property (nonatomic,strong)FBSDKLoginManager *loginManager;
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


-(void)loginWithViewController:(UIViewController *)viewController WithCallback:(LoginCallBack)callback
{
    
    self.Logincallback = callback;
    [self.loginManager logInWithReadPermissions:@[@"user_friends",@"public_profile"] fromViewController:viewController handler:^(FBSDKLoginManagerLoginResult *result, NSError *error) {
        if(error)
        {
            NSLog(@"Process error");
            self.Logincallback(nil,NO);
        }else if (result.isCancelled)
        {
            self.Logincallback(nil,NO);
            NSLog(@"Cancelled");
        }else
        {
            NSDictionary *parametersDic = @{@"fields":@"id,name,picture,email,first_name,last_name,middle_name,name_format,third_party_id,gender,location,friends"};
            if([FBSDKAccessToken currentAccessToken])
            {
                [[[FBSDKGraphRequest alloc]initWithGraphPath:@"me" parameters:parametersDic]startWithCompletionHandler:^(FBSDKGraphRequestConnection *connection, id result, NSError *error) {
                    if(!error)
                    {
                        NSLog(@"show result = %@",result);
                        if([NSJSONSerialization isValidJSONObject:result])
                        {
                            NSData *data = [NSJSONSerialization dataWithJSONObject:result options:NSJSONWritingPrettyPrinted error:nil];
                            NSString *str = [[NSString alloc]initWithData:data encoding:NSUTF8StringEncoding];
                            self.Logincallback(str,YES);
                        }
                    }
                }];
            }
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

-(void)shareWithContentStr:(NSString *)contentStr ContentDescription:(NSString *)contentDescription ContentTitle:(NSString *)contentTitle ImageStr:(NSString *)imageStr WithViewController:(UIViewController *)viewController WithCallback:(shareContentCallBack)callback
{
    self.shareContentCallBack = callback;
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

-(void)shareWithImageStr:(NSString *)imageStr WithVIewController:(UIViewController *)viewController WithCallback:(shareImageCallBack)callback
{
    self.shareImageCallBack = callback;
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
    self.shareContentCallBack(YES);
}

-(void)sharer:(id<FBSDKSharing>)sharer didFailWithError:(NSError *)error
{
    NSLog(@"分享失败%@",error);
    self.shareContentCallBack(YES);
}

-(void)sharerDidCancel:(id<FBSDKSharing>)sharer
{
    self.shareContentCallBack(YES);
    NSLog(@"取消分享");
}

-(void)inviteFriendsWithAppLinkURLString:(NSString *)appLinkURLString WithAppImageURLString:(NSString *)appImageURLString WithViewController:(UIViewController *)viewController
{
    FBSDKAppInviteContent *content = [[FBSDKAppInviteContent alloc]init];
    content.appLinkURL = [NSURL URLWithString:appLinkURLString];
    content.appInvitePreviewImageURL = [NSURL URLWithString:appImageURLString];
    [FBSDKAppInviteDialog showFromViewController:viewController withContent:content delegate:nil];
    
}

-(void)inviteFriendsWithAppLinkURLString:(NSString *)appLinkURLString WithAppImageURLString:(NSString *)appImageURLString WithViewController:(UIViewController *)viewController WithCallback:(inviteFriends)callback
{
    self.inviteCallBack = callback;
    FBSDKAppInviteContent *content = [[FBSDKAppInviteContent alloc]init];
    content.appLinkURL = [NSURL URLWithString:appLinkURLString];
    content.appInvitePreviewImageURL = [NSURL URLWithString:appImageURLString];
    [FBSDKAppInviteDialog showFromViewController:viewController withContent:content delegate:nil];
    
}

-(void)getFriendsList
{
    NSDictionary *params;
    FBSDKGraphRequest *request = [[FBSDKGraphRequest alloc]initWithGraphPath:@"/{friend-list-id}" parameters:params HTTPMethod:@"GET"];
    [request startWithCompletionHandler:^(FBSDKGraphRequestConnection *connection, id result, NSError *error) {
       
        
    }];


}







@end
