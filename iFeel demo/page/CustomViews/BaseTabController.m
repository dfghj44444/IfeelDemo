    //
//  BaseTabController.m
//  LiveByTouch
//
//  Created by hao.li on 11-8-29.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "BaseTabController.h"

#define SELECTED_VIEW_CONTROLLER_TAG 98456345

@implementation BaseTabController
@synthesize breakFromPage;
@synthesize childController;

-(void) showParent{
	//我要点评
	if (breakFromPage == BreakSubReviews) {
		[self.navigationController popToViewController:[self.navigationController.viewControllers objectAtIndex:1] animated:YES];
	}
	//好友点评
	else if (breakFromPage == BreakFriendReviews) {
		[self.navigationController popToViewController:[self.navigationController.viewControllers objectAtIndex:1] animated:YES];
	}
	//我的点评
	else if (breakFromPage == BreakMyReviews) {
		[self.navigationController popToViewController:[self.navigationController.viewControllers objectAtIndex:1] animated:YES];
	}
	//好友转发
	else if (breakFromPage == BreakFriendFrowordReviews) {
		[self.navigationController popToViewController:[self.navigationController.viewControllers objectAtIndex:1] animated:YES];	
	}
	else
		[self.navigationController popViewControllerAnimated:YES];
}

-(void) PushToTop:(UIViewController *)subView{
//	if ([subView isMemberOfClass:[NearMapController class]]) {
//		[super PushToTop:subView];
//	}
//	else {
		[self.navigationController pushViewController:subView animated:YES];
//	}
}

- (void)viewWillAppear:(BOOL)animated{
	self.tabBar.hidden = YES;
	[self.navigationController  setNavigationBarHidden:YES animated:YES];
	
}
- (void)viewDidAppear:(BOOL)animated{
	self.tabBar.hidden = NO;
	//[super startmove:2 target:self.tabBar];
	[super moveYTarget:self.tabBar FromValue:self.tabBar.frame.size.height ToValue:0 Duration:0.3];
	[childController viewDidAppear:animated];
	self.view.backgroundColor = BARCOLOR;
}
- (void)viewWillDisappear:(BOOL)animated{
	self.tabBar.hidden = NO;
	//[super startmove:3 target:self.tabBar];
	[super moveYTarget:self.tabBar FromValue:0 ToValue:self.tabBar.frame.size.height Duration:0.4];
	[self.navigationController  setNavigationBarHidden:NO animated:YES];
}


// The designated initializer.  Override if you create the controller programmatically and want to perform customization that is not appropriate for viewDidLoad.
/*
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization.
    }
    return self;
}
*/

/*
// Implement loadView to create a view hierarchy programmatically, without using a nib.
- (void)loadView {
}
*/


// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
- (void)viewDidLoad {
    [super viewDidLoad];
	self.view.backgroundColor = BARBACKGROUND;
}


/*
// Override to allow orientations other than the default portrait orientation.
- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
    // Return YES for supported orientations.
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}
*/


#pragma mark -
#pragma mark CustomTabBarDelegate

- (UIImage*) imageFor:(CustomTabBar*)tabBar atIndex:(NSUInteger)itemIndex
{
	// Get the right data
	NSDictionary* data = [tabBarItems objectAtIndex:itemIndex];
	// Return the image for this tab bar item
	return [UIImage imageNamed:[data objectForKey:@"image"]];
}

- (UIImage*) backgroundImage
{
	// The tab bar's width is the same as our width
	CGFloat width = self.view.frame.size.width;
	// Get the image that will form the top of the background
	UIImage* topImage = [UIImage imageNamed:@"TabBarGradient.png"];
	
	// Create a new image context
	UIGraphicsBeginImageContextWithOptions(CGSizeMake(width, topImage.size.height*2), NO, 0.0);
	
	// Create a stretchable image for the top of the background and draw it
	UIImage* stretchedTopImage = [topImage stretchableImageWithLeftCapWidth:0 topCapHeight:0];
	[stretchedTopImage drawInRect:CGRectMake(0, 0, width, topImage.size.height)];
	
	// Draw a solid black color for the bottom of the background
	[[UIColor blackColor] set];
	CGContextFillRect(UIGraphicsGetCurrentContext(), CGRectMake(0, topImage.size.height, width, topImage.size.height));
	
	// Generate a new image
	UIImage* resultImage = UIGraphicsGetImageFromCurrentImageContext();
	UIGraphicsEndImageContext();
	
	return resultImage;
}

