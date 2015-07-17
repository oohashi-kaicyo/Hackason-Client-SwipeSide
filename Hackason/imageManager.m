//
//  imageManager.m
//  Hackason
//
//  Created by oohashi on 2015/07/09.
//  Copyright (c) 2015年 Yasuhiro.Hashimoto. All rights reserved.
//

#import "imageManager.h"

@implementation imageManager

-(void)uploadSwipedImage: (UIImage *)image text: (NSString *)text url:(NSURL *)url
{
    NSData *imageData = [[NSData alloc] initWithData:UIImageJPEGRepresentation(image, 0.1)];//品質最低
    
    NSMutableDictionary* texts  = [NSMutableDictionary dictionary];
    NSMutableDictionary* images = [NSMutableDictionary dictionary];
    
    [texts  setObject:text forKey:@"tst"];
    [images setObject:imageData forKey:@"apple"];
    ReqHTTP *reqHTTP = [[ReqHTTP alloc] init];
    [reqHTTP postMultiDataWithTextDictionary:texts imageDictionary:images url:url done:^(NSDictionary *responseData){
        NSInteger status = [[responseData objectForKey:@"status"] integerValue];
        if (status == -1) {
            NSLog(@"画像のUploadに失敗");
            
            return;
        }
        NSLog(@"success %@", responseData);
    } fail:^(NSInteger status) {
        NSLog(@"画像のUploadに失敗2:%d", status);
    }
    ];
}

- (UIImage *)getImageServer//imageURL//?向こう側でも実装
{
    NSURL    *url = [NSURL URLWithString:@"http://133.2.37.224/Hackason/images/apple.jpg"];
    NSData   *dat = [NSData dataWithContentsOfURL:url];
    UIImage  *img = [UIImage imageWithData:dat];
    
    return img;
}

@end
