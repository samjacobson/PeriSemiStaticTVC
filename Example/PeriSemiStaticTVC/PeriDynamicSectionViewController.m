//
//  PeriDynamicSectionViewController.m
//  SemiStaticExample
//
//  Created by Sam Jacobson on 28/05/14.
//  Copyright (c) 2014 PeriSentient Ltd. All rights reserved.
//

#import "PeriDynamicSectionViewController.h"
#import "PeriArrayDataSource.h"

@interface PeriDynamicSectionViewController ()
@property (strong, nonatomic) PeriArrayDataSource * ds;

@end

@implementation PeriDynamicSectionViewController

#pragma mark - Launch

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
	NSString * nib = @"DynamicCell";
	NSArray * items = @[@"One", @"Two", @"January", @"etc"];
	_ds = [[PeriArrayDataSource alloc] initWithItems:items cellIdentifier:nib configureCellBlock:^(UITableViewCell * cell, NSIndexPath * indexPath) {
		NSString * item = [_ds objectAtIndexPath:[self dataPathForTablePath:indexPath]];
		cell.textLabel.text = item;
	}];
	[self setDataSource:_ds dataSection:0 cellNib:nib forTableSection:1];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - <UITableViewDelegate>

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
	[tableView deselectRowAtIndexPath:indexPath animated:YES];
}

@end
