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

//身份验证
- (void)authenticateLocalUserWithViewController:(UIViewController *)gameCenterViewController
{
    GKLocalPlayer *localPlayer = [GKLocalPlayer localPlayer];
    
    localPlayer.authenticateHandler = ^(UIViewController *viewController, NSError *error){
        if (viewController != nil) {
//            UIViewController *mainVC = [[seastar_spg_sdkVC Instance].delegate getController];
            [gameCenterViewController presentViewController:viewController animated:YES completion:nil];
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
