//
//  GameCenterHelper.h
//  seastar_spg_sdk
//
//  Created by seastar on 16/3/4.
//  Copyright © 2016年 seastar. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <GameKit/GameKit.h>
@interface GameCenterHelper : NSObject<GKGameCenterControllerDelegate>
+(GameCenterHelper *)Instance;
-(void)authenticateLocalUserWithViewController:(UIViewController *)gameCenterViewController;
@end
