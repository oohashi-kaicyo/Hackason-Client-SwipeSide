//
//  MainView.m
//  Hackason
//
//  Created by Yohei Sashikata on 2015/07/17.
//  Copyright (c) 2015年 Yasuhiro.Hashimoto. All rights reserved.
//

#import "MainView.h"

@interface MainView()
@end

@implementation MainView{
    __weak IBOutlet UICollectionView *__collectionView;
    __weak IBOutlet UIButton *_btnAdd;
}
/*
- (instancetype)initWithCoder:(NSCoder *)coder
{
    self = [super initWithCoder:coder];
    if (self){
    }
    return self;
}
*/
- (IBAction)onTapChoicePivture:(id)sender{
    FUNC();
    [self.delegate onTapChoicePicture];
}
@end
