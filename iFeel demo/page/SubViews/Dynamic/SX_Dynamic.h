//
//  NearController.h
//  Pringles
//
//  Created by  on 12-3-27.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import "BaseController.h"
#import "TableView.h"
@interface SX_Dynamic : BaseController<UITableViewDelegate,UITableViewDataSource>{
    TableView *tvDynamic;
}
-(void) breakPage:(int)row;
@end
