//
//  View.m
//  Pringles
//
//  Created by  on 12-4-4.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import "CornerRadiusView.h"
#import <QuartzCore/QuartzCore.h>
#import <Foundation/Foundation.h>

@implementation CornerRadiusView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        
        self.layer.shadowColor = [UIColor blackColor].CGColor;
        self.layer.shadowOffset = CGSizeMake(2, 2);
        self.layer.shadowOpacity = 0.5; 
        self.layer.shadowRadius = 1.0;
        
        subsubView = [[UIView alloc] initWithFrame:CGRectMake(1, 1, self.frame.size.width-2, self.frame.size.height-2)];
        subsubView.backgroundColor = [UIColor whiteColor];
        subsubView.alpha = 1;
        subsubView.layer.cornerRadius = 2;
        subsubView.layer.masksToBounds = YES;
        subsubView.opaque = NO;
        [self addSubview:subsubView];
    }
    return self;
}


- (void)addView:(UIView *)view{
    [subsubView addSubview:view];
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
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/

- (void)dealloc {
    [subsubView release];
    [super dealloc];
}

@end
