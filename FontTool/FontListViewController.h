//
//  FontListViewController.h
//  FontTool
//
//  Created by 李帅 on 8/11/14.
//  Copyright (c) 2014 hehuababy. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface FontListViewController : UITableViewController <UITextFieldDelegate>{
    NSMutableArray *_items;
    int _fontSize;
}
- (id)initWithGrouped;
@end
