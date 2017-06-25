//
//  imageManager.m
//  Hackason
//
//  Created by oohashi on 2015/07/09.
//  Copyright (c) 2015年 Yasuhiro.Hashimoto. All rights reserved.
//

#import "ImageManager.h"


@implementation ImageManager

-(void)uploadSwipedImage: (UIImage *)image text: (NSString *)text url:(NSURL *)url{
    NSData *imageData = [[NSData alloc] initWithData:UIImageJPEGRepresentation(image, 0.1)];
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
        NSLog(@"画像のUploadに失敗2:%ld", (long)status);
    }
     ];
}

- (UIImage *)getImageServer
{
    NSURL *url = [NSURL URLWithString:@"****"];
    NSData *dat = [NSData dataWithContentsOfURL:url];
    UIImage *img = [UIImage imageWithData:dat];
    return img;
}

+ (void)saveImage:(Contents *)contents {
    NSString *fileName = [NSString stringWithFormat:@"%d-%d", contents.major, contents.minor];
    NSString *filePath = [NSString stringWithFormat:@"%@/images/%@.jpg" , [NSHomeDirectory() stringByAppendingPathComponent:@"Documents"], fileName];
    NSData *dataImg = [[NSData alloc] initWithData:UIImageJPEGRepresentation(contents.image, 0.1)];
    if([dataImg writeToFile:filePath atomically:YES]) {
    } else {
    };
}

+ (Contents *)loadImage:(Contents *)contents {
    NSString *fileName = [NSString stringWithFormat:@"%d-%d", contents.major, contents.minor];
    NSString *filePath = [NSString stringWithFormat:@"%@/images/%@.jpg" , [NSHomeDirectory() stringByAppendingPathComponent:@"Documents"], fileName];
    
    NSData *data = [NSData dataWithContentsOfFile:filePath];
    UIImage *image = [UIImage imageWithData:data];
    contents.image = image;
    return contents;
}

+ (BOOL)makeDirForAppContents {
    NSFileManager *fileManager = [NSFileManager defaultManager];
    NSString *filePath = [NSHomeDirectory() stringByAppendingPathComponent:@"Documents/images"];
    BOOL exists = [fileManager fileExistsAtPath:filePath];
    if (!exists) {
        NSError *error;
        BOOL created = [fileManager createDirectoryAtPath:filePath withIntermediateDirectories:YES attributes:nil error:&error];
        if (!created) {
            return NO;
        }
    } else {
        return NO;
    }
    return YES;
}
@end
