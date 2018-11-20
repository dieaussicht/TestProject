//
//  GetUserInfoApi.h
//  TestUrlCache
//
//  Created by apple on 2018/11/12.
//  Copyright © 2018年 MaZhiYuan. All rights reserved.
//

#import "YTKRequest.h"

@interface GetUserInfoApi : YTKRequest
- (id)initWithUserId:(NSString *)userId token:(NSString *)token;
@end
