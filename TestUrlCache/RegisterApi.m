//
//  RegisterApi.m
//  TestUrlCache
//
//  Created by apple on 2018/11/12.
//  Copyright © 2018年 MaZhiYuan. All rights reserved.
//

#import "RegisterApi.h"

@implementation RegisterApi{
    NSString *_username;
    NSString *_password;
}
#pragma mark - 初始化方法
- (id)initWithUsername:(NSString *)username password:(NSString *)password {
    self = [super init];
    if (self) {
        _username = username;
        _password = password;
    }
    return self;
}
#pragma mark - 请求url
- (NSString *)requestUrl {
    // “ http://www.yuantiku.com ” 在 YTKNetworkConfig 中设置，这里只填除去域名剩余的网址信息
    return @"/iphone/register";
}

#pragma mark - 请求方式
- (YTKRequestMethod)requestMethod {
    return YTKRequestMethodPOST;
}

#pragma mark - 提交参数
- (id)requestArgument {
    return @{
             @"username": _username,
             @"password": _password
             };
}

#pragma mark - 验证服务器返回内容
- (id)jsonValidator {
    return @{
             @"nick": [NSString class],
             @"level": [NSNumber class]
             };
}

#pragma mark - 是否使用cdn
- (BOOL)useCDN {
    return YES;
}

#pragma mark - 要启动断点续传功能，只需要覆盖 resumableDownloadPath 方法，指定断点续传时文件的存储路径即可，文件会被自动保存到此路径。如下代码将刚刚的取图片的接口改造成了支持断点续传：
//- (NSString *)resumableDownloadPath {
//    NSString *libPath = [NSSearchPathForDirectoriesInDomains(NSLibraryDirectory, NSUserDomainMask, YES) objectAtIndex:0];
//    NSString *cachePath = [libPath stringByAppendingPathComponent:@"Caches"];
//    NSString *filePath = [cachePath stringByAppendingPathComponent:_imageId];
//    return filePath;
//}

#pragma mark - 缓存时间
- (NSInteger)cacheTimeInSeconds {
    // 3 分钟 = 180 秒
    return 60 * 3;
}

#pragma mark - 添加请求头
/**
 通过覆盖 requestHeaderFieldValueDictionary 方法返回一个 dictionary 对象来自定义请求的 HeaderField，返回的 dictionary，其 key 即为 HeaderField 的 key，value 为 HeaderField 的 Value，需要注意的是 key 和 value 都必须为 string 对象。
 */
//- (NSDictionary<NSString *,NSString *> *)requestHeaderFieldValueDictionary
//{
//    return nil;
//}

#pragma mark - 自定义网络请求
/**
 通过覆盖 buildCustomUrlRequest 方法，返回一个 NSURLRequest 对象来达到完全自定义请求的需求。该方法定义在 YTKBaseRequest 类，如下：
 构建自定义的 UrlRequest，
 若这个方法返回非 nil 对象，会忽略 requestUrl, requestArgument, requestMethod, requestSerializerType,requestHeaderFieldValueDictionary
 - (NSURLRequest *)buildCustomUrlRequest;
 如注释所言，如果构建自定义的 request，会忽略其他的一切自定义 request 的方法，例如 requestUrl, requestArgument, requestMethod, requestSerializerType,requestHeaderFieldValueDictionary 等等。一个上传 gzippingData 的示例如下：
 */
//- (NSURLRequest *)buildCustomUrlRequest {
//    NSData *rawData = [[_events jsonString] dataUsingEncoding:NSUTF8StringEncoding];
//    NSData *gzippingData = [NSData gtm_dataByGzippingData:rawData];
//    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:[NSURL URLWithString:self.requestUrl]];
//    [request setHTTPMethod:@"POST"];
//    [request addValue:@"application/json;charset=UTF-8" forHTTPHeaderField:@"Content-Type"];
//    [request addValue:@"gzip" forHTTPHeaderField:@"Content-Encoding"];
//    [request setHTTPBody:gzippingData];
//    return request;
//}

- (NSString *)userId {
    return [[[self responseJSONObject] objectForKey:@"userId"] stringValue];
}
@end
