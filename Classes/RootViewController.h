//
//  RootViewController.h
//  2ndApp
//
//  Created by cjs on 4/4/10.
//  Copyright __MyCompanyName__ 2010. All rights reserved.
//

#import <UIKit/UIKit.h>

@class DetailViewController;

@interface RootViewController : UITableViewController {
    DetailViewController *detailViewController;
	NSFileManager *fileManager;
};

- (IBAction) goBack;

- (void)updatePath:(NSString *)aPath;

- (void)updateDetailView:(NSString *)aPath;

@property (nonatomic, retain) IBOutlet DetailViewController *detailViewController;

@end
