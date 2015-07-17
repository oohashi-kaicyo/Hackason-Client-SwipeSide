//
//  ViewController.h
//  Hackason
//
//  Created by oohashi on 2015/07/07.
//  Copyright (c) 2015年 Yasuhiro.Hashimoto. All rights reserved.
//

#import "ApiManager.h"
#import "BroadCaster.h"
#import "Observer.h"
#import "imageManager.h"
#import "InteractiveView.h"

@interface ViewController : UIViewController
<UIImagePickerControllerDelegate, UINavigationControllerDelegate, InteractiveViewDelegate>

@property(nonatomic) ApiManager      *apiManager;
@property(nonatomic) Observer        *observer;
@property(nonatomic) imageManager    *image;
@property(nonatomic) CGRect           imageViewSize;
@property(nonatomic) UIImageView     *imageView;
@property(nonatomic) InteractiveView *interactiveView;

- (void)showCameraroll;

@end

