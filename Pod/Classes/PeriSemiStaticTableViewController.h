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

// IndexPath translation
- (NSIndexPath *)tablePathForStaticPath:(NSIndexPath *)staticPath;
- (NSIndexPath *)staticPathForTablePath:(NSIndexPath *)tablePath;
//- (NSIndexPath *)dataPathForTablePath:(NSIndexPath *)tablePath;

// Dynamic sections
- (void)setDynamicSection:(PeriDynamicSection *)dyn forSection:(NSInteger)section;

// Mask static rows
- (void)maskStaticRowAtPath:(NSIndexPath *)staticPath withRowAnimation:(UITableViewRowAnimation)animation;
- (void)unmaskStaticRowAtPath:(NSIndexPath *)staticPath withRowAnimation:(UITableViewRowAnimation)animation;
- (BOOL)staticRowIsMasked:(NSIndexPath *)staticPath;

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


- (NSIndexPath *)staticPathForTag:(NSString *)tag;
- (NSString *)tagForTablePath:(NSIndexPath *)tablePath;

@end
