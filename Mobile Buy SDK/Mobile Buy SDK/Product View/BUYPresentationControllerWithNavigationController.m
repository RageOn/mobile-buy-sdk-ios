//
//  BUYPresentationControllerWithNavigationController.m
//  Mobile Buy SDK
//
//  Created by Rune Madsen on 2015-07-09.
//  Copyright (c) 2015 Shopify Inc. All rights reserved.
//

#import "BUYNavigationController.h"
#import "BUYOptionSelectionNavigationController.h"
#import "BUYPresentationControllerWithNavigationController.h"
#import "BUYImageKit.h"

@implementation BUYPresentationControllerWithNavigationController

- (UIViewController *)presentationController:(UIPresentationController *)controller viewControllerForAdaptivePresentationStyle:(UIModalPresentationStyle)style
{
	BUYNavigationController *navigationController = [[BUYNavigationController alloc] initWithRootViewController:controller.presentedViewController];
	UIImage *closeButton = [BUYImageKit imageOfProductViewCloseImageWithFrame:CGRectMake(0, 0, 22, 22)];
	UIBarButtonItem *barButtonItem = [[UIBarButtonItem alloc] initWithImage:closeButton style:UIBarButtonItemStylePlain target:self action:@selector(dismissPopover)];
	barButtonItem.tintColor = [UIColor whiteColor];
	navigationController.topViewController.navigationItem.leftBarButtonItem = barButtonItem;
	return navigationController;
}

- (void)dismissPopover
{
	if ([self.presentationDelegate respondsToSelector:@selector(presentationControllerWillDismiss:)]) {
		[self.presentationDelegate presentationControllerWillDismiss:self];
	}
	[self.presentedViewController dismissViewControllerAnimated:YES completion:^{
		if ([self.presentationDelegate respondsToSelector:@selector(presentationControllerDidDismiss:)]) {
			[self.presentationDelegate presentationControllerDidDismiss:self];
		}
	}];
}

- (UIModalPresentationStyle)adaptivePresentationStyle
{
	return (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPhone) ? UIModalPresentationFullScreen : UIModalPresentationFormSheet;
}

- (UIModalPresentationStyle)adaptivePresentationStyleForTraitCollection:(UITraitCollection *)traitCollection NS_AVAILABLE_IOS(8_3)
{
	return (traitCollection.horizontalSizeClass == UIUserInterfaceSizeClassCompact) ? UIModalPresentationFullScreen : UIModalPresentationFormSheet;
}

@end