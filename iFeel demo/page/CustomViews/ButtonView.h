//
//  ButtonView.h
//  LiveByTouch
//
//  Created by hao.li on 11-7-19.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface ButtonView : UIButton {
	int x;
	int y;
	int width;
	int height;
	
	id object;
    
    int row;
}
@property(nonatomic,retain) id object;
@property(nonatomic) int row;
-(id) initWithName:(NSString*)path :(NSString*)title;
-(id) initWithFrameAndMore:(CGRect)frame :(NSString*)path :(NSString*)title;//用与拉升的背景图片
- (int) getWidth;
- (int) getHeigth;
- (int) getX;
- (int) getY;
- (void) setPosition:(CGPoint)point;
@end
