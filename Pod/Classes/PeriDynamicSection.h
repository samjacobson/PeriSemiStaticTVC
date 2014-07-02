//
//  PeriDynamicSection.h
//  PeriSemiStaticTVC
//
//  Created by Sam Jacobson on 28/05/14.
//  Copyright (c) 2014 PeriSentient Ltd. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

typedef void (^PeriConfigureCell)(id cell, NSIndexPath * indexPath);

@interface PeriDynamicSection : NSObject

@property (strong, nonatomic) NSString * cellNib;
@property (weak, nonatomic) UITableView * tableView;
@property (nonatomic) CGFloat cellHeight;
@property (nonatomic) NSInteger section;

- (NSInteger)tableViewNumberOfRowsInSection:(UITableView *)tableView;
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath;

@end
