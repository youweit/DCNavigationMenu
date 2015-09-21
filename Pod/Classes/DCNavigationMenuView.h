//
//  DCNavigationMenuView.h
//  Dcard
//
//  Created by Youwei Teng on 9/18/15.
//  Copyright © 2015 Dcard. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DCNavigationMenuDefaultCollectionViewCell.h"

typedef void (^DCNavigationMenuConfigureItemBlock)(id cell,id item);
typedef NS_ENUM(NSInteger, DCNavigationMenuViewAnimateStyle) {
	DCNavigationMenuViewStyleFade,
	DCNavigationMenuViewStyleUp,
	DCNavigationMenuViewStyleDown
};

@class DCNavigationMenuView;
@protocol DCNavigationMenuViewDelegate <NSObject>

@optional
- (void)dc_navigationMenu:(DCNavigationMenuView *)menu didSelectItem:(id)item;
- (NSInteger)dc_numbesOfColumnsInNavigationMenu;

@end

@interface DCNavigationMenuView : UIView

-(instancetype)initWithFrame:(CGRect)frame style:(DCNavigationMenuViewAnimateStyle)style delegate:(id<DCNavigationMenuViewDelegate>)delegate parentView:(UIView *)parentView items:(NSArray *)items configureBlock:(DCNavigationMenuConfigureItemBlock)block;

-(instancetype)initWithFrame:(CGRect)frame style:(DCNavigationMenuViewAnimateStyle)style delegate:(id<DCNavigationMenuViewDelegate>)delegate parentView:(UIView *)parentView items:(NSArray *)items cellIdentifier:(NSString *)idendifier configureBlock:(DCNavigationMenuConfigureItemBlock)block;

- (void)showMenu:(void(^)(BOOL finished))completion;
- (void)hideMenu:(void(^)(BOOL finished))completion;
- (void)showInView:(UIView *)parentView;
- (void)setTitleText:(NSString *)titleText;
- (void)setTextColor:(UIColor *)color;



@end
