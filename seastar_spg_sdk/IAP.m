//
//  IAP.m
//  seastar_spg_sdk
//
//  Created by seastar on 16/3/11.
//  Copyright © 2016年 seastar. All rights reserved.
//

#import "IAP.h"
static IAP *_instance;
@implementation IAP
+(IAP *)Instance
{
    if(!_instance)
    {
        _instance = [[IAP alloc]init];
    }
    return _instance;
}

-(void)addTransactionObserver
{
    [[SKPaymentQueue defaultQueue] addTransactionObserver:self];
}


-(void)buyWithProduct:(NSString *)product
{
    if([SKPaymentQueue canMakePayments])
    {
        [self getProductInfo:product];
    }else
    {
        NSLog(@"失败，用户禁止内购");
    }
}

-(void)getProductInfo:(NSString *)productInfo
{
    NSSet *set = [NSSet setWithObject:productInfo];
    SKProductsRequest *request = [[SKProductsRequest alloc]initWithProductIdentifiers:set];
    request.delegate = self;
    [request start];
    
}

-(void)productsRequest:(SKProductsRequest *)request didReceiveResponse:(SKProductsResponse *)response
{
    NSArray *myProduct = response.products;
    if(myProduct.count == 0)
    {
        NSLog(@"无法获取产品信息，购买失败");
        return;
    }
    SKPayment *payment = [SKPayment paymentWithProduct:myProduct[0]];
    [[SKPaymentQueue defaultQueue] addPayment:payment];
}

-(void)paymentQueue:(SKPaymentQueue *)queue updatedTransactions:(NSArray<SKPaymentTransaction *> *)transactions
{
    for (SKPaymentTransaction *transaction in transactions)
    {
        switch (transaction.transactionState)
        {
            case SKPaymentTransactionStatePurchased:
                NSLog(@"交易成功transactionIdentifier = %@",transaction.transactionIdentifier);
                [self completeTransaction:transaction];
                break;
            case SKPaymentTransactionStateFailed:
                [self failedTransaction:transaction];
                NSLog(@"交易失败");
                break;
            case SKPaymentTransactionStateRestored:
                [self restoreTransaction:transaction];
                NSLog(@"已经购买过");
                break;
            case SKPaymentTransactionStatePurchasing:
                NSLog(@"商品添加到列表");
            default:
                break;
        }
    }
}

-(void)completeTransaction:(SKPaymentTransaction *)transaction
{
    NSString *productIdentifier = transaction.payment.productIdentifier;
    if([productIdentifier length] > 0)
    {
        //验证购买凭证
    }
    [[SKPaymentQueue defaultQueue]finishTransaction:transaction];
}

-(void)failedTransaction:(SKPaymentTransaction *)transaction
{
    if(transaction.error.code == SKErrorPaymentCancelled)
    {
        NSLog(@"用户取消交易");
    }else
    {
        NSLog(@"交易失败");
    }
    [[SKPaymentQueue defaultQueue] finishTransaction:transaction];
}

-(void)restoreTransaction:(SKPaymentTransaction *)transaction
{
    [[SKPaymentQueue defaultQueue]finishTransaction:transaction];
}
-(void)removeTransactionObserver
{
    [[SKPaymentQueue defaultQueue]removeTransactionObserver:self];
}




@end
