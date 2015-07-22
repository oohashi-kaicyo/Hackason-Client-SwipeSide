//
//  MainView.h
//  Hackason
//
//  Created by Yohei Sashikata on 2015/07/17.
//  Copyright (c) 2015年 Yasuhiro.Hashimoto. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "LiveNibView.h"

@protocol MainViewDelegate
- (void)onTapChoicePicture;
@end

@interface MainView : LiveNibView
@property id<MainViewDelegate> delegate;
@end
