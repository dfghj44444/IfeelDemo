//
//  ButtonView.m
//  LiveByTouch
//
//  Created by hao.li on 11-7-19.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "ButtonView.h"
#import "ImageView.h"


@implementation ButtonView
@synthesize object,row;

-(id) initWithName:(NSString*)path :(NSString*)title
{
	//x,y,width,height=0;
	self = [super init];
	if(path!=nil)
	{
		ImageView *iv=[[ImageView alloc] initWithPath:path ImageType:ImageDefault];
		[self setBackgroundImage:iv.image forState:UIControlStateNormal];
		
		//self.frame = [iv getImageViewFrame];
		self.frame = CGRectMake(0, 0, [iv getWidth], [iv getHeigth]);
		x = self.frame.origin.x;
		y = self.frame.origin.y;
		width = self.frame.size.width;
		height = self.frame.size.height;
		[iv release];
	}
	if(title!=nil)
	{
		[self setTitle:title forState:UIControlStateNormal];
		self.titleLabel.font = [UIFont boldSystemFontOfSize:12];
		[self setTitleColor:[UIColor blueColor] forState:UIControlStateNormal];   
		[self setTitleColor:[UIColor blackColor] forState:UIControlStateHighlighted];
		self.contentHorizontalAlignment = UIControlContentHorizontalAlignmentCenter;
		self.contentEdgeInsets = UIEdgeInsetsMake(0, 3, 0, 20);
	}
	
	return self;
}

-(id) initWithFrameAndMore:(CGRect)frame :(NSString*)path :(NSString*)title
{
	//x,y,width,height=0;
	self = [super init];
	if(path!=nil)
	{
		//UIImage *buttonImageNormal = [UIImage imageNamed:path];
		UIImage *buttonImageNormal = [UIImage imageWithContentsOfFile:[[NSBundle mainBundle] pathForResource:path ofType:nil]];
		UIImage *stretchableButtonImageNormal = [buttonImageNormal  
												 stretchableImageWithLeftCapWidth:12 topCapHeight:0];//设置帽端为12px,也是就左边的12个像素不参与拉伸,有助于圆角图片美观  
		[self setBackgroundImage:stretchableButtonImageNormal  
									 forState:UIControlStateNormal];
		//[buttonImageNormal release];
		if (frame.size.width == 0 ) {
			frame.size.width = buttonImageNormal.size.width;
		}
		if (frame.size.height == 0) {
			frame.size.height = buttonImageNormal.size.height;
		}
		self.frame = frame;
		x = self.frame.origin.x;
		y = self.frame.origin.y;
		width = self.frame.size.width;
		height = self.frame.size.height;
	}
	if(title!=nil)
	{
		self.titleLabel.font = [UIFont systemFontOfSize:12];
		[self setTitle:title forState:UIControlStateNormal];
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

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code.
}
*/

- (void)dealloc {
    [super dealloc];
}


@end
