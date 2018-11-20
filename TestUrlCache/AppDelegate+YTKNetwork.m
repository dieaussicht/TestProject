//
//  AppDelegate+YTKNetwork.m
//  TestUrlCache
//
//  Created by apple on 2018/11/12.
//  Copyright © 2018年 MaZhiYuan. All rights reserved.
//

#import "AppDelegate+YTKNetwork.h"
#import "YTKNetworkConfig.h"
#import "YTKUrlArgumentsFilter.h"
@implementation AppDelegate (YTKNetwork)
- (void)setupRequestFilters {
    //统一设置网络请求的服务器和 CDN 的地址
    YTKNetworkConfig *config = [YTKNetworkConfig sharedConfig];
    config.baseUrl = @"http://api.51zhihuijia.com";
    config.cdnUrl = @"http://api.51zhihuijia.com";
    
    //添加统一参数
//    NSString *appVersion = [[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleShortVersionString"];
//    YTKUrlArgumentsFilter *urlFilter = [YTKUrlArgumentsFilter filterWithArguments:@{@"version": appVersion}];
//    [config addUrlFilter:urlFilter];
}

@end
