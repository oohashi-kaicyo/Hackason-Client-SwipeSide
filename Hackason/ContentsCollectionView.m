//
//  MainView.m
//  Hackason
//
//  Created by Yohei Sashikata on 2015/07/17.
//  Copyright (c) 2015年 Yasuhiro.Hashimoto. All rights reserved.
//

#import "ContentsCollectionView.h"
#import "ImageCollectionViewCell.h"

@interface ContentsCollectionView()<UICollectionViewDelegate, UICollectionViewDataSource>
@end

@implementation ContentsCollectionView {
    AppData *_appData;
    __weak IBOutlet  UICollectionView *_collectionView;
    __weak IBOutlet UIButton *_btnAdd;
    __weak IBOutlet UILabel *_labelTitle;
    NSArray *_arrContents;
    IBInspectable NSString *_title;
}

- (void)awakeFromNib {
    [super awakeFromNib];
    _appData = [AppData SharedManager];
    [_labelTitle setText:_title];
}

- (void)reloadData {
    [_collectionView reloadData];
}

- (void)setContentsList:(NSArray *)list {
    _arrContents = list;
}

- (void)initCollectionView {
    UINib *nib = [UINib nibWithNibName:@"ImageCollectionViewCell" bundle:nil];
    [_collectionView registerNib:nib forCellWithReuseIdentifier:@"cellcontents"];
    
    [_collectionView setDelegate:self];
    [_collectionView setDataSource:self];
    
    UICollectionViewFlowLayout *flowLayout = (UICollectionViewFlowLayout *)[_collectionView collectionViewLayout];
    float cellSize = (SCREEN_W - [flowLayout minimumInteritemSpacing]) / 2;
    
    [flowLayout setItemSize:CGSizeMake(cellSize, cellSize)];
    [_collectionView setCollectionViewLayout:flowLayout];
}

- (IBAction)onTapChoicePivture:(id)sender {
    [self.delegate onTapAdd];
}
#pragma mark - UICollectionViewDelegater

#pragma mark - UICollectionViewDataSource

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return [_arrContents count];
}

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return 1;
}

- (ImageCollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    ImageCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"cellcontents" forIndexPath:indexPath];
    [cell setBackgroundColor:[UIColor redColor]];
    Contents *contents = _arrContents[indexPath.row];
    [cell.ivContents setImage:contents.image];
    return cell;
}
@end
