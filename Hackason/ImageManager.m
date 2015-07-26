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
        NSLog(@"画像のUploadに失敗2:%ld", (long)status);
    }
     ];
}

- (UIImage *)getImageServer//imageURL//?向こう側でも実装
{
    NSURL *url = [NSURL URLWithString:@"http://133.2.37.224/Hackason/images/apple.jpg"];
    NSData *dat = [NSData dataWithContentsOfURL:url];
    UIImage *img = [UIImage imageWithData:dat];
    
    return img;
}

+ (void)saveImage:(Contents *)contents{
    //major, minorからファイル名を作成
    NSString *fileName = [NSString stringWithFormat:@"%d-%d", contents.major, contents.minor];
    
    //pathの作成
    NSString *filePath = [NSString stringWithFormat:@"%@/images/%@.jpg" , [NSHomeDirectory() stringByAppendingPathComponent:@"Documents"], fileName];
    
    //NSDataを作成
    NSData *dataImg = [[NSData alloc] initWithData:UIImageJPEGRepresentation(contents.image, 0.1)];//品質最低
    
    NSLog(@"%@", filePath);
    if([dataImg writeToFile:filePath atomically:YES]) {
        NSLog(@"OK");
    } else {
        NSLog(@"Error");
    };
}

+ (Contents *)loadImage:(Contents *)contents{
    //major, minorからファイル名を作成
    NSString *fileName = [NSString stringWithFormat:@"%d-%d", contents.major, contents.minor];
    //pathの作成
    NSString *filePath = [NSString stringWithFormat:@"%@/images/%@.jpg" , [NSHomeDirectory() stringByAppendingPathComponent:@"Documents"], fileName];
    
    NSData *data = [NSData dataWithContentsOfFile:filePath];
    UIImage *image = [UIImage imageWithData:data];
    contents.image = image;
    return contents;
}

+ (BOOL)makeDirForAppContents{
    NSFileManager *fileManager = [NSFileManager defaultManager];
    NSString *filePath = [NSHomeDirectory() stringByAppendingPathComponent:@"Documents/images"];
    
    BOOL exists = [fileManager fileExistsAtPath:filePath];
    if (!exists) {
        NSError *error;
        BOOL created = [fileManager createDirectoryAtPath:filePath withIntermediateDirectories:YES attributes:nil error:&error];
        if (!created) {
            NSLog(@"ディレクトリ作成失敗");
            return NO;
        }
    } else {
        return NO; // 作成済みの場合はNO
    }
    return YES;
}
@end
