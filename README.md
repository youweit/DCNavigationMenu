# DCNavigationMenu
 (under development)
[![CI Status](http://img.shields.io/travis/Youwei Teng/DCNavigationMenu.svg?style=flat)](https://travis-ci.org/Youwei Teng/DCNavigationMenu)
[![Version](https://img.shields.io/cocoapods/v/DCNavigationMenu.svg?style=flat)](http://cocoapods.org/pods/DCNavigationMenu)
[![License](https://img.shields.io/cocoapods/l/DCNavigationMenu.svg?style=flat)](http://cocoapods.org/pods/DCNavigationMenu)
[![Platform](https://img.shields.io/cocoapods/p/DCNavigationMenu.svg?style=flat)](http://cocoapods.org/pods/DCNavigationMenu)

## Usage
 <img src="https://raw.githubusercontent.com/youweit/DCNavigationMenu/master/screenshot/sreenshoot.gif" alt="DCLazyInstantiate" title="DCNavigationMenu">

```objective-c
CGRect frame = CGRectMake(0.0, 0.0, 200.0, self.navigationController.navigationBar.bounds.size.height);
_navigationMenuItem = [[DCNavigationMenuView alloc] initWithFrame:frame
															style:DCNavigationMenuViewStyleDown
														 delegate:self parentView:self.view
															items:self.menuItems
												   configureBlock:^(DCNavigationMenuDefaultCollectionViewCell *cell, id item) {
													   cell.title.text = item;
												   }];
```

To run the example project, clone the repo, and run `pod install` from the Example directory first.

## Requirements

## Installation

DCNavigationMenu is available through [CocoaPods](http://cocoapods.org). To install
it, simply add the following line to your Podfile:

```ruby
pod "DCNavigationMenu"
```

## Author

Youwei Teng, teng@dcard.cc

## License

DCNavigationMenu is available under the MIT license. See the LICENSE file for more info.
