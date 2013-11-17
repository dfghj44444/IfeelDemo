//
//  BrowseViewController.m
//  Wheel demo
//
//  Created by dfghj44444 on 13-11-12.
//
//

#import "BrowseViewController.h"
#define originalHeight 25.0f
#define newHeight 85.0f
#define isOpen @"85.0f"

@interface BrowseViewController ()

@end

@implementation BrowseViewController
{
    NSInteger count;
    NSMutableDictionary *dicClicked;
    CGFloat mHeight;
    NSInteger sectionIndex;
}

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];

    count = 0;
    mHeight = originalHeight;
    sectionIndex = 0;
    dicClicked = [NSMutableDictionary dictionaryWithCapacity:3];
    
    /*CGRect imageRect = (CGRect){0, 0, 320, 140};
    UIImageView *aImageView = [[UIImageView alloc] initWithFrame:imageRect] ;
    UIImage *image = [UIImage imageNamed: @"head.png"];
    [aImageView setImage: image];
    //[self.view addSubview:aImageView];
    [self.tableView addSubview:aImageView];

    imageRect = (CGRect){0, 140, 320, 30};
    UIImageView *ImageViewDate = [[UIImageView alloc] initWithFrame:imageRect] ;
    UIImage *image2 = [UIImage imageNamed: @"date.png"];
    [ImageViewDate setImage: image2];
    [self.tableView addSubview:ImageViewDate];
    
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    UIImage *image3 = [UIImage imageNamed:@"tail.png"];
    button.frame = CGRectMake(0.0,self.view.frame.size.height - 18, 320,17);
    [button setBackgroundImage:image3 forState:UIControlStateNormal];
    [button addTarget:self action:@selector(showMeun:) forControlEvents:UIControlEventTouchDown];
    button.tag = 111;
    [self.view.window addSubview:button];*/
 }

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;

}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{    // Return the number of sections.
    return 10;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    // Return the number of rows in the section.
    return 2;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
        static NSString *contentIndentifer = @"Container";
        if (indexPath.row != 0) {//第一个
            UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:contentIndentifer];
            if (cell == nil) {
                cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:contentIndentifer];
            }
            NSString *statisticsContent = @"rlf:就今天天气好晴朗aassscccvcvbcv恶如通过对会计法规科技的复古包包vjhcv";
            cell.textLabel.font = [UIFont systemFontOfSize:14.0f];
            cell.textLabel.text = statisticsContent;
            cell.textLabel.textColor = [UIColor brownColor];
            cell.textLabel.opaque = NO; // 选中Opaque表示视图后面的任何内容都不应该绘制
            cell.textLabel.numberOfLines = 9;
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            return cell;
        }

        static NSString *CellIdentifier = @"Cell";
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
        if (cell == nil) {
            cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
        }
        cell.imageView.image = [UIImage imageNamed:@"content.png"];
        NSArray* array = [NSArray arrayWithObjects: @"开心",  @"难过",@"纠结",@"悲伤",@"不忿",@"大怒",@"惊诧",@"忧伤",@"怅然",@"顿悟",nil];
        cell.textLabel.text = [NSString stringWithFormat:@"%@",[array objectAtIndex:count%8]];
        count++;
        return cell;
}


//Section的标题栏高度
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    if (section == 0)
        return 170;
    else
        return 1.0f;
}


-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    CGRect headerFrame = CGRectMake(0, 0, 300, 30);
    CGFloat y = 2;

    if (section == 0) {

        
        headerFrame = CGRectMake(0, 0, 300, 100);
        UIView *headerView = [[UIView alloc] initWithFrame:headerFrame];
        
        CGRect imageRect = (CGRect){0, 0, 320, 140};
        UIImageView *aImageView = [[UIImageView alloc] initWithFrame:imageRect] ;
        UIImage *image = [UIImage imageNamed: @"head.png"];
        [aImageView setImage: image];
        //[self.view addSubview:aImageView];
        [headerView addSubview:aImageView];
        
        imageRect = (CGRect){0, 140, 320, 30};
        UIImageView *ImageViewDate = [[UIImageView alloc] initWithFrame:imageRect] ;
        UIImage *image2 = [UIImage imageNamed: @"date.png"];
        [ImageViewDate setImage: image2];
        [headerView addSubview:ImageViewDate];
        return headerView;
        
    }
    
    //if(count < 4)
        return nil;
    UIView *headerView = [[UIView alloc] initWithFrame:headerFrame];
    UILabel *dateLabel=[[UILabel alloc] initWithFrame:CGRectMake(20, y, 240, 24)];//日期标签
    dateLabel.font=[UIFont boldSystemFontOfSize:16.0f];
    dateLabel.textColor = [UIColor darkGrayColor];
    dateLabel.backgroundColor=[UIColor clearColor];
    UILabel *ageLabel=[[UILabel alloc] initWithFrame:CGRectMake(216, y, 88, 24)];//年龄标签
    ageLabel.font=[UIFont systemFontOfSize:14.0];
    ageLabel.textAlignment=UITextAlignmentRight;
    ageLabel.textColor = [UIColor darkGrayColor];
    ageLabel.backgroundColor=[UIColor clearColor];
    
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    dateFormatter.dateFormat = @"MM dd,yyyy";
    dateLabel.text = [NSString stringWithFormat:@"%@",[dateFormatter stringFromDate:[NSDate date]]];
    ageLabel.text = @"2天前";
    
    [headerView addSubview:dateLabel];
    [headerView addSubview:ageLabel];
    return headerView;
}

#pragma mark - Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row == 0) {
        UITableViewCell *targetCell = [tableView cellForRowAtIndexPath:indexPath];
        if (targetCell.frame.size.height == originalHeight+1){
            [dicClicked setObject:isOpen forKey:indexPath];
        }
        else{
            [dicClicked removeObjectForKey:indexPath];
        }
        [self.tableView reloadRowsAtIndexPaths:[NSArray arrayWithObject:indexPath] withRowAnimation:UITableViewRowAnimationFade];
    }
    NSLog(@"indexPath=%@",indexPath);
    NSLog(@"dicClicked=%@",dicClicked);
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row == 0) {
        if ([[dicClicked objectForKey:indexPath] isEqualToString: isOpen])
            return [[dicClicked objectForKey:indexPath] floatValue];
        else
            return originalHeight;
    }
    else {
        return 45.0f;
    }
}


@end
