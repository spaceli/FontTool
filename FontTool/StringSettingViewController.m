//
//  StringSettingViewController.m
//  FontTool
//
//  Created by 李帅 on 8/11/14.
//  Copyright (c) 2014 hehuababy. All rights reserved.
//

#import "StringSettingViewController.h"

@implementation StringSettingViewController

- (void)loadView {
    self.view = self.textView;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.textView.text = [Config config].string;
    
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemDone target:self action:@selector(dismiss)];
}
- (UITextView *)textView {
    if (!_textView) {
        _textView = [[UITextView alloc] init];
    }
    return _textView;
}

- (void)dismiss {
    [Config config].string = self.textView.text;
    [self dismissViewControllerAnimated:YES completion:nil];
}
@end



@implementation Config

+ (Config *)config {
    static Config *instance = nil;
    
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        instance = [[self alloc] init];
    });
    
    return instance;
}
- (NSString *)string {
    NSString *string = [[NSUserDefaults standardUserDefaults] objectForKey:@"string"];
    if (!string) {
        string = @"跟宝宝一起成长、身边的育儿达人、温柔呵护宝宝和你";
    }
    return string;
}
- (void)setString:(NSString *)string {
    [[NSUserDefaults standardUserDefaults] setObject:string forKey:@"string"];
    [[NSUserDefaults standardUserDefaults] synchronize];
}
@end