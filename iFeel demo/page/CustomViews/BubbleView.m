//
//  BubbleView.m
//  Pringles
//
//  Created by hao li on 12-4-4.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import "BubbleView.h"

@implementation BubbleView
@synthesize viewDelegate;

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        UIImage *bubble = [UIImage imageWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"输入框01@2x.png" ofType:nil]];
		bubbleImageView = [[ImageView alloc] initWithImage:[bubble stretchableImageWithLeftCapWidth:6 topCapHeight:15]];
        //316
        int wdth = 320-[bubbleImageView getWidth];
        //subView = [[UIView alloc] initWithFrame:CGRectMake(wdth/2, 5, 320-wdth, frame.size.height)];
        self.frame = CGRectMake(wdth/2, 5, 320-wdth, frame.size.height);
        self.backgroundColor = [UIColor clearColor];
        [self addSubview:bubbleImageView];
        super.userInteractionEnabled = NO;
    }
    return self;
}

- (id)initWithFrame1:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        UIImage *bubble = [UIImage imageWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"scoretvbg@2x.png" ofType:nil]];
		bubbleImageView = [[ImageView alloc] initWithImage:[bubble stretchableImageWithLeftCapWidth:6 topCapHeight:15]];
        //316
        int wdth = 320-[bubbleImageView getWidth];
        //subView = [[UIView alloc] initWithFrame:CGRectMake(wdth/2, 5, 320-wdth, frame.size.height)];
        self.frame = CGRectMake(wdth/2, 5, 320-wdth, frame.size.height);
        self.backgroundColor = [UIColor clearColor];
        [self addSubview:bubbleImageView];
        super.userInteractionEnabled = NO;
    }
    return self;
}



-(void) setFrame:(CGRect)frame{
    //[super setFrame:frame];
    super.frame = CGRectMake((320-[bubbleImageView getWidth])/2, frame.origin.y, [bubbleImageView getWidth], frame.size.height);
    bubbleImageView.frame = CGRectMake(0, 0, self.frame.size.width, self.frame.size.height);    
}

-(void) setViewDelegate:(id <ClickedDelegate>)delegate{
	super.userInteractionEnabled = YES;
	viewDelegate = delegate;
}



- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    UITouch *aTouch = [touches anyObject];
	
	if (aTouch.tapCount == 1) {
        [NSObject cancelPreviousPerformRequestsWithTarget:self];		
		
    }
	
} 


- (void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event {
	UITouch *theTouch = [touches anyObject];
	
	if(theTouch.tapCount == 1 || theTouch.tapCount==0) //主界面只接受单击
	{
		[NSObject cancelPreviousPerformRequestsWithTarget:self];
		CGPoint touchPoint = [theTouch locationInView:self];	
		if (touchPoint.x>0&&touchPoint.y>0) {
			if (viewDelegate != nil) {
				[viewDelegate someLikeButton:self];
			}
		}
		
	}
}

/*
 // Only override drawRect: if you perform custom drawing.
 // An empty implementation adversely affects performance during animation.
 - (void)drawRect:(CGRect)rect
 {
 // Drawing code
 }
 */
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

-(void) dealloc{
    [bubbleImageView release];
    bubbleImageView = nil;
    [super dealloc];
}

@end
