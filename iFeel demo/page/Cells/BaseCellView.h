//
//  BaseCellView.h
//  LiveByTouch
//
//  Created by hao.li on 11-10-12.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ImageView.h"
#import "LableView.h"
#import "BaseEntity.h"
#import "BaseLayer.h"
#import "Global.h"
#import "CustomImageView.h"
#import "BaseController.h"

@interface BaseCellView : UIView {
	//id<CellsDelegate> delegate;
	CGRect imageRect;// = {{0, 0}, {100, 100}};
	CGPoint imagePoint;// = {0, 0};
	BaseEntity *baseEntity;// 不需要release
	BaseController *target;
	
	int row;
}
//@property (nonatomic,retain) id<CellsDelegate> delegate;
@property (nonatomic) CGRect imageRect;
@property (nonatomic) CGPoint imagePoint;
@property(nonatomic,assign) BaseController *target;
@property(nonatomic) int row;
@property(nonatomic,assign) BaseEntity *baseEntity;
-(NSString*) formatStr:(NSString *)str;

//-(void) randerEntity;
@end
