//
//  GetUserInfoApi.m
//  TestUrlCache
//
//  Created by apple on 2018/11/12.
//  Copyright © 2018年 MaZhiYuan. All rights reserved.
//

#import "GetUserInfoApi.h"

@implementation GetUserInfoApi
{
    NSString *_userId;
    NSString *_token;
}

- (id)initWithUserId:(NSString *)userId token:(NSString *)token {
    self = [super init];
    if (self) {
        _userId = userId;
        _token = token;
    }
    return self;
}

- (NSString *)requestUrl {
    return @"/api/Index/getNewGoodsShow";
}
- (YTKRequestMethod)requestMethod {
    return YTKRequestMethodPOST;
}
- (id)requestArgument {
    return @{ @"userid": _userId,
              @"token" : _token
              
              };
}

//- (id)jsonValidator {
//    return @{
//             @"nick": [NSString class],
//             @"level": [NSNumber class]
//             };
//}

- (NSInteger)cacheTimeInSeconds {
    return 60 * 3;
}
@end
