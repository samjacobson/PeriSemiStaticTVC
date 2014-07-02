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
@property (strong, nonatomic) PeriSectionArrayDataSource * ds1;
@property (strong, nonatomic) PeriSectionArrayDataSource * ds2;

@end

@implementation PeriMultiDynamicViewController

#pragma mark - Launch

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
	NSArray * items = @[@"One", @"Two", @"January", @"etc"];
	_ds1 = [[PeriSectionArrayDataSource alloc] initWithItems:items configureCellBlock:^(UITableViewCell * cell, NSIndexPath * indexPath) {
		NSString * item = [_ds1 objectAtIndexPath:indexPath];
		cell.textLabel.text = item;
	}];
	_ds1.cellNib = @"DynamicCell";
	[self setDynamicSection:_ds1 forSection:0];

	_ds2 = [[PeriSectionArrayDataSource alloc] initWithItems:items configureCellBlock:^(PeriLargeTableViewCell * cell, NSIndexPath * indexPath) {
		NSString * item = [_ds2 objectAtIndexPath:indexPath];
		[cell setContent:item];
	}];
	_ds2.cellNib = @"LargeCell";
	[self setDynamicSection:_ds2 forSection:2];
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
