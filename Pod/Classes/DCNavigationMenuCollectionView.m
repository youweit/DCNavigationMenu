//
//  DCNavigationMenuCollectionView.m
//  Dcard
//
//  Created by Youwei Teng on 9/18/15.
//  Copyright © 2015 Dcard. All rights reserved.
//

#import "DCNavigationMenuCollectionView.h"
#import "DCNavigationMenuDefaultCollectionViewCell.h"

@interface DCNavigationMenuCollectionView ()<UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout>
@property (nonatomic, copy) NSString *cellIdentifier;
@property (nonatomic, assign) DCNavigationMenuViewAnimateStyle style;
@property (nonatomic, strong) UICollectionView *collectionView;
@property (nonatomic, copy) DCNavigationMenuConfigureItemBlock configureCellBlock;
@property (nonatomic, assign) CGRect initialFrame;
@property (nonatomic, assign) CGRect finalFrame;
@property (nonatomic, strong) UIView *dimmingView;
@end

@implementation DCNavigationMenuCollectionView

- (instancetype)initWithStyle:(DCNavigationMenuViewAnimateStyle)style parentView:(UIView *)parentView {
    return [self initWithStyle:style cellIdentifier:NSStringFromClass([DCNavigationMenuDefaultCollectionViewCell class]) parentView:parentView];
}

- (instancetype)initWithStyle:(DCNavigationMenuViewAnimateStyle)style cellIdentifier:(NSString *)identifier parentView:(UIView *)parentView {

	self.finalFrame = CGRectMake(0,0,CGRectGetWidth(parentView.frame),CGRectGetHeight(parentView.frame));
	self.initialFrame = CGRectMake(0,-CGRectGetHeight(parentView.frame),CGRectGetWidth(parentView.frame),CGRectGetHeight(parentView.frame));
	
    self = [super initWithFrame:self.initialFrame];
    if (self) {
        _style = style;
        _parentView = parentView;
        _cellIdentifier = identifier;

        UICollectionViewFlowLayout *flowLayout = [[UICollectionViewFlowLayout alloc] init];
        [flowLayout setScrollDirection:UICollectionViewScrollDirectionVertical];
		flowLayout.minimumInteritemSpacing = 3;
		flowLayout.minimumLineSpacing = 3;
		
        _collectionView = [[UICollectionView alloc] initWithFrame:CGRectZero collectionViewLayout:flowLayout];
        _collectionView.translatesAutoresizingMaskIntoConstraints = NO;
        _collectionView.delegate                                  = self;
        _collectionView.dataSource                                = self;
        _collectionView.alwaysBounceHorizontal                    = NO;
        _collectionView.showsHorizontalScrollIndicator            = NO;
        _collectionView.backgroundColor                           = [UIColor colorWithRed:0.9 green:0.9 blue:0.9 alpha:1.0];
        _collectionView.contentInset                              = UIEdgeInsetsMake(70, 0, 6, 0);

        [_collectionView registerClass:NSClassFromString(_cellIdentifier) forCellWithReuseIdentifier:_cellIdentifier];

        [self addSubview:_collectionView];
        [self addConstraint:[NSLayoutConstraint constraintWithItem:_collectionView
                                                         attribute:NSLayoutAttributeRight
                                                         relatedBy:NSLayoutRelationEqual
                                                            toItem:self
                                                         attribute:NSLayoutAttributeRight
                                                        multiplier:1.f
                                                          constant:0.f]];
		[self addConstraint:[NSLayoutConstraint constraintWithItem:_collectionView
														 attribute:NSLayoutAttributeLeft
														 relatedBy:NSLayoutRelationEqual
															toItem:self
														 attribute:NSLayoutAttributeLeft
														multiplier:1.f
														  constant:0.f]];
		[self addConstraint:[NSLayoutConstraint constraintWithItem:_collectionView
														 attribute:NSLayoutAttributeTop
														 relatedBy:NSLayoutRelationEqual
															toItem:self
														 attribute:NSLayoutAttributeTop
														multiplier:1.f
														  constant:0.f]];
		[self addConstraint:[NSLayoutConstraint constraintWithItem:_collectionView
														 attribute:NSLayoutAttributeBottom
														 relatedBy:NSLayoutRelationEqual
															toItem:self
														 attribute:NSLayoutAttributeBottom
														multiplier:1.f
														  constant:0.f]];
    }
    return self;
}

-(CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
	if ([self.dc_delegate respondsToSelector:@selector(dc_numberOfColumnInCollectionView:)]) {
		NSInteger columns = [self.dc_delegate dc_numberOfColumnInCollectionView:collectionView];
		CGFloat parentViewWidth = CGRectGetWidth(self.parentView.frame);
		
		return CGSizeMake(parentViewWidth / columns - 10, 44);
	} else {
	
		return CGSizeMake(50, 44);
	}
	
}


- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {

    return [self.dc_delegate dc_navigationMenuCollectionView:collectionView cellForItemAtIndexPath:indexPath];
}


-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {

	if ([self.dc_delegate respondsToSelector:@selector(dc_navigationMenuCollectionView:didSelectItemAtIndexPath:)]) {
		[self.dc_delegate dc_navigationMenuCollectionView:self didSelectItemAtIndexPath:indexPath];
	}
}

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    if ([self.dc_delegate respondsToSelector:@selector(dc_numberOfSectionsInCollectionView:)]) {
        return [self.dc_delegate dc_numberOfSectionsInCollectionView:self.collectionView];
    } else {
        return 1;
    }
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return [self.dc_delegate dc_navigationMenuCollectionView:self numberOfItemsInSection:section];
}


- (void)show {
	if (self.dimmingView.superview == nil) {
		[self.parentView insertSubview:self.dimmingView belowSubview:self];
	}
	if (self.superview == nil) {
		[self.parentView addSubview:self];
	}
	NSLog(@"self.parentView width = %f", CGRectGetWidth(self.parentView.frame));
	switch (self.style) {
		case DCNavigationMenuViewStyleFade: {
			
			break;
		}
		case DCNavigationMenuViewStyleUp: {
			
			break;
		}
		case DCNavigationMenuViewStyleDown: {
			[UIView animateWithDuration:0.5 delay:0 options:UIViewAnimationOptionBeginFromCurrentState animations:^{
				[self setFrame:self.finalFrame];
				self.dimmingView.alpha = 0.5;
			} completion:NULL];
			break;
		}
		default: {
			break;
		}
	}

}

- (void)hide {

	[UIView animateWithDuration:0.5 delay:0 options:UIViewAnimationOptionBeginFromCurrentState animations:^{
		[self setFrame:self.initialFrame];
		self.dimmingView.alpha = 0;
	} completion:NULL];
}


- (UIView *)dimmingView {
	if(_dimmingView == nil) {
		_dimmingView = [[UIView alloc] initWithFrame:self.finalFrame];
		_dimmingView.backgroundColor = [UIColor blackColor];
		_dimmingView.alpha = 0;
	}
	return _dimmingView;
}

@end
