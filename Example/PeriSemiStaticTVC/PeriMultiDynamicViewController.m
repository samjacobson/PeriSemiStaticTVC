//
//  PeriMultiDynamicViewController.m
//  SemiStaticExample
//
//  Created by Sam Jacobson on 28/05/14.
//  Copyright (c) 2014 PeriSentient Ltd. All rights reserved.
//

#import "PeriMultiDynamicViewController.h"
#import <PeriSectionArrayDataSource.h>
#import "PeriLargeTableViewCell.h"

@interface PeriMultiDynamicViewController ()
@property (strong, nonatomic) PeriArrayDataSource * ds1;
@property (strong, nonatomic) PeriArrayDataSource * ds2;

@end

@implementation PeriMultiDynamicViewController

#pragma mark - Launch

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
	NSString * nib1 = @"DynamicCell";
	NSArray * items = @[@"One", @"Two", @"January", @"etc"];
	_ds1 = [[PeriArrayDataSource alloc] initWithItems:items cellIdentifier:nib1 configureCellBlock:^(UITableViewCell * cell, NSIndexPath * indexPath) {
		NSString * item = [_ds1 objectAtIndexPath:[self dataPathForTablePath:indexPath]];
		cell.textLabel.text = item;
	}];
	[self setDataSource:_ds1 dataSection:0 cellNib:nib1 forTableSection:0];

	NSString * nib2 = @"LargeCell";
	_ds2 = [[PeriArrayDataSource alloc] initWithItems:items cellIdentifier:nib2 configureCellBlock:^(PeriLargeTableViewCell * cell, NSIndexPath * indexPath) {
		NSString * item = [_ds2 objectAtIndexPath:[self dataPathForTablePath:indexPath]];
		[cell setContent:item];
	}];
	[self setDataSource:_ds2 dataSection:0 cellNib:nib2 forTableSection:2];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - <UITableViewDelegate>

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
	[tableView deselectRowAtIndexPath:indexPath animated:YES];

	if(indexPath.section == 1 && indexPath.row == 0) {
		NSIndexPath * staticPath = [NSIndexPath indexPathForRow:1 inSection:1];
		if([self staticRowIsMasked:staticPath])
			[self unmaskStaticRowAtPath:staticPath withRowAnimation:UITableViewRowAnimationAutomatic];
		else
			[self maskStaticRowAtPath:staticPath withRowAnimation:UITableViewRowAnimationAutomatic];
	}
}

@end
