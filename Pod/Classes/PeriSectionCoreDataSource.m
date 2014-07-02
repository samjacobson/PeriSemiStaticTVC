//
//  PeriSectionCoreDataSource.m
//  PeriSemiStaticTVC
//
//  Created by Sam Jacobson on 2/07/14.
//  Copyright (c) 2014 PeriSentient Ltd. All rights reserved.
//

#import <CoreData/CoreData.h>
#import "PeriSectionCoreDataSource.h"

@interface PeriSectionCoreDataSource ()<NSFetchedResultsControllerDelegate>
@property (strong, nonatomic) NSFetchedResultsController * frc;
@property (copy, nonatomic) PeriConfigureCell configureCell;
@property (nonatomic) BOOL changeIsUserDriven;

@end

@implementation PeriSectionCoreDataSource

#pragma mark - Init

- (id)init {
	[NSException raise:@"init: not supported" format:@"%@ requires initWithFetchRequest", self.class];
	return nil;
}

- (id)initWithFetchRequest:(NSFetchRequest *)fetch managedObjectContext:(NSManagedObjectContext *)context configureCell:(PeriConfigureCell)configureCell {
	self = [super init];
	if(self) {
		self.configureCell = configureCell;
		_frc = [[NSFetchedResultsController alloc] initWithFetchRequest:fetch managedObjectContext:context sectionNameKeyPath:nil cacheName:nil];
		[_frc performFetch:nil];
		_frc.delegate = self;
	}
	return self;
}

#pragma mark - Data Source

- (id)objectAtIndexPath:(NSIndexPath *)indexPath {
	return [_frc objectAtIndexPath:[self dataPathFromTablePath:indexPath]];
}

- (NSInteger)tableViewNumberOfRowsInSection:(UITableView *)tableView {
	return [[_frc sections][0] numberOfObjects];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
	UITableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:self.cellNib forIndexPath:indexPath];
	self.configureCell(cell, indexPath);
	return cell;
}

#pragma mark - <NSFetchedResultsControllerDelegate>

/*
 Assume self has a property 'tableView' -- as is the case for an instance of a UITableViewController
 subclass -- and a method configureCell:atIndexPath: which updates the contents of a given cell
 with information from a managed object at the given index path in the fetched results controller.
 */

- (void)controllerWillChangeContent:(NSFetchedResultsController *)controller {
	if(_changeIsUserDriven)
		return;
	[self.tableView beginUpdates];
}

- (NSIndexPath *)dataPathFromTablePath:(NSIndexPath *)tablePath {
	if(tablePath == nil)
		return nil;
	return [NSIndexPath indexPathForRow:tablePath.row inSection:0];
}

- (NSIndexPath *)tablePathFromDataPath:(NSIndexPath *)dataPath {
	if(dataPath == nil)
		return nil;
	return [NSIndexPath indexPathForRow:dataPath.row inSection:self.section];
}

- (void)controller:(NSFetchedResultsController *)controller didChangeObject:(id)anObject atIndexPath:(NSIndexPath *)indexPath forChangeType:(NSFetchedResultsChangeType)type newIndexPath:(NSIndexPath *)newIndexPath {

	if(_changeIsUserDriven)
		return;

	UITableView *tableView = self.tableView;
	indexPath = [self tablePathFromDataPath:indexPath];
	newIndexPath = [self tablePathFromDataPath:newIndexPath];

	switch(type) {
		case NSFetchedResultsChangeInsert:
			[tableView insertRowsAtIndexPaths:@[newIndexPath] withRowAnimation:UITableViewRowAnimationFade];
			break;

		case NSFetchedResultsChangeDelete:
			[tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
			break;

		case NSFetchedResultsChangeUpdate:
			self.configureCell([tableView cellForRowAtIndexPath:indexPath], indexPath);
			break;

		case NSFetchedResultsChangeMove:
			[tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
			[tableView insertRowsAtIndexPaths:@[newIndexPath] withRowAnimation:UITableViewRowAnimationFade];
			break;
	}
}

- (void)controllerDidChangeContent:(NSFetchedResultsController *)controller {
	if(_changeIsUserDriven)
		return;
	[self.tableView endUpdates];
}


@end
