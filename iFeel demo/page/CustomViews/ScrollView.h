//
//  ScrollView.h
//  LiveByTouch
//
//  Created by hao.li on 11-7-18.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol ScrollDelegate <NSObject>
-(void) scrollTouchBegin:(NSSet *)touches withEvent:(UIEvent *)event inContentView:(UIView *)view;
-(void) scrollTouchEnd:(UIView *)view;
-(void) scrollTouchEnded:(NSSet *)touches withEvent:(UIEvent *)event;
@end
@interface ScrollView : UIScrollView<UIScrollViewDelegate> {
	id<ScrollDelegate> scrollDelegate;
}
@property (assign) id<ScrollDelegate> scrollDelegate;
@end
