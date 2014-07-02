//
//  PeriDynamicSection.m
//  PeriSemiStaticTVC
//
//  Created by Sam Jacobson on 28/05/14.
//  Copyright (c) 2014 PeriSentient Ltd. All rights reserved.
//

#import "PeriDynamicSection.h"

@implementation PeriDynamicSection

- (NSInteger)tableViewNumberOfRowsInSection:(UITableView *)tableView {
	[NSException raise:@"Abstract Base Class" format:@""];
	return 0;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
	[NSException raise:@"Abstract Base Class" format:@""];
	return nil;
}

@end
