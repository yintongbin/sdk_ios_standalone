//
//  GameCenterHelper.h
//  seastar_spg_sdk
//
//  Created by seastar on 16/3/4.
//  Copyright © 2016年 seastar. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <GameKit/GameKit.h>
//#import "GameCenterLoginInfo.h"

typedef void(^GameCenterLoginCallBack)(NSString *jsonStr,bool loginSuccess);

@interface GameCenterHelper : NSObject<GKGameCenterControllerDelegate>

//@property (nonatomic,copy)void(^gamecenterLoginCallBack)(GameCenterLoginInfo *info);
@property (nonatomic,strong)GameCenterLoginCallBack LoginCallBack;


+(GameCenterHelper *)Instance;
//-(void)authenticateLocalUserWithViewController:(UIViewController *)gameCenterViewController;
-(void)authenticateLocalUserWithViewController:(UIViewController *)gameCenterViewController WithCallBack:(GameCenterLoginCallBack)callBack;
@end
