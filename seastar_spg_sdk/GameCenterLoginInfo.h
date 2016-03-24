//
//  GameCenterLoginInfo.h
//  seastar_spg_sdk
//
//  Created by seastar on 16/3/24.
//  Copyright © 2016年 seastar. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface GameCenterLoginInfo : NSObject
@property (nonatomic,strong)NSString *playerID;
@property (nonatomic,strong)NSString *displayName;
@property (nonatomic,strong)NSString *alias;
@property (nonatomic,strong)NSString *gusetIdentifier;
@end
