//
//  View.h
//  Pringles
//
//  Created by  on 12-4-4.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CornerRadiusView : UIView{
    UIView *subsubView;
}
- (void)addView:(UIView *)view;
- (int) getWidth;
- (int) getHeigth;
- (int) getX;
- (int) getY;
@end