// This is the blue background shown for selected tab bar items
- (UIImage*) selectedItemBackgroundImage
{
	return [UIImage imageNamed:@"TabBarItemSelectedBackground.png"];
}

// This is the glow image shown at the bottom of a tab bar to indicate there are new items
- (UIImage*) glowImage
{
	UIImage* tabBarGlow = [UIImage imageNamed:@"TabBarGlow.png"];
	
	// Create a new image using the TabBarGlow image but offset 4 pixels down
	UIGraphicsBeginImageContextWithOptions(CGSizeMake(tabBarGlow.size.width, tabBarGlow.size.height-4.0), NO, 0.0);
	
	// Draw the image
	[tabBarGlow drawAtPoint:CGPointZero];
	
	// Generate a new image
	UIImage* resultImage = UIGraphicsGetImageFromCurrentImageContext();
	UIGraphicsEndImageContext();
	
	return resultImage;
}

// This is the embossed-like image shown around a selected tab bar item
- (UIImage*) selectedItemImage
{
	// Use the TabBarGradient image to figure out the tab bar's height (22x2=44)
	UIImage* tabBarGradient = [UIImage imageNamed:@"TabBarGradient.png"];
	CGSize tabBarItemSize = CGSizeMake(self.view.frame.size.width/tabBarItems.count, tabBarGradient.size.height*2);
	UIGraphicsBeginImageContextWithOptions(tabBarItemSize, NO, 0.0);
	
	// Create a stretchable image using the TabBarSelection image but offset 4 pixels down
	[[[UIImage imageNamed:@"TabBarSelection.png"] stretchableImageWithLeftCapWidth:4.0 topCapHeight:0] drawInRect:CGRectMake(0, 4.0, tabBarItemSize.width, tabBarItemSize.height-4.0)];  
	
	// Generate a new image
	UIImage* selectedItemImage = UIGraphicsGetImageFromCurrentImageContext();
	UIGraphicsEndImageContext();
	
	return selectedItemImage;
}

- (UIImage*) tabBarArrowImage
{
	return [UIImage imageNamed:@"TabBarNipple.png"];
}

- (void) touchDownAtItemAtIndex:(NSUInteger)itemIndex
{	
	// Remove the current view controller's view
	UIView* currentView = [self.view viewWithTag:SELECTED_VIEW_CONTROLLER_TAG];
	[currentView removeFromSuperview];
	
	// Get the right view controller
	NSDictionary* data = [tabBarItems objectAtIndex:itemIndex];
	UIViewController* viewController = [data objectForKey:@"viewController"];
	
	// Use the TabBarGradient image to figure out the tab bar's height (22x2=44)
	UIImage* tabBarGradient = [UIImage imageNamed:@"TabBarGradient.png"];
	
	// Set the view controller's frame to account for the tab bar
	viewController.view.frame = CGRectMake(0,0,self.view.frame.size.width, self.view.frame.size.height-(tabBarGradient.size.height*2));
	
	// Se the tag so we can find it later
	viewController.view.tag = SELECTED_VIEW_CONTROLLER_TAG;
	
	// Add the new view controller's view
	[self.view insertSubview:viewController.view belowSubview:tabBar];
	
	// In 1 second glow the selected tab
	[NSTimer scheduledTimerWithTimeInterval:0.2 target:self selector:@selector(addGlowTimerFireMethod:) userInfo:[NSNumber numberWithInteger:itemIndex] repeats:NO];
	
}

- (void)addGlowTimerFireMethod:(NSTimer*)theTimer
{
	// Remove the glow from all tab bar items
	for (NSUInteger i = 0 ; i < tabBarItems.count ; i++)
	{
		[tabBar removeGlowAtIndex:i];
	}
	
	// Then add it to this tab bar item
	[tabBar glowItemAtIndex:[[theTimer userInfo] integerValue]];
}


- (void)didReceiveMemoryWarning {
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Release any cached data, images, etc. that aren't in use.
}

- (void)viewDidUnload {
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}


- (void)dealloc {
	[tabBarItems release];
	tabBarItems = nil;
    [super dealloc];
}


@end
