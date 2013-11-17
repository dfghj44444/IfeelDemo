//
//  CustomImageView.h
//  LiveByTouch
//
//  Created by hao.li on 11-10-15.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Global.h"
#import "IconDownloader.h"
#import "BaseEntity.h"
@interface CustomImageView : UIImageView<IconDownloaderDelegate> {
	id<ClickedDelegate> imgDelegate;
	
	IconDownloader *downLoad;//异步下载图片  不用release
	UIActivityIndicatorView *progress;//活动图标
	
	Document type;//图片背景的类型
	
	int x;
	int y;
	int width;
	int height;
	
	id object;
	int tag;
	UIImage *image;
	
	NSString *imageUrl;
    
	BaseEntity *baseEntity;
}
@property(nonatomic,retain) id<ClickedDelegate> imgDelegate;
@property (nonatomic,retain) UIImage *image;
@property (nonatomic,retain) NSString *imageUrl;
@property(nonatomic,retain) id object;
@property(nonatomic) int tag;
@property(nonatomic,retain) BaseEntity *baseEntity;

- (int) getWidth;
- (int) getHeigth;
- (int) getX;
- (int) getY;

- (id)initWithFrame:(CGRect)frame :(Document)docType;

- (void) setPosition:(CGPoint)point;

@end
