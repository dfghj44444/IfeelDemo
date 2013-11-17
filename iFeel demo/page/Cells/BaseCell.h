//
//  BaseCell.h
//  LiveByTouch
//
//  Created by hao.li on 11-7-22.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ImageView.h"
#import "LableView.h"
#import "BaseCellView.h"
#import "BaseEntity.h"
#import "BaseController.h"


@interface BaseCell : UITableViewCell {
	//id<CellsDelegate> delegate;
	BaseCellView *baseCellView;//不用release
}
//@property(nonatomic,retain) id<CellsDelegate> delegate;
@property(nonatomic,assign) BaseCellView *baseCellView;
-(void) setTarget:(BaseController *)value;
-(void) setBaseEntity:(BaseEntity *)value;
-(void) setRow:(int) value;
@end
