//
//  MainView.h
//  Hackason
//
//  Created by Yohei Sashikata on 2015/07/17.
//  Copyright (c) 2015年 Yasuhiro.Hashimoto. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "LiveNibView.h"

@protocol ContentsCollectionViewDelegate
- (void)onTapAdd;

@end

@interface ContentsCollectionView : LiveNibView
@property id<ContentsCollectionViewDelegate> delegate;
IBInspectable @property NSString *title;
- (void)reloadData;
- (void)setContentsList:(NSArray *)list;
- (void)initCollectionView;
@end
