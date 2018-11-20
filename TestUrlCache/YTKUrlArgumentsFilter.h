//
//  YTKUrlArgumentsFilter.h
//  /// 给url追加arguments，用于全局参数，比如AppVersion, ApiVersion等

//
//  Created by apple on 2018/11/12.
//  Copyright © 2018年 MaZhiYuan. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <YTKNetwork.h>
@interface YTKUrlArgumentsFilter : NSObject<YTKUrlFilterProtocol>
+ (YTKUrlArgumentsFilter *)filterWithArguments:(NSDictionary *)arguments;

- (NSString *)filterUrl:(NSString *)originUrl withRequest:(YTKBaseRequest *)request;
@end
