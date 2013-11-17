//
//  BaseView.h
//  LiveByTouch
//
//  Created by hao.li on 11-8-22.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface BaseView : UIView {

}
- (int) getWidth;
- (int) getHeigth;
- (int) getX;
- (int) getY;
- (void) setPosition:(CGPoint)point;
@end
