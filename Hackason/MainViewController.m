//
//  ViewController.m
//  Hackason
//
//  Created by oohashi on 2015/07/07.
//  Copyright (c) 2015年 Yasuhiro.Hashimoto. All rights reserved.
//

#import "MainViewController.h"
#import "ContentsCollectionView.h"

#import "UploadViewController.h"
#import "DownloadViewController.h"

@interface MainViewController()<UIViewControllerTransitioningDelegate>
@end

@implementation MainViewController {
    AppData *_appData;
    __weak IBOutlet UIView *_viewContainer;
    UploadViewController *_uploadViewController;
    DownloadViewController*_downloadViewController;
}

- (instancetype)initWithCoder:(NSCoder *)coder {
    FUNC();
    self = [super initWithCoder:coder];
    if (self){
        _appData = [AppData SharedManager];
        [_appData addObserver:self forKeyPath:@"url" options:NSKeyValueObservingOptionNew context:nil];
        _appData.arrUploadContents = [_appData.queryHelper selectUploadContents];
        for (Contents *contents in _appData.arrUploadContents){
             [ImageManager loadImage:contents];
        }
        _uploadViewController = [[UploadViewController alloc] init];
        [self addChildViewController:_uploadViewController];
        [_uploadViewController didMoveToParentViewController:self];
        _downloadViewController = [[DownloadViewController alloc] init];
        [self addChildViewController:_downloadViewController];
        [_downloadViewController didMoveToParentViewController:self];
        [self setTransitioningDelegate:self];
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [_viewContainer addSubview:_downloadViewController.view];
    [_viewContainer addSubview:_uploadViewController.view];
}

/**
 * Display側専用のメソッド
 * 画像を格納する変数に変更が発生した場合，その画像を表示させる
 */
- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary *)change context:(void *)context{
      NSLog(@"change: %@", [change objectForKey:@"new"]);
}

 - (IBAction)onTapUpload:(id)sender {
    FUNC();
    [self changeMode:_downloadViewController toViewController:_uploadViewController];
}
- (IBAction)onTapDownload:(id)sender {
    FUNC();
    [self changeMode:_uploadViewController toViewController:_downloadViewController];
}

- (void)changeMode:(UIViewController *)fromViewController toViewController:(UIViewController *)toViewController {
    [self transitionFromViewController:fromViewController
                      toViewController:toViewController
                              duration:1.0
                               options:UIViewAnimationOptionTransitionNone
                            animations:^{}
                            completion:^(BOOL finished){}];
}
@end
