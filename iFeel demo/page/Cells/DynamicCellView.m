//
//  DynamicCellView.m
//  Pringles
//
//  Created by hao li on 12-3-27.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//


#import "DynamicCellView.h"
#import "DynamicInfo.h"

#import "SX_Dynamic.h"

#import "UIButton+Curled.h"
#import "UIImageView+Curled.h"
@implementation DynamicCellView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // 在这里创建对象
        subView = [[BubbleView alloc] initWithFrame1:CGRectMake(0, 5, 320, frame.size.height)];
        lvContent = [[LableView alloc] initWithFrame:CGRectMake(80, 5, 185, 20)];
        lvContent.backgroundColor = [UIColor clearColor];
        imphoto = [[CustomImageView alloc]initWithFrame:CGRectMake(10, 10, 65, 67)];
        
        
        
        [imphoto setContentMode:UIViewContentModeScaleToFill];
        [imphoto setImage:[UIImage imageNamed:@"user@2x.jpg"] borderWidth:3.0 shadowDepth:10.0 controlPointXOffset:30.0 controlPointYOffset:70.0];
        
        
        [subView addSubview:imphoto];
        [subView addSubview:lvContent];
        
        int originY = subView.frame.origin.y+subView.frame.size.height;
        int height = 20;
        
        //来源
        lvLaiyuan = [[LableView alloc]initWithFrame:CGRectMake([imphoto getX], originY, 40, height)];
        [lvLaiyuan setContent:@"来源:"];
        [lvLaiyuan setFont:[UIFont systemFontOfSize:15]];
        lvLaiyuan.backgroundColor = [UIColor clearColor];
        //来自于
        lvFrom = [[LableView alloc]initWithFrame:CGRectMake([imphoto getX]+40, originY, 120, height)];
        [lvFrom setContent:@"互联网"];
        [lvFrom setFont:[UIFont systemFontOfSize:15]];
        lvFrom.backgroundColor = [UIColor clearColor];
        
        //评论
        btnCommentary = [[ButtonView alloc]initWithName:@"Commentary@2x.png" :@""];
        [btnCommentary setPosition:CGPointMake(180, originY)];
        [btnCommentary addTarget:self action:@selector(commentary:) forControlEvents:UIControlEventTouchUpInside];
        
        //条数
        lvCommentary = [[LableView alloc]initWithFrame:CGRectMake(180+[btnCommentary getWidth]+5, originY, 40, height)];
        [lvCommentary setContent:@"100"];
        [lvCommentary setFont:[UIFont systemFontOfSize:10]];
        lvCommentary.backgroundColor = [UIColor clearColor];
        lvCommentary.lblDelegate = self;
        lvCommentary.tag = 1;
        
        //转发
        btnRepeater = [[ButtonView alloc]initWithName:@"Repeater@2x.png" :@""];
        [btnRepeater setPosition:CGPointMake([lvCommentary getX]+[lvCommentary getWidth]+5, originY)];
        
        //转发条数
        lvRepeater = [[LableView alloc]initWithFrame:CGRectMake([btnRepeater getX]+[btnRepeater getWidth]+5, originY, 40, height)];
        [lvRepeater setContent:@"1000000"];
        [lvRepeater setFont:[UIFont systemFontOfSize:10]];
        lvRepeater.backgroundColor = [UIColor clearColor];
        lvRepeater.lblDelegate = self;
        lvRepeater.tag = 2;
        
        //UIImage *bgimage = [UIImage imageNamed:@"scoretvbg.png"];
        //UIImage *bgimage = [UIImage imageNamed:@"Dynamic_bg.png"];
        // subView.backgroundColor = [[UIColor alloc]initWithPatternImage:bgimage];
        [self addSubview:subView];
        [self addSubview:lvLaiyuan];
        [self addSubview:lvFrom];
        [self addSubview:btnCommentary];
        [self addSubview:lvCommentary];
        [self addSubview:btnRepeater];
        [self addSubview:lvRepeater];
    }
    return self;
}

/**
 在这里赋值
 */
-(void) setBaseEntity:(BaseEntity *)value{
    [super setBaseEntity:value];
    
    DynamicInfo *di = (DynamicInfo*)baseEntity;
	
    subView.frame = CGRectMake(0, 5, 320, [di getCellHeight]-30);
	
	self.frame = CGRectMake(0, 0, 320, [di getCellHeight]);
    
    int originY = subView.frame.origin.y +subView.frame.size.height+5;
    int height = 20;
    
    //来源
    lvLaiyuan.frame = CGRectMake([imphoto getX],originY,40,height);
    //来自于
    lvFrom.frame = CGRectMake([imphoto getX]+40, originY, 120, height);
    //
    lvContent.frame = CGRectMake([imphoto getX] + [imphoto getWidth] + 5,  [imphoto getY], 215, [lvContent getHeigth]);
    [lvContent setContent:di.mcontent];
    //评论
    btnCommentary.frame = CGRectMake(180, originY+5, [btnCommentary getWidth], [btnCommentary getHeigth]);
    //条数
    lvCommentary.frame = CGRectMake(180+[btnCommentary getWidth]+5, originY, 40, height);
    //转发
    btnRepeater.frame = CGRectMake([lvCommentary getX]+[lvCommentary getWidth]+5, originY+3, [btnRepeater getWidth], [btnRepeater getHeigth]);
    //转发条数
    lvRepeater.frame = CGRectMake([btnRepeater getX]+[btnRepeater getWidth]+5, originY, 40, height);
    
    
    if (di.mpics==nil) {
        imphoto.hidden = YES;
    }
    else {
        imphoto.hidden = NO;
        imphoto.imageUrl = di.mpics;
    }
}

//从这里要调用主控制器的方法了
- (void)commentary:(id)sender {
    SX_Dynamic *dc = (SX_Dynamic*)target;
    [dc breakPage:row];
}

/**
 这个是lableview的委托哈　　记住了
 */
-(void) someLikeButton:(id)sender{
    //条数
    if ([sender tag]==1) {
        
    }
    //转发条数
    else if([sender tag] == 1){
        
    }
    SX_Dynamic *dc = (SX_Dynamic*)target;
    //这里可以调用不同类型的　主控制器的方法
    [dc breakPage:row];
}

/*
 // Only override drawRect: if you perform custom drawing.
 // An empty implementation adversely affects performance during animation.
 - (void)drawRect:(CGRect)rect
 {
 // Drawing code
 }
 */

-(void) dealloc{
    [lvContent release];
    lvContent=nil;
    [imphoto release];
    imphoto = nil;
    [subView release];
    subView = nil;
    [lvLaiyuan release];
    lvLaiyuan = nil;
    [lvFrom release];
    lvFrom = nil;
    [btnCommentary release];
    btnCommentary = nil;
    [lvCommentary release];
    lvCommentary = nil;
    [btnRepeater release];
    btnRepeater = nil;
    [lvRepeater release];
    lvRepeater = nil;
    [super dealloc];
}

@end