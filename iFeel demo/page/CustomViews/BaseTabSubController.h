//
//  BaseTabSubController.h
//  LiveByTouch
//
//  Created by hao.li on 11-9-1.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BaseController.h"
#import "BaseTabController.h"

@interface BaseTabSubController : BaseController {
	BaseTabController *tbParent;
	
}
@property(nonatomic,retain)BaseTabController *tbParent;
@end
