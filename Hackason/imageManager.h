//
//  imageManager.h
//  Hackason
//
//  Created by oohashi on 2015/07/09.
//  Copyright (c) 2015年 Yasuhiro.Hashimoto. All rights reserved.
//

#import "ReqHTTP.h"

@interface imageManager : NSObject

- (void)uploadSwipedImage: (UIImage *)image text: (NSString *)text url:(NSURL *)url;
- (UIImage *)getImageServer;

@end
