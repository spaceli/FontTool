//
//  StringSettingViewController.h
//  FontTool
//
//  Created by 李帅 on 8/11/14.
//  Copyright (c) 2014 hehuababy. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>


@interface StringSettingViewController : UIViewController 

@property (nonatomic,strong)UITextView *textView;

@end




@interface Config : NSObject
@property (nonatomic,copy)NSString *string;

+ (Config *)config;
@end