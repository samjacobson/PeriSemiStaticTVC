//
//  PeriDynamicSectionViewController.m
//  SemiStaticExample
//
//  Created by Sam Jacobson on 28/05/14.
//  Copyright (c) 2014 PeriSentient Ltd. All rights reserved.
//

#import "PeriDynamicSectionViewController.h"
#import <PeriSemiStaticTVC/PeriSectionArrayDataSource.h>

@interface PeriDynamicSectionViewController ()
@property (strong, nonatomic) PeriSectionArrayDataSource * ds;

@end

@implementation PeriDynamicSectionViewController

#pragma mark - Launch

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
	NSArray * items = @[@"One", @"Two", @"January", @"etc"];
	_ds = [[PeriSectionArrayDataSource alloc] initWithItems:items configureCellBlock:^(UITableViewCell * cell, NSIndexPath *indexPath) {

		NSString * item = [_ds objectAtIndexPath:indexPath];
		cell.textLabel.text = item;
	}];
	_ds.cellNib = @"DynamicCell";
	[self setDynamicSection:_ds forSection:1];
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
