//
//  DCNavigationMenuView.m
//  Dcard
//
//  Created by Youwei Teng on 9/18/15.
//  Copyright © 2015 Dcard. All rights reserved.
//

#import "DCNavigationMenuView.h"
#import "DCNavigationMenuCollectionView.h"
#import "DCNavigationMenuDefaultCollectionViewCell.h"

@interface DCNavigationMenuView () <DCNavigationMenuCollectionViewDelegate>

@property (nonatomic, assign) DCNavigationMenuViewAnimateStyle          style;
@property (nonatomic, copy  ) DCNavigationMenuConfigureItemBlock configureBlock;
@property (nonatomic, weak  ) id<DCNavigationMenuViewDelegate>   delegate;
@property (nonatomic, strong) NSArray                            *items;
@property (nonatomic, assign, getter=isActive) BOOL active;

@property (nonatomic, strong) UIView *containterView;
@property (nonatomic, strong) UIImageView *menuViewAccessory;
@property (nonatomic, strong) UILabel *titleLabel;
@property (nonatomic, copy) NSString *collectionCellIdentifier;
@property (nonatomic, weak) UIView *parentView;
@property (nonatomic, assign) BOOL didSetupContraints;
@property (nonatomic, strong) DCNavigationMenuCollectionView *collectionView;

@end


@implementation DCNavigationMenuView

#pragma mark -
#pragma mark Initializers

- (instancetype)initWithFrame:(CGRect)frame style:(DCNavigationMenuViewAnimateStyle)style delegate:(id<DCNavigationMenuViewDelegate>)delegate parentView:(UIView *)parentView items:(NSArray *) items configureBlock:(DCNavigationMenuConfigureItemBlock)block{
    self = [super initWithFrame:frame];
    if (self) {
        _items          = items;
        _style          = style;
        _delegate       = delegate;
		_parentView = parentView;
		_configureBlock = [block copy];
		_collectionCellIdentifier = NSStringFromClass([DCNavigationMenuDefaultCollectionViewCell class]);
		
        [self addSubview:self.containterView];
        [self.containterView addSubview:self.titleLabel];
        [self.containterView addSubview:self.menuViewAccessory];

        [self addGestures];
		[self setUpCollectionView];
		[self setTitleText:[_items firstObject]];
        [self setNeedsUpdateConstraints];
    }
    return self;
}

-(instancetype)initWithFrame:(CGRect)frame style:(DCNavigationMenuViewAnimateStyle)style delegate:(id<DCNavigationMenuViewDelegate>)delegate parentView:(UIView *)parentView items:(NSArray *)items cellIdentifier:(NSString *)idendifier configureBlock:(DCNavigationMenuConfigureItemBlock)block {
	self = [super initWithFrame:frame];
	if (self) {
        _items                    = items;
        _style                    = style;
        _delegate                 = delegate;
        _parentView               = parentView;
        _configureBlock           = [block copy];
        _collectionCellIdentifier = idendifier;
		
		[self addSubview:self.containterView];
		[self.containterView addSubview:self.titleLabel];
		[self.containterView addSubview:self.menuViewAccessory];
		
		[self addGestures];
		[self setUpCollectionView];
		[self setTitleText:[_items firstObject]];
		[self setNeedsUpdateConstraints];
	}
	return self;

}

- (void)updateConstraints {

    if (self.didSetupContraints == NO) {
        [self setUpContraints];
    }
    [super updateConstraints];
}

#pragma mark -
#pragma mark Public interface

- (void)showMenu:(void (^)(BOOL))completion {
	[self.collectionView show];
    completion(YES);
}

- (void)hideMenu:(void (^)(BOOL))completion {

	[self.collectionView hide];
    completion(YES);
}

- (void)setTitleText:(NSString *)titleText {
    self.titleLabel.text = titleText;
}

- (void)setTextColor:(UIColor *)color {
	self.titleLabel.textColor = color;
	self.menuViewAccessory.tintColor = color;
}

- (void)showInView:(UIView *)parentView {
	self.parentView = parentView;
}

#pragma mark -
#pragma mark Private interface

- (void)setUpCollectionView {
	self.collectionView = [[DCNavigationMenuCollectionView alloc] initWithStyle:self.style cellIdentifier:self.collectionCellIdentifier parentView:self.parentView];
	self.collectionView.dc_delegate = self;
}

