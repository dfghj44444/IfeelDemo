//
//  DynamicCell.m
//  Pringles
//
//  Created by hao li on 12-3-27.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import "DynamicCell.h"
#import "DynamicCellView.h"

@implementation DynamicCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
        if (self) {
            self.selectionStyle = UITableViewCellSelectionStyleNone;
            baseCellView = [[[DynamicCellView alloc] initWithFrame:CGRectZero] autorelease];
            [self.contentView addSubview:baseCellView];
        }
    }
    return self;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
