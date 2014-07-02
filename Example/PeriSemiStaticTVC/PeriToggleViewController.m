//
//  PeriToggleViewController.m
//  SemiStaticExample
//
//  Created by Sam Jacobson on 28/05/14.
//  Copyright (c) 2014 PeriSentient Ltd. All rights reserved.
//

#import "PeriToggleViewController.h"
#import "UITableViewCell+PeriTag.h"

@interface PeriToggleViewController ()
@property (strong, nonatomic) NSIndexPath * pickerPath;
@property (strong, nonatomic) NSIndexPath * maskPath;

@end

@implementation PeriToggleViewController

#pragma mark - Launch

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
	_pickerPath = [self staticPathForTag:@"picker"];
	_maskPath = [self staticPathForTag:@"mask"];
	[self mask:YES staticPath:_pickerPath withRowAnimation:UITableViewRowAnimationNone];
	[self mask:YES staticPath:_maskPath withRowAnimation:UITableViewRowAnimationNone];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - <UITableViewDelegate>

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
	[tableView deselectRowAtIndexPath:indexPath animated:YES];

	NSString * tag = [self tagForTablePath:indexPath];
	if([tag isEqualToString:@"toggle"])
		[self toggleMaskStaticPath:_pickerPath withRowAnimation:UITableViewRowAnimationMiddle];
	else if([tag isEqualToString:@"show"])
		[self mask:NO staticPath:_maskPath withRowAnimation:UITableViewRowAnimationAutomatic];
	else if([tag isEqualToString:@"hide"])
		[self mask:YES staticPath:_maskPath withRowAnimation:UITableViewRowAnimationAutomatic];
}

@end
