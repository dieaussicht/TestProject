//
//  PGNetworkHelperController.m
//  TestUrlCache
//
//  Created by apple on 2018/11/12.
//  Copyright © 2018年 MaZhiYuan. All rights reserved.
//

#import "PGNetworkHelperController.h"
#import <PGNetworkHelper/PGNetworkHelper.h>

@interface PGNetworkHelperController ()

@end

@implementation PGNetworkHelperController

- (void)viewDidLoad {
    [super viewDidLoad];
    [PGNetAPIClient baseUrl:@"http://api.51zhihuijia.com"];//url
    
    [PGNetAPIClient policyWithPinningMode:AFSSLPinningModeNone];
    
    //一般为userid
    [PGNetworkCache pathName:@"5111"];//缓存路径
    
    
    NSMutableDictionary *dictParameter = [NSMutableDictionary dictionary];
    [dictParameter setObject:@"5111" forKey:@"user_id"];
    [dictParameter setObject:@"88a493c21249e866ab3efa9a9602d18f" forKey:@"token"];
    [PGNetworkHelper POST:@"api/Index/getNewGoodsShow" parameters:dictParameter cache:true responseCache:^(id responseCache) {
        NSLog(@"当前的缓存：%@",responseCache);
        
    } success:^(id responseObject) {
        NSDictionary *dic = (NSDictionary *)responseObject;
        NSLog(@"返回的数据是:%@",dic);
        
    } failure:^(NSError *error) {
        
    }];
    
    //有参数的话url后面拼上
    //    NSString *key = [NSString stringWithFormat:@"api/Index/getNewGoodsShow%@",[PGNetworkHelper convertJsonStringFromDictionaryOrArray:dictParameter]];
    //    NSLog(@"根据key取得缓存:%@",[PGNetworkCache getResponseCacheForKey:key]);
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
