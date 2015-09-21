//
//  DCViewController.m
//  DCNavigationMenu
//
//  Created by Youwei Teng on 09/19/2015.
//  Copyright (c) 2015 Youwei Teng. All rights reserved.
//

#import "DCViewController.h"
#import "DCNavigationMenuView.h"
#import "DCCustomizedCollectinoViewCell.h"

@interface DCViewController () <DCNavigationMenuViewDelegate>
@property (nonatomic, strong) DCNavigationMenuView *navigationMenuItem;
@property (nonatomic, strong) NSArray *menuItems;

@end

@implementation DCViewController

- (void)viewDidLoad {
    [super viewDidLoad];
	self.navigationItem.titleView = self.navigationMenuItem;
//	self.navigationController.navigationBar.translucent = NO;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

#pragma mark -
#pragma mark DCNavigationMenuView delegate

- (void)dc_navigationMenu:(DCNavigationMenuView *)menu didSelectItem:(id)item {
	NSLog(@"you click %@", item);
	self.centerLabel.text = item;
}

-(NSInteger)dc_numbesOfColumnsInNavigationMenu {
	return 1;
}

#pragma mark -
#pragma mark Lazy instantiate

- (DCNavigationMenuView *)navigationMenuItem {
	if(_navigationMenuItem == nil) {
		CGRect frame = CGRectMake(0.0, 0.0, 200.0, self.navigationController.navigationBar.bounds.size.height);
		_navigationMenuItem = [[DCNavigationMenuView alloc] initWithFrame:frame
																	style:DCNavigationMenuViewStyleDown
																 delegate:self parentView:self.view
																	items:self.menuItems
														   configureBlock:^(DCNavigationMenuDefaultCollectionViewCell *cell, id item) {
															   cell.title.text = item;
														   }];
		
		[_navigationMenuItem setTitleText:[self.menuItems firstObject]];
		[_navigationMenuItem setTextColor:[UIColor blackColor]];
	}
	return _navigationMenuItem;
}

- (NSArray *)menuItems {
	if(_menuItems == nil) {
		_menuItems = @[@"Lorem", @"ipsum", @"dolor", @"sit", @"amet", @"consectetur" ,@"adipiscing", @"Lorem", @"ipsum", @"dolor", @"sit", @"amet", @"consectetur" ,@"adipiscing", @"Lorem", @"ipsum", @"dolor", @"sit", @"amet", @"consectetur" ,@"adipiscing", @"Lorem", @"ipsum", @"dolor", @"sit", @"amet", @"consectetur" ,@"adipiscing"];
	}
	return _menuItems;
}

@end
