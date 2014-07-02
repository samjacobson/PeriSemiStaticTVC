//
//  PeriSectionArrayDataSource.m
//  PeriSemiStaticTVC
//
//  Created by Sam Jacobson on 3/07/14.
//
//

#import "PeriSectionArrayDataSource.h"

@interface PeriSectionArrayDataSource ()

@property (strong, nonatomic) NSArray * items;
@property (strong, nonatomic) NSString * cellIdentifier;;
@property (copy, nonatomic) PeriConfigureCell configureCell;

@end


@implementation PeriSectionArrayDataSource

#pragma mark - Init

- (id)init {
	[NSException raise:@"init: not supported" format:@"%@ requires initWithItems", self.class];
	return nil;
}

- (id)initWithItems:(NSArray *)items configureCellBlock:(PeriConfigureCell)configureCell {
	self = [super init];
	if(self) {
		self.configureCell = configureCell;
		self.items = items;
	}
	return self;
}

#pragma mark - Data Source

- (id)objectAtIndexPath:(NSIndexPath *)indexPath {
	return _items[indexPath.row];
}

- (NSInteger)tableViewNumberOfRowsInSection:(UITableView *)tableView {
	return [_items count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
	UITableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:self.cellNib forIndexPath:indexPath];
	self.configureCell(cell, indexPath);
	return cell;
}

@end
