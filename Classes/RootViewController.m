//
//  RootViewController.m
//  2ndApp
//
//  Created by cjs on 4/4/10.
//  Copyright RobotArmyMa.De 2010. All rights reserved.
//

#import "RootViewController.h"
#import "DetailViewController.h"


@implementation RootViewController

@synthesize detailViewController;


#pragma mark -
#pragma mark View lifecycle
- (void)viewDidLoad {
    [super viewDidLoad];
	self.clearsSelectionOnViewWillAppear = NO;
    self.contentSizeForViewInPopover = CGSizeMake(320.0, 600.0);
	fileManager =[[NSFileManager alloc] init];
	[fileManager changeCurrentDirectoryPath:NSHomeDirectory()];
}

- (IBOutlet)goBack {
	[fileManager changeCurrentDirectoryPath:[[fileManager currentDirectoryPath] stringByAppendingPathComponent:@".."]];
	[[self tableView] reloadData];
}
/*
- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
}
*/
/*
- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
}
*/
/*
- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
}
*/
/*
- (void)viewDidDisappear:(BOOL)animated {
    [super viewDidDisappear:animated];
}
*/

// Ensure that the view controller supports rotation and that the split view can therefore show in both portrait and landscape.
- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
    return YES;
}


#pragma mark -
#pragma mark Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)aTableView {
    // Return the number of sections.
    return 1;
}


- (NSInteger)tableView:(UITableView *)aTableView numberOfRowsInSection:(NSInteger)section {
	return [[fileManager contentsOfDirectoryAtPath:[fileManager currentDirectoryPath] error:NULL] count];
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
	
    static NSString *CellIdentifier = @"CellIdentifier";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier] autorelease];
    }
    
	// Configure the cell.
	
	NSArray *directory_contents = [fileManager contentsOfDirectoryAtPath:[fileManager currentDirectoryPath]error:NULL];
	NSString * path = [directory_contents objectAtIndex:indexPath.row];
	[path retain];
	cell.text = path;
    return cell;
}


/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/


/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:[NSArray arrayWithObject:indexPath] withRowAnimation:YES];
    }   
    else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/


/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath {
}
*/


/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/


#pragma mark -
#pragma mark Table view delegate

- (void)tableView:(UITableView *)aTableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    /*
     When a row is selected, set the detail view controller's detail item to the item associated with the selected row.
     */
    //detailViewController.detailItem = [NSString stringWithFormat:@"didSelectRowAtIndexPath %d", indexPath.row];
	
	//detailViewController.detailDescriptionLabel = [NSString stringWithFormat:@"%d",indexPath.row];
	
	int at = indexPath.row;
	
	NSArray *directory_contents = [fileManager contentsOfDirectoryAtPath:[fileManager currentDirectoryPath] error:NULL];
	NSString *dot_slash_file = [directory_contents objectAtIndex:at];

	[self updatePath:dot_slash_file];
	[self updateDetailView:dot_slash_file ];
	[[self tableView] reloadData];
	}


#pragma mark -
#pragma mark Memory management

- (void)didReceiveMemoryWarning {
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Relinquish ownership any cached data, images, etc. that aren't in use.
}

- (void)viewDidUnload {
    // Relinquish ownership of anything that can be recreated in viewDidLoad or on demand.
    // For example: self.myOutlet = nil;
}


- (void)dealloc {
    [detailViewController release];
	[fileManager release];
	[super dealloc];
}

- (void)updatePath:(NSString *)aPath {
	BOOL isDir;
	NSString * new_path = [[fileManager currentDirectoryPath] stringByAppendingPathComponent:aPath];
	[fileManager fileExistsAtPath:new_path isDirectory:&isDir];
	if (isDir) {
		[fileManager changeCurrentDirectoryPath:new_path];
	}
}

- (void)updateDetailView:(NSString *)aPath; {
	BOOL isDir;
	NSString * new_path = [[fileManager currentDirectoryPath] stringByAppendingPathComponent:aPath];
	[fileManager fileExistsAtPath:new_path isDirectory:&isDir];
	if (!isDir) {
		detailViewController.detailItem.text = [NSString stringWithContentsOfFile:new_path];
		detailViewController.detailItem = detailViewController.detailItem;
		detailViewController.detailDescriptionLabel.text = new_path;
	}
}

@end

