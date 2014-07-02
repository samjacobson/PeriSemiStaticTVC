//
//  PeriSemiStaticTableViewController.h
//  PeriSemiStaticTVC
//
//  Created by Sam Jacobson on 27/05/14.
//  Copyright (c) 2014 PeriSentient Ltd. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PeriDynamicSection.h"

@class PeriDynamicSection;

@interface PeriSemiStaticTableViewController : UITableViewController

/**
 Translate a path in the live/current table to the equivalent path in
 the static/storyboard table.
 Example usage:
 @code
 NSIndexPath * tablePath = [self tablePathForStaticPath:staticPath]
 @endcode
 @param staticPath
 The path into the table as defined in the storyboard. This path does
 not change as cells are masked and unmasked.
 @return
 The path into the current table. This path will differ depending on
 whether cells are masked or not.
 */
- (NSIndexPath *)tablePathForStaticPath:(NSIndexPath *)staticPath;

/**
 Translate a path in the live/current table to the equivalent path in
 the static/storyboard table.
 Example usage:
 @code
 NSIndexPath * staticPath = [self staticPathForTablePath:indexPath]
 @endcode
 @param tablePath
 The path into the live table.
 @return
 The path into the static/storyboard table. This path does not change
 regardless of whether cells are masked or not.
 */
- (NSIndexPath *)staticPathForTablePath:(NSIndexPath *)tablePath;


/**
 Make a section of the tableview dynamic. The supplied DynamicSection
 becomes the data source for the section (and references the Nib to load
 for cells etc).
 Example usage:
 @code
 [self setDynamicSection:section forSection:0];
 [self.tableView reloadData];
 @endcode
 @param dyn
 The dynamic section. A subclass of PeriDynamicSection, e.g. PeriSectionArrayDataSource
 or PeriSectionCoreDataSource.
 If dyn is nil then revert the supplied section to a static section.
 @param section
 The section to make dynamic (and set this data source for).
 */
- (void)setDynamicSection:(PeriDynamicSection *)dyn forSection:(NSInteger)section;


/**
 Show or hide a UITableViewCell in this static UITableView.
 Example usage:
 @code
 [self mask:YES staticPath:[NSIndexPath indexPathForRow:0 inSection:0] withRowAnimation:UITableViewRowAnimationFade];
 @endcode
 @param mask
 YES to hide staticPath; NO to reveal
 @param staticPath
 The NSIndexPath that represents the row in the original UITableView
 @param animation
 The Row animation to use; try UITableViewRowAnimationFade
 */
- (void)mask:(BOOL)mask staticPath:(NSIndexPath *)staticPath withRowAnimation:(UITableViewRowAnimation)animation;

/**
 Toggle the mask state of a UITableViewCell. This is equivalent to calling mask:staticPath:withRowAnimation: with the
 logical NOT of the current mask state.
 Example usage:
 @code
 [self toggleMaskStaticPath:[NSIndexPath indexPathForRow:0 inSection:0] withRowAnimation:UITableViewRowAnimationFade];
 @endcode
 @param staticPath
 The NSIndexPath that represents the row in the original UITableView
 @param animation
 The Row animation to use; try UITableViewRowAnimationFade
 */
- (void)toggleMaskStaticPath:(NSIndexPath *)staticPath withRowAnimation:(UITableViewRowAnimation)animation;

/**
 Return whether the given staticPath is currently masked (hidden).
 Example usage:
 @code
 NSLog(@"%d", [self isStaticPathMasked:[NSIndexPath indexPathForRow:0 inSection:0]]);
 @endcode
 @param staticPath
 The NSIndexPath that represents the row in the original UITableView
 @return
 YES if cell is masked; NO otherwise
 */
- (BOOL)isStaticPathMasked:(NSIndexPath *)staticPath;


/**
 Find the first cell with the requested tag. Returns a static path (see staticPathForTablePath).
 The 'tag' is a user defined string set on the cell in the storyboard with the name "peritag"
 @param tag
 The tag to search for
 @return
 The staticPath of the first cell matching, or nil if no cells match
 */
- (NSIndexPath *)staticPathForTag:(NSString *)tag;

/**
 Extract the tag for the supplied tablePath (see tablePathForStaticPath).
 @param tablePath
 The NSIndexPath that represents the row in the live UITableView
 @return
 nil, or the user defined string on the cell with the name "peritag"
 */
- (NSString *)tagForTablePath:(NSIndexPath *)tablePath;

@end
