//
//  UploadViewController.m
//  Hackason
//
//  Created by Yohei Sashikata on 2015/07/24.
//  Copyright (c) 2015年 Yasuhiro.Hashimoto. All rights reserved.
//

#import "UploadViewController.h"
#import "ContentsCollectionView.h"
#import "ImageManager.h"
#import "Interactiveview.h"

@interface UploadViewController ()<UIImagePickerControllerDelegate, UINavigationControllerDelegate, ContentsCollectionViewDelegate
, InteractiveViewDelegate>
@end

@implementation UploadViewController{
    AppData *_appData;
    ImageManager *_imageManager;
    
    __weak IBOutlet ContentsCollectionView *_contentsCollectionView;
    __weak IBOutlet UIView *_baseView;
    __weak IBOutlet InteractiveView *_interactiveView;
    __weak IBOutlet UIImageView *_imgView;
}

- (instancetype)init{
    self = [super init];
    if (self) {
        _appData = [AppData SharedManager];
    }
    return self;
}

- (instancetype)initWithCoder:(NSCoder *)coder{
    self = [super initWithCoder:coder];
    if (self){

    }
    return self;
}

- (void)viewDidLoad{
    FUNC();
    [super viewDidLoad];
    
    [_contentsCollectionView setContentsList:_appData.arrUploadContents];
    
    [_contentsCollectionView setDelegate:self];
    [_interactiveView setDelegate:self];
    [_baseView setAlpha:0];
    [_contentsCollectionView initCollectionView];
}

- (void)didReceiveMemoryWarning{
    [super didReceiveMemoryWarning];
}
- (void)onTapAdd{
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

    [_imgView setImage:image];
    
    [self dismissViewControllerAnimated:YES completion:^{
        [_baseView setAlpha:1];
    }];
}

/**
 * Swipeされたタイミングで実行されるDelegateメソッド
 * 不可視にするタイミングを遅延
 */

- (void)didFinishSwipe{
    FUNC();
    
    Contents *contents = [[Contents alloc] init];
    contents.major = 1111;
    contents.minor = 44;
    contents.image = [_imgView image];
    [_imageManager uploadSwipedImage:contents.image text:@"stb" url:[NSURL URLWithString: @"http://133.2.37.224/Hackason/RegisterContents.php"]];
    [_appData.queryHelper insertUploadContents:contents];
    [ImageManager saveImage:contents];
    
    _appData.arrUploadContents = [self getContents:contents];
    
    [_contentsCollectionView setContentsList:_appData.arrUploadContents];
    
    [_contentsCollectionView reloadData];
    
    [_baseView setAlpha:0];
}

- (NSArray *)getContents:(Contents *)contentsTarget{
    NSMutableArray *arrContent = [_appData.arrUploadContents mutableCopy];
    for (Contents *contents in arrContent){
        if (contentsTarget.minor == contents.minor){
            contents.image = contentsTarget.image;
            return [arrContent copy];
        }
    }
    [arrContent addObject:contentsTarget];
    return [arrContent copy];
}



@end
