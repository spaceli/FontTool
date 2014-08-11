//
//  FontListViewController.m
//  FontTool
//
//  Created by 李帅 on 8/11/14.
//  Copyright (c) 2014 hehuababy. All rights reserved.
//

#import "FontListViewController.h"
#import "StringSettingViewController.h"

@implementation FontListViewController

- (id)initWithGrouped
{
    self = [self initWithStyle:UITableViewStyleGrouped];
    _fontSize = 14;
    return self;
}

- (id)initWithStyle:(UITableViewStyle)style {
    self = [super initWithStyle:style];
    if (self) {
        _items = [[NSMutableArray alloc] init];
        
        UIFont *systemFont = [UIFont systemFontOfSize:_fontSize];
        UIFont *systemBoldFont = [UIFont boldSystemFontOfSize:_fontSize];
        [_items addObject:@"System Font"];
        [_items addObject:[NSArray arrayWithObjects:[systemFont fontName],[systemBoldFont fontName], nil]];
        
        int total = 0;
        NSArray *familyNames = [UIFont familyNames];
        for( NSString *familyName in familyNames ){
            [_items addObject:familyName];
            NSArray *fontNames = [UIFont fontNamesForFamilyName:familyName];
            [_items addObject:fontNames];
            total += fontNames.count;
        }
        self.title = [NSString stringWithFormat:@"共%d种字体",total];
    }
    return self;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    
    UITextField *fontSizeField = [[UITextField alloc] initWithFrame:CGRectMake(0, 7, 70, 30)];
    fontSizeField.borderStyle = UITextBorderStyleRoundedRect;
    //    fontSizeField.backgroundColor = [UIColor whiteColor];
    fontSizeField.delegate = self;
    fontSizeField.returnKeyType = UIReturnKeyDone;
    fontSizeField.keyboardType = UIKeyboardTypeNumbersAndPunctuation;
    fontSizeField.placeholder = [NSString stringWithFormat:@"%d号字",_fontSize];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:fontSizeField];
    
    
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemCompose target:self action:@selector(setString)];
}
- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self.tableView reloadData];
}
- (void)setString {
    StringSettingViewController *controller = [[StringSettingViewController alloc] init];
    UINavigationController *navController = [[UINavigationController alloc] initWithRootViewController:controller];
    [self.navigationController presentViewController:navController animated:YES completion:nil];
}
#pragma mark -
#pragma mark UITableViewDataSource
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    NSArray *subItems = [_items objectAtIndex:2*indexPath.section+1];
    NSString *fontName = [subItems objectAtIndex:indexPath.row];
    NSString *text = [NSString stringWithFormat:@"%ld.%ld  %@\n%@",(long)indexPath.section,(long)indexPath.row,fontName,[Config config].string];
    UIFont *font = [UIFont fontWithName:fontName size:_fontSize];
    CGSize size = [text boundingRectWithSize:CGSizeMake(280, 0) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:font} context:NULL].size;
    
    return size.height + 20;
}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return [_items count]/2;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [[_items objectAtIndex:2*section+1] count];
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
    return [_items objectAtIndex:2*section];
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"menu"];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"menu"];
    }
    
    NSArray *subItems = [_items objectAtIndex:2*indexPath.section+1];
    NSString *fontName = [subItems objectAtIndex:indexPath.row];
    
    cell.textLabel.text = [NSString stringWithFormat:@"%ld.%ld  %@\n%@",(long)indexPath.section,(long)indexPath.row,fontName,[Config config].string];
    
    cell.textLabel.numberOfLines = 0;
    
    UIFont *secondFont = [UIFont fontWithName:fontName size:_fontSize];
    cell.textLabel.font = secondFont;
    
    return cell;
}


#pragma mark -
#pragma mark UITextFieldDelegate
- (void)textFieldDidBeginEditing:(UITextField *)textField {
    textField.text = [NSString stringWithFormat:@"%d",_fontSize];
}
- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    [textField resignFirstResponder];
    return YES;
}
- (void)textFieldDidEndEditing:(UITextField *)textField {
    _fontSize = [textField.text intValue];
    [self.tableView reloadData];
    textField.text = [NSString stringWithFormat:@"%d号字",_fontSize];
}
@end