- (void)setUpContraints {

    [self addConstraint:[NSLayoutConstraint constraintWithItem:self.containterView
                                                     attribute:NSLayoutAttributeCenterX
                                                     relatedBy:NSLayoutRelationEqual
                                                        toItem:self.containterView.superview
                                                     attribute:NSLayoutAttributeCenterX
                                                    multiplier:1.f
                                                      constant:8.f]];
    [self addConstraint:[NSLayoutConstraint constraintWithItem:self.containterView
                                                     attribute:NSLayoutAttributeCenterY
                                                     relatedBy:NSLayoutRelationEqual
                                                        toItem:self.containterView.superview
                                                     attribute:NSLayoutAttributeCenterY
                                                    multiplier:1.f
                                                      constant:0.f]];
    [self.titleLabel.superview addConstraint:[NSLayoutConstraint constraintWithItem:self.titleLabel
                                                                          attribute:NSLayoutAttributeCenterY
                                                                          relatedBy:NSLayoutRelationEqual
                                                                             toItem:self.titleLabel.superview
                                                                          attribute:NSLayoutAttributeCenterY
                                                                         multiplier:1.f
                                                                           constant:0.f]];
    [self.titleLabel.superview addConstraint:[NSLayoutConstraint constraintWithItem:self.titleLabel
                                                                          attribute:NSLayoutAttributeLeft
                                                                          relatedBy:NSLayoutRelationEqual
                                                                             toItem:self.titleLabel.superview
                                                                          attribute:NSLayoutAttributeLeft
                                                                         multiplier:1.f
                                                                           constant:0.f]];

    [self.menuViewAccessory.superview addConstraint:[NSLayoutConstraint constraintWithItem:self.menuViewAccessory
                                                                                 attribute:NSLayoutAttributeHeight
                                                                                 relatedBy:NSLayoutRelationEqual
                                                                                    toItem:nil
                                                                                 attribute:0
                                                                                multiplier:0
                                                                                  constant:10.f]];
    [self.menuViewAccessory.superview addConstraint:[NSLayoutConstraint constraintWithItem:self.menuViewAccessory
                                                                                 attribute:NSLayoutAttributeWidth
                                                                                 relatedBy:NSLayoutRelationEqual
                                                                                    toItem:nil
                                                                                 attribute:0
                                                                                multiplier:0
                                                                                  constant:10.f]];
    [self.menuViewAccessory.superview addConstraint:[NSLayoutConstraint constraintWithItem:self.menuViewAccessory
                                                                                 attribute:NSLayoutAttributeCenterY
                                                                                 relatedBy:NSLayoutRelationEqual
                                                                                    toItem:self.menuViewAccessory.superview
                                                                                 attribute:NSLayoutAttributeCenterY
                                                                                multiplier:1.f
                                                                                  constant:0]];
    [self.menuViewAccessory.superview addConstraint:[NSLayoutConstraint constraintWithItem:self.titleLabel
                                                                                 attribute:NSLayoutAttributeRight
                                                                                 relatedBy:NSLayoutRelationEqual
                                                                                    toItem:self.menuViewAccessory
                                                                                 attribute:NSLayoutAttributeLeft
                                                                                multiplier:1.f
                                                                                  constant:-8.f]];
    [self.menuViewAccessory.superview addConstraint:[NSLayoutConstraint constraintWithItem:self.menuViewAccessory
                                                                                 attribute:NSLayoutAttributeRight
                                                                                 relatedBy:NSLayoutRelationEqual
                                                                                    toItem:self.titleLabel.superview
                                                                                 attribute:NSLayoutAttributeRight
                                                                                multiplier:1.f
                                                                                  constant:0.f]];

    self.didSetupContraints = YES;
}

- (void)addGestures {
	UITapGestureRecognizer *tapGesture =
	[[UITapGestureRecognizer alloc] initWithTarget:self
											action:@selector(handleTapGesture:)];
	[self addGestureRecognizer:tapGesture];
}

- (void)handleTapGesture:(id)sender {
	[self rotateArrow:self.isActive? 0:M_PI];
}

- (void)rotateArrow:(float)degrees {
	[UIView animateWithDuration:0.27f
						  delay:0.0
						options:UIViewAnimationOptionCurveEaseOut
					 animations:^{
						 self.menuViewAccessory.layer.transform = CATransform3DMakeRotation(degrees, 0, 0, 1);
					 }
					 completion:NULL];
	self.active = !self.isActive;
	if (self.isActive) {
		[self.collectionView show];
	} else {
		[self.collectionView hide];
	}
}

-(id)itemAtIndexPath:(NSIndexPath *)indexPath {
	return self.items[indexPath.row];
}

#pragma mark -
#pragma mark DCNavigationMenuCollectionViewDelegate

- (id)dc_navigationMenuCollectionView:(DCNavigationMenuCollectionView *)collectionView itemForIndexPath:(NSIndexPath *)indexPath {
	
	return [self itemAtIndexPath:indexPath];
}

- (NSInteger)dc_navigationMenuCollectionView:(DCNavigationMenuCollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
	
	return self.items.count;
}

- (void)dc_navigationMenuCollectionView:(DCNavigationMenuCollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {

	if ([self.delegate respondsToSelector:@selector(dc_navigationMenu:didSelectItem:)]) {
		[self.delegate dc_navigationMenu:self didSelectItem:[self itemAtIndexPath:indexPath]];
	}
	[self setTitleText:[self itemAtIndexPath:indexPath]];
	[self handleTapGesture:collectionView];
}

-(NSInteger)dc_numberOfColumnInCollectionView:(UICollectionView *)collectionView {
	if ([self.delegate respondsToSelector:@selector(dc_numbesOfColumnsInNavigationMenu)]) {
		return [self.delegate dc_numbesOfColumnsInNavigationMenu];
	} else {
		return 1;
	}

}

-(UICollectionViewCell *)dc_navigationMenuCollectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
	UICollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:self.collectionCellIdentifier forIndexPath:indexPath];
	self.configureBlock(cell, [self itemAtIndexPath:indexPath]);
	return cell;
}

#pragma mark -
#pragma mark Lazy instantiation


- (UIImageView *)menuViewAccessory {
    if (_menuViewAccessory == nil) {
        _menuViewAccessory = [[UIImageView alloc] init];
        _menuViewAccessory.translatesAutoresizingMaskIntoConstraints = NO;
        _menuViewAccessory.contentMode = UIViewContentModeCenter;
		UIImage *arrowImage = [UIImage imageNamed:@"arrow.pdf"];
		_menuViewAccessory.image = arrowImage;
    }
    return _menuViewAccessory;
}

- (UILabel *)titleLabel {
    if (_titleLabel == nil) {
        _titleLabel = [[UILabel alloc] init];
        _titleLabel.translatesAutoresizingMaskIntoConstraints = NO;
        _titleLabel.textColor = [UIColor whiteColor];
    }
    return _titleLabel;
}

- (UIView *)containterView {
    if (_containterView == nil) {
        _containterView = [[UIView alloc] init];
        _containterView.translatesAutoresizingMaskIntoConstraints = NO;
    }
    return _containterView;
}

@end
