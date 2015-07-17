//
//  AppData.m
//  swift
//
//  Created by yohei sashikata on 2014/02/19.
//  Copyright (c) 2014年 Yohei Sashikata. All rights reserved.
//

#import "AppData.h"

@implementation AppData{

}

static AppData* sharedAppData = nil;

+ (AppData *)SharedManager{
    @synchronized(self){
		if(sharedAppData == nil){
			sharedAppData = [[self alloc] init];
		}
	}
	return sharedAppData;
}

- (AppData *)init{
    self.apiManager = [[ApiManager alloc] init];
    return self;
}
@end