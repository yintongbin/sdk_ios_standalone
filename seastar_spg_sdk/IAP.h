//
//  IAP.h
//  seastar_spg_sdk
//
//  Created by seastar on 16/3/11.
//  Copyright © 2016年 seastar. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <StoreKit/StoreKit.h>
@interface IAP : NSObject<SKPaymentTransactionObserver,SKProductsRequestDelegate>
+(IAP *)Instance;
-(void)addTransactionObserver;
-(void)buyWithProduct:(NSString *)product;
-(void)removeTransactionObserver;
@end
