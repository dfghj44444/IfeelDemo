//
//  BaseTabController.h
//  LiveByTouch
//
//  Created by hao.li on 11-8-29.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CustomTabBar.h"
#import "Global.h"
#import "BaseController.h"
@interface BaseTabController : BaseController<CustomTabBarDelegate> {
	NSArray* tabBarItems;
	BreakType breakFromPage;//跳转到来自哪里的页面
	
	BaseController *childController;//通知tabbar里面子试图  添加一系列的动作
}
@property (nonatomic) BreakType breakFromPage;
@property(nonatomic,retain) BaseController *childController;
-(void) showParent;

@end
