//
//  PeriSemiStaticTableViewController.m
//  PeriSemiStaticTVC
//
//  Created by Sam Jacobson on 27/05/14.
//  Copyright (c) 2014 PeriSentient Ltd. All rights reserved.
//

#import "PeriSemiStaticTableViewController.h"
#import "PeriDynamicSection.h"
#import "UITableViewCell+PeriTag.h"

@interface PeriSemiStaticTableViewController ()
@property (strong, nonatomic) NSMutableDictionary * maskedRows;
@property (strong, nonatomic) NSMutableDictionary * dynamicSections;

@end

@implementation PeriSemiStaticTableViewController

#pragma mark - Launch

- (void)viewDidLoad {
	[super viewDidLoad];

	_maskedRows = [NSMutableDictionary dictionary];
	_dynamicSections = [NSMutableDictionary dictionary];
}

- (void)didReceiveMemoryWarning {
	[super didReceiveMemoryWarning];
}

- (PeriDynamicSection *)dynamicSection:(NSInteger)section {
	return _dynamicSections[@(section)];
}

- (NSMutableDictionary *)maskForSection:(NSInteger)section {
	return _maskedRows[@(section)];
}

#pragma mark - Tags

- (NSIndexPath *)staticPathForTag:(NSString *)tag {
	NSInteger nSections = [self numberOfSectionsInTableView:self.tableView];
	for(NSInteger section = 0; section < nSections; section++) {
		if([self dynamicSection:section])
			continue;	// can't check tags in a dynamic section
		NSInteger nRows = [self tableView:self.tableView numberOfRowsInSection:section];
		for(NSInteger row = 0; row < nRows; row++) {
			NSIndexPath * indexPath = [NSIndexPath indexPathForRow:row inSection:section];
			UITableViewCell * cell = [super tableView:self.tableView cellForRowAtIndexPath:indexPath];
			if([cell.peritag isEqualToString:tag])
				return indexPath;
		}
	}
	return nil;
}

- (NSString *)tagForTablePath:(NSIndexPath *)tablePath {
	return [[self.tableView cellForRowAtIndexPath:tablePath] peritag];
}

#pragma mark - Dynamic Sections

- (void)setDynamicSection:(PeriDynamicSection *)dyn forSection:(NSInteger)tableSection {

	if(dyn == nil)
		[_dynamicSections removeObjectForKey:@(tableSection)];
	else {
		dyn.tableView = self.tableView;
		dyn.section = tableSection;
		if(dyn.cellHeight == 0) {
			UINib * nib = [UINib nibWithNibName:dyn.cellNib bundle:[NSBundle mainBundle]];
			NSArray * objects = [nib instantiateWithOwner:nil options:nil];
			UITableViewCell * cell = objects[0];
			dyn.cellHeight = cell.frame.size.height;
		}
		_dynamicSections[@(tableSection)] = dyn;
		[self.tableView registerNib:[UINib nibWithNibName:dyn.cellNib bundle:[NSBundle mainBundle]] forCellReuseIdentifier:dyn.cellNib];
	}
}

#pragma mark - Index Path translation

- (NSIndexPath *)tablePathForStaticPath:(NSIndexPath *)staticPath {
	PeriDynamicSection * ds = [self dynamicSection:staticPath.section];
	if(ds)
		return nil;		// path is not static (falls in dynamic section)

	NSMutableDictionary * mask = [self maskForSection:staticPath.section];
	if([mask[@(staticPath.row)] boolValue])
		return nil;		// static path is masked

	NSInteger tablerow = -1;
	for(NSInteger sr = 0; sr <= staticPath.row; sr++) {
		if([mask[@(sr)] boolValue] == NO)
			tablerow++;
	}
	if(tablerow < 0)
		return nil;
	return [NSIndexPath indexPathForRow:tablerow inSection:staticPath.section];
}

- (NSIndexPath *)staticPathForTablePath:(NSIndexPath *)tablePath {
	PeriDynamicSection * ds = [self dynamicSection:tablePath.section];
	if(ds)
		return nil;		// path is not static (falls in dynamic section)

	NSMutableDictionary * mask = [self maskForSection:tablePath.section];

	NSInteger nStaticRows = [super tableView:self.tableView numberOfRowsInSection:tablePath.section];
	NSInteger tablerow = -1;
	for(NSInteger sr = 0; sr < nStaticRows; sr++) {
		if([mask[@(sr)] boolValue] == NO)
			tablerow++;
		if(tablerow == tablePath.row)
			return [NSIndexPath indexPathForRow:sr inSection:tablePath.section];
	}
	return nil;		// couldn't find static path; invalid table path?
}



#pragma mark - Masking API

- (void)mask:(BOOL)mask staticPath:(NSIndexPath *)staticPath withRowAnimation:(UITableViewRowAnimation)animation {
	NSMutableDictionary * section = _maskedRows[@(staticPath.section)];
	if(section == nil) {
		if(! mask)
			return;
		section = [NSMutableDictionary dictionary];
		_maskedRows[@(staticPath.section)] = section;
	}
	if([section[@(staticPath.row)] boolValue] == mask)
		return;
	if(mask) {
		NSIndexPath * tablePath = [self tablePathForStaticPath:staticPath];
		section[@(staticPath.row)] = @YES;
		[self.tableView deleteRowsAtIndexPaths:@[tablePath] withRowAnimation:animation];
	}
	else {
		[section removeObjectForKey:@(staticPath.row)];
		NSIndexPath * tablePath = [self tablePathForStaticPath:staticPath];
		[self.tableView insertRowsAtIndexPaths:@[tablePath] withRowAnimation:animation];
	}
}

- (void)toggleMaskStaticPath:(NSIndexPath *)staticPath withRowAnimation:(UITableViewRowAnimation)animation {
	BOOL mask = ![self isStaticPathMasked:staticPath];
	[self mask:mask staticPath:staticPath withRowAnimation:animation];
}

- (BOOL)isStaticPathMasked:(NSIndexPath *)staticPath {
	NSMutableDictionary * section = _maskedRows[@(staticPath.section)];
	return [section[@(staticPath.row)] boolValue];
}


#pragma mark - <UITableViewDataSource>

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)nSection {
	PeriDynamicSection * ds = [self dynamicSection:nSection];
	if(ds)
		return [ds tableViewNumberOfRowsInSection:tableView];

	NSInteger nRows = [super tableView:tableView numberOfRowsInSection:nSection];
	NSMutableDictionary * section = _maskedRows[@(nSection)];
	return nRows - [section count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)tablePath {
	PeriDynamicSection * ds = [self dynamicSection:tablePath.section];
	if(ds)
		return [ds tableView:tableView cellForRowAtIndexPath:tablePath];

	NSIndexPath * staticPath = [self staticPathForTablePath:tablePath];
	return [super tableView:tableView cellForRowAtIndexPath:staticPath];
}

#pragma mark - <UITableViewDelegate>

- (NSInteger)tableView:(UITableView *)tableView indentationLevelForRowAtIndexPath:(NSIndexPath *)tablePath {
	PeriDynamicSection * ds = [self dynamicSection:tablePath.section];
	if(ds)
		return 0;

	NSIndexPath * staticPath = [self staticPathForTablePath:tablePath];
	return [super tableView:tableView indentationLevelForRowAtIndexPath:staticPath];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)tablePath {
	PeriDynamicSection * ds = [self dynamicSection:tablePath.section];
	if(ds)
		return ds.cellHeight;

	NSIndexPath * staticPath = [self staticPathForTablePath:tablePath];
	return [super tableView:tableView heightForRowAtIndexPath:staticPath];
}

@end
