//
//  ViewController.m
//  Hackason
//
//  Created by oohashi on 2015/07/07.
//  Copyright (c) 2015年 Yasuhiro.Hashimoto. All rights reserved.
//

#import "MainViewController.h"
#import "MainView.h"
@interface MainViewController()

@end

@implementation MainViewController{
    __weak IBOutlet MainView *_mainView;
}

- (id)init{
    if (self = [super init]){
        [[AppData SharedManager] addObserver:self forKeyPath:@"url" options:NSKeyValueObservingOptionNew context:nil];
    }
    return self;
}
- (void)viewDidLoad{
    [super viewDidLoad];

    //self.apiManager = [[ApiManager alloc] init:@"version" installId:@"1111"];
    self.image = [imageManager new];//名前が......
    self.imageViewSize = CGRectMake(0, 0, 300, 500);//?
    self.imageView = [[UIImageView alloc] initWithFrame:self.imageViewSize];//?
    self.imageView.contentMode = UIViewContentModeScaleAspectFit;
    self.interactiveView          = [[InteractiveView alloc] initWithFrame:self.imageViewSize];//?
    self.interactiveView.backgroundColor = [UIColor clearColor];
    self.interactiveView.center   = self.view.center;
    self.interactiveView.delegate = self;
}





/**
 * Display側専用のメソッド
 * 画像を格納する変数に変更が発生した場合，その画像を表示させる
 */
- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary *)change context:(void *)context{

      NSLog(@"change: %@", [change objectForKey:@"new"]);
      //[self.image uploadSwipedImage:self.imageView.image text:@"stb" url:[NSURL URLWithString: @"http://133.2.37.224/Hackason/RegisterContents.php"]];//非同期的処理に変更する必要
}

/**
 * カメラロールを出現させるメソッド
 */
- (IBAction)onTapAdd:(id)sender{
    [self showCameraroll];
}

- (void)showCameraroll{
    
    UIImagePickerController *imagePickerController = [[UIImagePickerController alloc]init];
    [imagePickerController setDelegate:self];
    [imagePickerController setSourceType:UIImagePickerControllerSourceTypePhotoLibrary];
    [self presentViewController: imagePickerController animated:YES completion:nil];
}

/**
 * カメラロールから画像を取得した直後に実行されるDelegateメソッド
 */
- (void)imagePickerController :(UIImagePickerController *)picker
        didFinishPickingImage :(UIImage *)image
                  editingInfo :(NSDictionary *)editingInfo{
    
    [self dismissViewControllerAnimated:YES completion:^{
        [self.interactiveView addSubview:self.imageView];
        [self.view addSubview:self.interactiveView];
        self.imageView.image = image;
    }];
}

/**
* Swipeされたタイミングで実行されるDelegateメソッド
* 不可視にするタイミングを遅延
*/
- (void)didFinishSwipe{
    FUNC();
    [self.imageView removeFromSuperview];
    [self.interactiveView removeFromSuperview];
    [self.image uploadSwipedImage:self.imageView.image text:@"stb" url:[NSURL URLWithString: @"http://133.2.37.224/Hackason/RegisterContents.php"]];
}
@end