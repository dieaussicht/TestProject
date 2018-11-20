//
//  RegisterApi.h
//  TestUrlCache
//
//  Created by apple on 2018/11/12.
//  Copyright © 2018年 MaZhiYuan. All rights reserved.
//

#import "YTKRequest.h"

@interface RegisterApi : YTKRequest
- (id)initWithUsername:(NSString *)username password:(NSString *)password;

- (NSString *)userId;
@end
