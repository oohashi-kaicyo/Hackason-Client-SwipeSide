//
//  AppData.h
//  swift
//
//  Created by yohei sashikata on 2014/02/19.
//  Copyright (c) 2014年 Yohei Sashikata. All rights reserved.
//

#import "ApiManager.h"

@interface AppData : NSObject

@property ApiManager *apiManager;

+ (AppData *)SharedManager;

@property(nonatomic) NSString *url;

@end
