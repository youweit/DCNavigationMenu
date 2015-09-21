//
//  DCNavigationMenuCollectionView.h
//  Dcard
//
//  Created by Youwei Teng on 9/18/15.
//  Copyright © 2015 Dcard. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DCNavigationMenuView.h"

@class DCNavigationMenuCollectionView;
@protocol DCNavigationMenuCollectionViewDelegate <NSObject>

- (id)dc_navigationMenuCollectionView:(DCNavigationMenuCollectionView *)collectionView itemForIndexPath:(NSIndexPath *)indexPath;
- (NSInteger)dc_navigationMenuCollectionView:(DCNavigationMenuCollectionView *)collectionView numberOfItemsInSection:(NSInteger)section;
- (UICollectionViewCell *)dc_navigationMenuCollectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath;
@optional
- (NSInteger)dc_numberOfSectionsInCollectionView:(UICollectionView *)collectionView;
- (NSInteger)dc_numberOfColumnInCollectionView:(UICollectionView *)collectionView;
- (void)dc_navigationMenuCollectionView:(DCNavigationMenuCollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath;

@end

@interface DCNavigationMenuCollectionView : UIView

@property (nonatomic, strong) UIView *parentView;
@property (nonatomic, weak) id<DCNavigationMenuCollectionViewDelegate> dc_delegate;

- (instancetype)initWithStyle:(DCNavigationMenuViewAnimateStyle)style parentView:(UIView *)parentView;
- (instancetype)initWithStyle:(DCNavigationMenuViewAnimateStyle)style cellIdentifier:(NSString *)identifier parentView:(UIView *)parentView;

- (void)show;
- (void)hide;

@end
