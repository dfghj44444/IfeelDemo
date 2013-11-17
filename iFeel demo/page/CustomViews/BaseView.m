//
//  BaseView.m
//  LiveByTouch
//
//  Created by hao.li on 11-8-22.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "BaseView.h"
#import <QuartzCore/QuartzCore.h>
#import "Global.h"

@implementation BaseView

- (id)initWithFrame:(CGRect)frame {
	
    if (self = [super initWithFrame:frame]) {
		
		// Create a gradient background
//        CAGradientLayer *gradientBackground = [CAGradientLayer layer];
//        gradientBackground.frame = self.bounds;
//        gradientBackground.colors = [NSArray arrayWithObjects:(id)[TEXTCOLOR CGColor], (id)[NAVBARBGCOLOR CGColor], (id)[HEADERBGCOLOR CGColor], nil];
//        [self.layer insertSublayer:gradientBackground atIndex:0];
		
		UISearchBar *sb = [[UISearchBar alloc] initWithFrame:self.frame];
		for(id cc in [sb subviews])
		{
			if([cc isKindOfClass:[UITextField class]])
			{
				[cc removeFromSuperview];
			}
		}
		sb.tintColor = SEARCHBARBGCOLOR;
		[self addSubview:sb];
		[sb release];
    }
	
    return self;
}



- (int) getWidth{
	return self.frame.size.width;
}
- (int) getHeigth{
	return self.frame.size.height;
}
- (int) getX{
	return self.frame.origin.x;
}
- (int) getY{
	return self.frame.origin.y;
}
- (void) setPosition:(CGPoint)point{
	self.frame = CGRectMake(point.x, point.y, [self getWidth], [self getHeigth]);
}

@end
