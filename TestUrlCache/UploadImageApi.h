//
//  UploadImageApi.h
//  上传图片
//
//  Created by apple on 2018/11/12.
//  Copyright © 2018年 MaZhiYuan. All rights reserved.
//

#import "YTKRequest.h"
#import <UIKit/UIKit.h>

@interface UploadImageApi : YTKRequest
- (id)initWithImage:(UIImage *)image;

- (NSString *)responseImageId;
@end
