//
//  FontDemoHomeControllerViewController.m
//  Demo
//
//  Created by apple on 16/3/10.
//  Copyright © 2016年 zcp. All rights reserved.
//

#import "FontDemoHomeControllerViewController.h"

NSString *  const TestWords     = @"ABCDEFGHIJKLMNOPQRSTUVWXYZ\nabcdefghijklmnopqrstuvwxyz\n1234567890";
CGFloat     const TestFontSize  = 20.0f;

@interface FontDemoHomeControllerViewController () <UITableViewDataSource, UITableViewDelegate>

@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) NSMutableArray *fontArr;

@end

@implementation FontDemoHomeControllerViewController

#pragma mark - life cycle
- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self.view addSubview:self.tableView];
    
    NSLog(@"%@", self.fontArr);
}

#pragma mark - tableview datasource delegate

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.fontArr.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *identifier = @"fontcell";
    UITableViewCell *cell       = [tableView dequeueReusableCellWithIdentifier:identifier];
    if (cell == nil) {
        cell                    = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:identifier];
    }
    
    // title & font
    NSString *boldTitle = [NSString stringWithFormat:@"%@%@\n%@", [[self.fontArr objectAtIndex:indexPath.row] valueForKey:@"FontName"], @" - 我是中文加粗示例", TestWords];
    UIFont *boldFont = [UIFont fontWithName:[[self.fontArr objectAtIndex:indexPath.row] valueForKey:@"FontName"] size:TestFontSize];
    NSString *normalTitle = [NSString stringWithFormat:@"%@%@\n%@", [[self.fontArr objectAtIndex:indexPath.row] valueForKey:@"FontFamilyName"], @" - 我是中文示例", TestWords];
    UIFont *normalFont = [UIFont fontWithName:[[self.fontArr objectAtIndex:indexPath.row] valueForKey:@"FontFamilyName"] size:TestFontSize];
    
    // bold
    cell.textLabel.text                 = boldTitle;
    cell.textLabel.font                 = boldFont;
    cell.textLabel.numberOfLines        = 0;
    // normal
    cell.detailTextLabel.text           = normalTitle;
    cell.detailTextLabel.font           = normalFont;
    cell.detailTextLabel.numberOfLines  = 0;
    
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    // title & font
    NSString *boldTitle = [NSString stringWithFormat:@"%@%@\n%@", [[self.fontArr objectAtIndex:indexPath.row] valueForKey:@"FontName"], @" - 我是中文加粗示例", TestWords];
    UIFont *boldFont = [UIFont fontWithName:[[self.fontArr objectAtIndex:indexPath.row] valueForKey:@"FontName"] size:TestFontSize];
    NSString *normalTitle = [NSString stringWithFormat:@"%@%@\n%@", [[self.fontArr objectAtIndex:indexPath.row] valueForKey:@"FontFamilyName"], @" - 我是中文示例", TestWords];
    UIFont *normalFont = [UIFont fontWithName:[[self.fontArr objectAtIndex:indexPath.row] valueForKey:@"FontFamilyName"] size:TestFontSize];
    
    // label height
    CGFloat boldTitleHeight = [boldTitle boundingRectWithSize:CGSizeMake(SCREENWIDTH - 40, MAXFLOAT)
                                                      options:NSStringDrawingUsesFontLeading | NSStringDrawingUsesLineFragmentOrigin
                                                   attributes:@{NSFontAttributeName: boldFont}
                                                      context:nil].size.height;
    CGFloat normalTitleHeight = [normalTitle boundingRectWithSize:CGSizeMake(SCREENWIDTH - 40, MAXFLOAT)
                                                          options:NSStringDrawingUsesFontLeading | NSStringDrawingUsesLineFragmentOrigin
                                                       attributes:@{NSFontAttributeName: normalFont}
                                                          context:nil].size.height;
    
    return 12 + boldTitleHeight + normalTitleHeight + 12;
}

#pragma mark - getter / setter

- (UITableView *)tableView {
    if (_tableView == nil) {
        _tableView = ({
            UITableView *tableView = [[UITableView alloc] initWithFrame:({
                CGRect frame = CGRectMake(0, 0, SCREENWIDTH, SCREENHEIGHT - 64);
                frame;
            })];
            tableView.dataSource = self;
            tableView.delegate = self;
            tableView;
        });
    }
    return _tableView;
}

- (NSMutableArray *)fontArr {
    if (_fontArr == nil) {
        _fontArr = [NSMutableArray array];
        for (NSString *fontFamilyName in [UIFont familyNames]) {
            for (NSString *fontName in [UIFont fontNamesForFamilyName:fontFamilyName]) {
                [_fontArr addObject:@{@"FontFamilyName": fontFamilyName, @"FontName": fontName}];
            }
        }
    }
    return _fontArr;
}

@end
