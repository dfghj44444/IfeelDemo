//
//  ImageView.h
//  LiveByTouch
//
//  Created by hao.li on 11-7-18.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Global.h"
#import "IconDownloader.h"

@interface ImageView : UIImageView<IconDownloaderDelegate> {
	UIView *temp;
	IconDownloader *downLoad;//异步下载图片  不用release
	UIActivityIndicatorView *progress;//活动图标
	int imageType;//图片类型
	
	UIView *parentView;
	NSString *imageUrl;//缓存图片的名字
	
	id<ClickedDelegate> imgDelegate;
	NSString *record;//记录ID
	int recordId;
	id object;
	
}
@property(assign) id<ClickedDelegate> imgDelegate;
@property(nonatomic,retain) NSString *record;
@property(nonatomic,retain) id object;
@property(nonatomic) int recordId;

- (id)initWithImage:(UIImage *)image ImageType:(ImageType)type;

- (id)initWithFrame:(CGRect)frame Path:(NSString*)imagepath ImageType:(ImageType)type;

- (id)initWithPath:(NSString*)imagepath ImageType:(ImageType)type;


- (void) displayImage:(UIView*)view IconURL:(NSString*)url ImageType:(ImageType)type CacheTp:(CacheType)type SaveType:(Document)docType;
- (void) setParentView:(UIView*)view;
- (int) getWidth;
- (int) getHeigth;
- (int) getX;
- (int) getY;
- (void) setPosition:(CGPoint)point;
@end
