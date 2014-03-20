//
//  WheelDemoViewController.m
//  Wheel demo
//
//  Created by Wojciech Czekalski on 01.05.2012.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "WheelDemoViewController.h"
#import "CDCircleOverlayView.h"
#import "WrtingViewController.h"
#import "RecordViewController.h"
#import "FeedBackViewController.h"
#import "BrowseViewController.h"
#import "FMDatabase.h"
#import <sqlite3.h>
@interface WheelDemoViewController ()

@end

@implementation WheelDemoViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    CDCircle *circle = [[CDCircle alloc] initWithFrame:CGRectMake(10 , 90, 300, 300) numberOfSegments:8 ringWidth:80.f];
    circle.dataSource = self;
    circle.delegate = self;
    CDCircleOverlayView *overlay = [[CDCircleOverlayView alloc] initWithCircle:circle];
    
    self.view.backgroundColor = [UIColor colorWithRed:0.85 green:0.86 blue:0.85 alpha:0.95];//首页背景色
    
    [self.view addSubview:circle];
    //Overlay cannot be subview of a circle because then it would turn around with the circle
    [self.view addSubview:overlay];
    
    //添加左右按钮
    //UIBarButtonItem *rightItem = [[UIBarButtonItem alloc] initWithTitle:@"设置" style:UIBarButtonItemStyleBordered target:self action:@selector(testClick:)];
    //self.navigationItem.rightBarButtonItem = rightItem;
    
    UIBarButtonItem *leftItem = [[UIBarButtonItem alloc] initWithTitle:@"历史" style:UIBarButtonItemStyleBordered target:self action:@selector(OnRecordClick:)];
    self.navigationItem.leftBarButtonItem = leftItem;
    
    [self.navigationItem setTitle:@"Ifeel 0.13"];
    
    //添加imageview
    CGRect imageRect = (CGRect){105, 180, 110, 110};
    UIImageView *imageView = [[UIImageView alloc] initWithFrame:imageRect] ;
    imageView.userInteractionEnabled = YES;

    UITapGestureRecognizer *singleTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(onClickImage)];
    [imageView addGestureRecognizer:singleTap];
    [self.view addSubview:imageView];
    self._ImgView =imageView;
    //添加长按委托
    UILongPressGestureRecognizer *longGnizer=[[UILongPressGestureRecognizer alloc]initWithTarget:self
                                                                                          action:@selector(longGo:)];
    [self._ImgView addGestureRecognizer:longGnizer];
    UIImage *image = [UIImage imageNamed: @"text2.png"];
    [self._ImgView setImage: image];
    
    self->_curSegment = -1;
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    UIImage *image = [UIImage imageNamed: @"text.png"];
    [self._ImgView setImage: image];
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation != UIInterfaceOrientationPortraitUpsideDown);
}

#pragma mark - Circle delegate & data source

-(void) circle:(CDCircle *)circle didMoveToSegment:(NSInteger)segment thumb:(CDCircleThumb *)thumb {
    NSArray* arrayPic = [NSArray arrayWithObjects: @"a",@"b",@"c",@"d",@"e",@"f",@"g",@"h",nil];
    UIImage *image = [UIImage imageNamed: [NSString stringWithFormat:@"face/%@.png", [arrayPic objectAtIndex:segment]]];

    NSArray* array = [NSArray arrayWithObjects: @"吓尿",@"委屈",@"悲伤",@"尴尬",@"纳尼",@"呵呵",@"惊诧",@"卧槽",nil];
    [self.lblFace setText:[NSString stringWithFormat:@"%@", [array objectAtIndex:segment]]];
    
    self->_curSegment = segment;//record it

    
    [self._ImgView setImage: image];
}

-(UIImage *) circle:(CDCircle *)circle iconForThumbAtRow:(NSInteger)row {

    NSString *fileString = [[[NSBundle mainBundle] pathsForResourcesOfType:@"png" inDirectory:@"face/."] objectAtIndex:row*2];
    return [UIImage imageWithContentsOfFile:fileString];
}

//nSegnment：第几个表情 附加string详细心情0
+(void)AddRecord: (int)nSegment withString: (NSString*)strContent {
    NSString* docsdir = [NSSearchPathForDirectoriesInDomains( NSDocumentDirectory, NSUserDomainMask, YES) lastObject];
    NSString* dbpath = [docsdir stringByAppendingPathComponent:@"iFeel.sqlite"];
    FMDatabase* db = [FMDatabase databaseWithPath:dbpath];//没有则自己创建
    [db open];
    
    FMResultSet *rs = [db executeQuery:@"select count(*) as 'count' from sqlite_master where type ='table' and name = ?", @"faces"];
    while ([rs next]) {
        NSInteger count = [rs intForColumn:@"count"];
        if (0 == count){//表不存在
            [db executeUpdate:@"CREATE TABLE faces(uid integer primary key AUTOINCREMENT,face integer,content text,recordDate text)"];//心情，文字，日期
            NSLog(@"create failed: %@" ,[db lastErrorMessage] );
        }
    }
    
    NSString *insertSql1= [NSString stringWithFormat:@"INSERT INTO faces VALUES (null,%d, '%@', CURRENT_TIMESTAMP)",nSegment,strContent];
    bool Res = [db executeUpdate:insertSql1];
    if( false == Res)
        NSLog(@"insert failed: %@" ,[db lastErrorMessage] );
    
    [db close];
}

//短按
-(void)onClickImage{
    
    [WheelDemoViewController  AddRecord:self->_curSegment withString:@""];
    //clear
    UIImage *image = [UIImage imageNamed: @"text.png"];
    [self._ImgView setImage: image];
    // here, do whatever you wantto do
    FeedBackViewController *aViewController = [[FeedBackViewController alloc] init];
  
    [self.navigationController pushViewController:aViewController animated:TRUE];

    NSLog(@"imageview is clicked!");
}
//长按，弹出输入框
-(void)longGo:(UILongPressGestureRecognizer *)aGer{
    if (aGer.state==UIGestureRecognizerStateBegan) {
        //UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"请输入你现在的心情"  message:@"wangwang" delegate:nil //cancelButtonTitle:@"OK" otherButtonTitles: nil];
        //[alert show];
        WritingViewController *aViewController = [[WritingViewController alloc] initWithNibName:@"WritingView"   bundle:nil];
        if(self.navigationController != nil && self->_curSegment != -1)
        {
            //存好当前心情值
            NSUserDefaults *accountDefaults = [NSUserDefaults standardUserDefaults];
            [accountDefaults setInteger:self->_curSegment forKey:@"curSegment"];
            //clear
            UIImage *image = [UIImage imageNamed: @"text.png"];
            [self._ImgView setImage: image];
            
            [[self navigationController]  pushViewController:aViewController animated:true];
        }
    }
}

- (IBAction)testClick:(id)sender {
    FeedBackViewController *aViewController = [[FeedBackViewController alloc] init];
    if(self.navigationController == nil)
    {
        NSLog(@"nil");
        //[self presentModalViewController:aViewController animated:TRUE];
    }
    else if ( self->_curSegment != -1)
    {
        NSLog(@"not nil");
        [[self navigationController]  pushViewController:aViewController animated:true];
    }
 }

- (IBAction)OnRecordClick:(id)sender {
    BrowseViewController *aViewController = [[BrowseViewController alloc] init];
    //self.feedVc = aViewController;

    if(self.navigationController == nil)
    {
        NSLog(@"nil");
    }
    else
    {
        NSLog(@"not nil");
         [[self navigationController]  pushViewController:aViewController animated:true];
    }
}
@end
