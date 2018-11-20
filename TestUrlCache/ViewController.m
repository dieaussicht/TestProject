//
//  ViewController.m
//  TestUrlCache
//
//  Created by apple on 2018/11/6.
//  Copyright © 2018年 MaZhiYuan. All rights reserved.
//

#import "ViewController.h"
#import "GetUserInfoApi.h"
#import "YTKBaseRequest+AnimatingAccessory.h"
#import "JJException.h"
@interface ViewController ()<JJExceptionHandle>

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    [JJException registerExceptionHandle:self];//错误观察者
    
    self.view.backgroundColor = [UIColor lightGrayColor];
//    GetUserInfoApi *api = [[GetUserInfoApi alloc] initWithUserId:@"5111" token:@"a0e4136284bad605ab3975238c468ae6"];
//    
//    [api startWithCompletionBlockWithSuccess:^(YTKBaseRequest *request) {
//        NSDictionary *dic = (NSDictionary *)request.responseJSONObject;
//        NSLog(@"服务器返回的结果:%@",dic);
//    } failure:^(YTKBaseRequest *request) {
//        NSLog(@"错误原因:%ld",request.error.code);
//    }];
    
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
#pragma mark - JJExceptionHandle
- (void)handleCrashException:(NSString*)exceptionMessage extraInfo:(nullable NSDictionary*)info
{
//    NSDictionary *userInfo1 = [NSDictionary dictionaryWithObjectsAndKeys:@"由于文件不存在，无法打开", NSLocalizedDescriptionKey, @"失败原因：文件不存在", NSLocalizedFailureReasonErrorKey, @"恢复建议：请创建该文件",NSLocalizedRecoverySuggestionErrorKey,nil];
//    
//    NSError *error = [[NSError alloc] initWithDomain:NSCocoaErrorDomain code:4 userInfo:userInfo1];//此处code是4，对照下面对照表4代表文件不存在。userinfo传userinfo1 查看自定义打印。userinfo传nil，查看本地化描述。
    
//    NSError *error = [NSError errorWithDomain:NSCocoaErrorDomain code:200 userInfo:nil];
}
@end
