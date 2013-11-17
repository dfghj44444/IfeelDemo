//
//  AlertImageView.h
//  LiveByTouch
//
//  Created by hao.li on 11-8-15.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ImageView.h"
#import "BaseController.h"

@interface AlertImageView : BaseController<IconDownloaderDelegate> {
	UIImage *image;
	ImageView *imageView;
	UIButton *btnMark;
	
	IconDownloader *downLoad;//异步下载图片  不用release
	UIActivityIndicatorView *alertProgress;//活动图标
}
-(void) setImage:(UIImage*)img;
-(void) showImage;

-(void) setImageUrl:(NSString*)url;
@end
