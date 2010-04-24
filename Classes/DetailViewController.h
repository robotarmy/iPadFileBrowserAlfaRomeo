//
//  DetailViewController.h
//  2ndApp
//
//  Created by cjs on 4/4/10.
//  Copyright __MyCompanyName__ 2010. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DetailViewController : UIViewController <UIPopoverControllerDelegate, UISplitViewControllerDelegate> {
    
    UIPopoverController *popoverController;
    UIToolbar *toolbar;
    
    UITextView *detailItem;
    UILabel *detailDescriptionLabel;
	
	
}

@property (nonatomic, retain) IBOutlet UIToolbar *toolbar;
@property (nonatomic, retain) IBOutlet UITextView *detailItem;
@property (nonatomic, retain) IBOutlet UILabel *detailDescriptionLabel;

@end
