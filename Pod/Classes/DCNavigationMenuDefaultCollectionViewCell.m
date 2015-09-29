//
//  DCNavigationMenuDefaultCollectionViewCell.m
//  Dcard
//
//  Created by Youwei Teng on 9/18/15.
//  Copyright © 2015 Dcard. All rights reserved.
//

#import "DCNavigationMenuDefaultCollectionViewCell.h"

@interface DCNavigationMenuDefaultCollectionViewCell ()
@property (nonatomic, assign) BOOL didSetupContraints;

@end

@implementation DCNavigationMenuDefaultCollectionViewCell

- (instancetype)init {
	return nil;
}


-(instancetype)initWithFrame:(CGRect)frame {

	self = [super initWithFrame:frame];
	if (self) {
		[self.contentView addSubview:self.title];
		[self.contentView addSubview:self.icon];
		self.backgroundColor = [UIColor whiteColor];
		[self.contentView setNeedsUpdateConstraints];
	}
	return self;
}

- (void)updateConstraints {
    if (self.didSetupContraints == NO) {
        [self setupContraints];
    }
    [super updateConstraints];
}

#pragma mark -
#pragma mark Private methodes

- (void)setupContraints {

    [self.contentView addConstraint:[NSLayoutConstraint constraintWithItem:self.contentView
                                                                 attribute:NSLayoutAttributeCenterX
                                                                 relatedBy:NSLayoutRelationEqual
                                                                    toItem:self.title
                                                                 attribute:NSLayoutAttributeCenterX
                                                                multiplier:1.f
                                                                  constant:8.f]];
    [self.contentView addConstraint:[NSLayoutConstraint constraintWithItem:self.contentView
                                                                 attribute:NSLayoutAttributeCenterY
                                                                 relatedBy:NSLayoutRelationEqual
                                                                    toItem:self.title
                                                                 attribute:NSLayoutAttributeCenterY
                                                                multiplier:1.f
                                                                  constant:0.f]];
}


#pragma mark -
#pragma Lazy instantiate

- (UILabel *)title {
    if (_title == nil) {
        _title = [[UILabel alloc] init];
		_title.translatesAutoresizingMaskIntoConstraints = NO;
        _title.textColor = [UIColor blackColor];
    }
    return _title;
}

- (UIImageView *)icon {
    if (_icon == nil) {
        _icon = [[UIImageView alloc] init];
		_icon.translatesAutoresizingMaskIntoConstraints = NO;
    }
    return _icon;
}


@end
