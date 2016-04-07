//
//  GameCenterHelper.m
//  seastar_spg_sdk
//
//  Created by seastar on 16/3/4.
//  Copyright © 2016年 seastar. All rights reserved.
//

#import "GameCenterHelper.h"
#import "seastar_spg_sdkVC.h"
static GameCenterHelper *_instance;
@implementation GameCenterHelper
+(GameCenterHelper *)Instance
{
    if(!_instance)
    {
        _instance = [[GameCenterHelper alloc]init];
    }
    return  _instance;
}

////身份验证
//- (void)authenticateLocalUserWithViewController:(UIViewController *)gameCenterViewController
//{
//    GKLocalPlayer *localPlayer = [GKLocalPlayer localPlayer];
//    GameCenterLoginInfo *info = [GameCenterLoginInfo new];
//    info.playerID = [GKLocalPlayer localPlayer].playerID;
//    info.displayName = [GKLocalPlayer localPlayer].displayName;
//    info.alias = [GKLocalPlayer localPlayer].alias;
//    info.gusetIdentifier = [GKLocalPlayer localPlayer].guestIdentifier;
//    info.success = YES;
//    self.gamecenterLoginCallBack(info);
//    localPlayer.authenticateHandler = ^(UIViewController *viewController, NSError *error){
//        if (viewController != nil) {
////            UIViewController *mainVC = [[seastar_spg_sdkVC Instance].delegate getController];
//            [gameCenterViewController presentViewController:viewController animated:YES completion:nil];
//        }
//        else{
//            if ([GKLocalPlayer localPlayer].authenticated) {
//                // Get the default leaderboard identifier.
//                
//                [[GKLocalPlayer localPlayer] loadDefaultLeaderboardIdentifierWithCompletionHandler:^(NSString *leaderboardIdentifier, NSError *error) {
//                    
//                    if (error != nil) {
//                        NSLog(@"%@", [error localizedDescription]);
//                    }
//                    else{
//                        
//                    }
//                }];
//            }
//            
//            else{
//                
//            }
//        }
//    };
//    
//}

-(void)authenticateLocalUserWithViewController:(UIViewController *)gameCenterViewController WithCallBack:(GameCenterLoginCallBack)callBack
{
    self.LoginCallBack = callBack;
    GKLocalPlayer *localPlayer = [GKLocalPlayer localPlayer];
    NSString *playerID = [GKLocalPlayer localPlayer].playerID;
    NSString *displayName = [GKLocalPlayer localPlayer].displayName;
    NSString *alias = [GKLocalPlayer localPlayer].alias;
    NSString *gusetIdentifier = [GKLocalPlayer localPlayer].guestIdentifier;
    NSDictionary *jsonDic = [NSDictionary dictionaryWithObjectsAndKeys:playerID,@"playerID",displayName,@"displayName",alias,@"alias",gusetIdentifier,@"guestIdentifier",nil];
//    if([NSJSONSerialization isValidJSONObject:jsonDic])
//    {
//        NSData *jsonData = [NSJSONSerialization dataWithJSONObject:jsonDic options:NSJSONWritingPrettyPrinted error:nil];
//        NSString *jsonStr = [[NSString alloc]initWithData:jsonData encoding:NSUTF8StringEncoding];
//        self.LoginCallBack(jsonStr,YES);
//    }
    localPlayer.authenticateHandler = ^(UIViewController *viewController, NSError *error){
        if (viewController != nil) {
            //            UIViewController *mainVC = [[seastar_spg_sdkVC Instance].delegate getController];
            [gameCenterViewController presentViewController:viewController animated:YES completion:nil];
            if([NSJSONSerialization isValidJSONObject:jsonDic])
            {
                NSData *jsonData = [NSJSONSerialization dataWithJSONObject:jsonDic options:NSJSONWritingPrettyPrinted error:nil];
                NSString *jsonStr = [[NSString alloc]initWithData:jsonData encoding:NSUTF8StringEncoding];
                self.LoginCallBack(jsonStr,YES);
            }
        }
        else{
            if ([GKLocalPlayer localPlayer].authenticated) {
                // Get the default leaderboard identifier.
                
                [[GKLocalPlayer localPlayer] loadDefaultLeaderboardIdentifierWithCompletionHandler:^(NSString *leaderboardIdentifier, NSError *error) {
                    
                    if (error != nil) {
                        NSLog(@"%@", [error localizedDescription]);
                    }
                    else{
                        
                    }
                }];
            }
            
            else{
                
            }
        }
    };


}












-(void)gameCenterViewControllerDidFinish:(GKGameCenterViewController *)gameCenterViewController
{
    //UIViewController *mainVC = [[seastar_spg_sdkVC Instance].delegate getController];
    [gameCenterViewController dismissViewControllerAnimated:YES completion:nil];
}

@end
