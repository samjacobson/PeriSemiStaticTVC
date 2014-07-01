//
//  PeriSemiStaticTableViewController.h
//  SemiStaticExample
//
//  Created by Sam Jacobson on 27/05/14.
//  Copyright (c) 2014 PeriSentient Ltd. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PeriDynamicSection.h"

@interface PeriSemiStaticTableViewController : UITableViewController

// IndexPath translation
- (NSIndexPath *)tablePathForStaticPath:(NSIndexPath *)staticPath;
- (NSIndexPath *)staticPathForTablePath:(NSIndexPath *)tablePath;
- (NSIndexPath *)dataPathForTablePath:(NSIndexPath *)tablePath;

// Dynamic sections
- (void)setDataSource:(id<UITableViewDataSource>)dataSource dataSection:(NSInteger)dataSection cellNib:(NSString *)cellNib forTableSection:(NSInteger)tableSection;
- (void)setDataSource:(id<UITableViewDataSource>)dataSource dataSection:(NSInteger)dataSection cellNib:(NSString *)cellNib forTableSection:(NSInteger)tableSection withCellHeight:(CGFloat)cellHeight;

// Mask static rows
- (void)maskStaticRowAtPath:(NSIndexPath *)staticPath withRowAnimation:(UITableViewRowAnimation)animation;
- (void)unmaskStaticRowAtPath:(NSIndexPath *)staticPath withRowAnimation:(UITableViewRowAnimation)animation;
- (BOOL)staticRowIsMasked:(NSIndexPath *)staticPath;

- (NSIndexPath *)staticPathForTag:(NSString *)tag;

@end
