//
//  BaseLayer.h
//  LiveByTouch
//
//  Created by hao.li on 11-10-14.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <QuartzCore/QuartzCore.h>
#import <Foundation/Foundation.h>

@interface BaseLayer : CALayer {
	int x;
	int y;
	int width;
	int height;
	
	id object;
	int tag;
}
@property(nonatomic,retain) id object;
@property(nonatomic) int tag;
- (int) getWidth;
- (int) getHeigth;
- (int) getX;
- (int) getY;
@end
