//
//  RequestViewController.m
//  TestUrlCache
//
//  Created by apple on 2018/11/12.
//  Copyright © 2018年 MaZhiYuan. All rights reserved.
//

#import "RequestViewController.h"
#import <YTKNetwork.h>
#import "YTKBaseRequest+AnimatingAccessory.h"
#import "RegisterApi.h"
#import "GetUserInfoApi.h"
@interface RequestViewController ()<YTKChainRequestDelegate>

@end

@implementation RequestViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*YTKBatchRequest 类：用于方便地发送批量的网络请求，YTKBatchRequest 是一个容器类，它可以放置多个 YTKRequest 子类，并统一处理这多个网络请求的成功和失败。
 在如下的示例中，我们发送了 4 个批量的请求，并统一处理这 4 个请求同时成功的回调
 */
- (void)sendBatchRequest {
    RegisterApi *a = [[RegisterApi alloc] initWithUsername:@"1" password:@"1"];
    RegisterApi *b = [[RegisterApi alloc] initWithUsername:@"2" password:@"2"];
    RegisterApi *c = [[RegisterApi alloc] initWithUsername:@"3" password:@"3"];
    RegisterApi *d = [[RegisterApi alloc] initWithUsername:@"4" password:@"4"];
    
    YTKBatchRequest *batchRequest = [[YTKBatchRequest alloc] initWithRequestArray:@[a, b, c, d]];
    [batchRequest startWithCompletionBlockWithSuccess:^(YTKBatchRequest *batchRequest) {
        NSLog(@"succeed");
        NSArray *requests = batchRequest.requestArray;
        RegisterApi *a = (RegisterApi *)requests[0];
        RegisterApi *b = (RegisterApi *)requests[1];
        RegisterApi *c = (RegisterApi *)requests[2];
        RegisterApi *user = (RegisterApi *)requests[3];
        // deal with requests result ...
    } failure:^(YTKBatchRequest *batchRequest) {
        NSLog(@"failed");
    }];
}

/**
 用于管理有相互依赖的网络请求，它实际上最终可以用来管理多个拓扑排序后的网络请求。
 
 例如，我们有一个需求，需要用户在注册时，先发送注册的 Api，然后 :
 
 如果注册成功，再发送读取用户信息的 Api。并且，读取用户信息的 Api 需要使用注册成功返回的用户 id 号。
 如果注册失败，则不发送读取用户信息的 Api 了。
 以下是具体的代码示例，在示例中，我们在 sendChainRequest 方法中设置好了 Api 相互的依赖，然后。 我们就可以通过 chainRequestFinished 回调来处理所有网络请求都发送成功的逻辑了。如果有任何其中一个网络请求失败了，则会触发 chainRequestFailed 回调。
 */
- (void)sendChainRequest {
    RegisterApi *reg = [[RegisterApi alloc] initWithUsername:@"username" password:@"password"];
    YTKChainRequest *chainReq = [[YTKChainRequest alloc] init];
    [chainReq addRequest:reg callback:^(YTKChainRequest *chainRequest, YTKBaseRequest *baseRequest) {
        RegisterApi *result = (RegisterApi *)baseRequest;
        NSString *userId = [result userId];
        GetUserInfoApi *api = [[GetUserInfoApi alloc] initWithUserId:userId token:@""];
        [chainRequest addRequest:api callback:nil];
    }];
    chainReq.delegate = self;
    // start to send request
    [chainReq start];
}
#pragma mark - YTKChainRequestDelegate
- (void)chainRequestFinished:(YTKChainRequest *)chainRequest {
    // all requests are done
}

- (void)chainRequestFailed:(YTKChainRequest *)chainRequest failedBaseRequest:(YTKBaseRequest*)request {
    // some one of request is failed
}

/**
 在实际开发中，有一些内容可能会加载很慢，我们想先显示上次的内容，等加载成功后，再用最新的内容替换上次的内容。也有时候，由于网络处于断开状态，为了更加友好，我们想显示上次缓存中的内容。这个时候，可以使用 YTKReqeust 的直接加载缓存的高级用法。
 
 具体的方法是直接使用 YTKRequest 的 - (BOOL)loadCacheWithError: 方法，即可获得上次缓存的内容。当然，你需要把 - (NSInteger)cacheTimeInSeconds 覆盖，返回一个大于等于 0 的值，这样才能开启 YTKRequest 的缓存功能，否则默认情况下，缓存功能是关闭的。
 
 以下是一个示例，我们在加载用户信息前，先取得上次加载的内容，然后再发送请求，请求成功后再更新界面：
 */
- (void)loadCacheData {
    NSString *userId = @"1";
    GetUserInfoApi *api = [[GetUserInfoApi alloc] initWithUserId:userId token:@""];
    if ([api loadCacheWithError:nil]) {
        NSDictionary *json = [api responseJSONObject];
        NSLog(@"json = %@", json);
        // show cached data
    }
    [api startWithCompletionBlockWithSuccess:^(YTKBaseRequest *request) {
        NSLog(@"update ui");
    } failure:^(YTKBaseRequest *request) {
        NSLog(@"failed");
    }];
}

@end
