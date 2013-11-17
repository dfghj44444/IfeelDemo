//
//  DynamicCellView.h
//  Pringles
//
//  Created by hao li on 12-3-27.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BaseCellView.h"
#import "BubbleView.h"

@interface DynamicCellView : BaseCellView<ClickedDelegate>{
    LableView *lvContent;
    CustomImageView *imphoto;
    BubbleView *subView;
    
    LableView *lvLaiyuan;
    LableView *lvFrom;
    ButtonView *btnCommentary;
    LableView *lvCommentary;
    ButtonView *btnRepeater;
    LableView *lvRepeater;
}

@end
