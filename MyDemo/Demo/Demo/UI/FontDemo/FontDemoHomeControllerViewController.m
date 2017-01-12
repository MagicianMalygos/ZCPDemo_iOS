//
//  FontDemoHomeControllerViewController.m
//  Demo
//
//  Created by apple on 16/3/10.
//  Copyright © 2016年 zcp. All rights reserved.
//

#import "FontDemoHomeControllerViewController.h"

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

#pragma mark - tableview datasource delegate
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.fontArr.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *identifier = @"fontcell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:identifier];
    }
    cell.textLabel.text = [NSString stringWithFormat:@"%@%@", [[self.fontArr objectAtIndex:indexPath.row] valueForKey:@"FontName"], @" - 我是中文示例"];
    cell.textLabel.font = [UIFont fontWithName:[[self.fontArr objectAtIndex:indexPath.row] valueForKey:@"FontName"] size:18.0f];
    cell.textLabel.numberOfLines = 0;
    
    cell.detailTextLabel.text = [[self.fontArr objectAtIndex:indexPath.row] valueForKey:@"FontFamilyName"];
    cell.detailTextLabel.font = [UIFont fontWithName:[[self.fontArr objectAtIndex:indexPath.row] valueForKey:@"FontFamilyName"] size:15.0f];
    cell.detailTextLabel.numberOfLines = 0;
    return cell;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 80.0f;
}
@end
