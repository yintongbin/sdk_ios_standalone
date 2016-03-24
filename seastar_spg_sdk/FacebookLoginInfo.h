//
//  FacebookLoginInfo.h
//  seastar_spg_sdk
//
//  Created by seastar on 16/3/23.
//  Copyright © 2016年 seastar. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface FacebookLoginInfo : NSObject
@property (nonatomic,assign)BOOL facebookLoginSuccess;

@property (nonatomic,strong)NSString *appID;
@property (nonatomic,strong)NSSet *declinedPermissions;
@property (nonatomic,strong)NSDate *expirationDate;
@property (nonatomic,strong)NSSet *permissions;
@property (nonatomic,strong)NSDate *refreshDate;
@property (nonatomic,strong)NSString *tokenString;
@property (nonatomic,strong)NSString *userID;
@property (nonatomic,strong)NSSet *grantedPermissions;
@end
