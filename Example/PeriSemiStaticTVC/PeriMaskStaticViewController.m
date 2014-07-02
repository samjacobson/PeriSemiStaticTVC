//
//  PeriMaskStaticViewController.m
//  SemiStaticExample
//
//  Created by Sam Jacobson on 27/05/14.
//  Copyright (c) 2014 PeriSentient Ltd. All rights reserved.
//

#import "PeriMaskStaticViewController.h"
#import "UITableViewCell+PeriTag.h"

@interface PeriMaskStaticViewController ()

@end

@implementation PeriMaskStaticViewController

#pragma mark - Launch

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - <UITableViewDelegate>

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
	NSString * tag = [self tagForTablePath:indexPath];
	NSLog(@"didSelectRow: %@", tag);
	if([tag isEqualToString:@"unmask"]) {
		[tableView deselectRowAtIndexPath:indexPath animated:YES];
		for(int i = 0; i < 4; i++)
			[self mask:NO staticPath:[NSIndexPath indexPathForRow:i inSection:0] withRowAnimation:UITableViewRowAnimationAutomatic];
	}
	else {
		[tableView deselectRowAtIndexPath:indexPath animated:NO];
		NSIndexPath * staticPath = [self staticPathForTablePath:indexPath];
		[self mask:YES staticPath:staticPath withRowAnimation:UITableViewRowAnimationAutomatic];
	}
}

- (IBAction)didTouchRefresh:(id)sender {
	[self.tableView reloadData];
}

@end
