//
//  PicturesViewController.h
//  SecurityInfo
//
//  Created by Minami Sophia Aramaki on 2013/10/15.
//  Copyright (c) 2013年 Minami Sophia Aramaki. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface PicturesViewController : UITableViewController<UIActionSheetDelegate>{
    IBOutlet UITableView *tv;
    int rows;
    NSString *rowtitle[100];
    NSUserDefaults *store;
}

@property (strong, nonatomic) UIImage *image;

@end
