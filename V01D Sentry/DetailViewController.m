//
//  DetailViewController.m
//  V01D Sentry
//
//  Created by Michal Kubenka on 21/04/14.
//  Copyright (c) 2014 V01D. All rights reserved.
//

#import "DetailViewController.h"

#import "Event.h"

@interface DetailViewController ()
- (void)configureView;
@end

@implementation DetailViewController

#pragma mark - Managing the detail item

- (void)setDetailItem:(id)newDetailItem
{
    if (_detailItem != newDetailItem) {
        _detailItem = newDetailItem;
        
        // Update the view.
        [self configureView];
    }
}

- (void)configureView
{
    // Update the user interface for the detail item.

    if (self.detailItem) {
        Event *event = self.detailItem;
        
        self.title = event.title;
        
        self.detailDescriptionLabel.text = event.abstract;
        
        self.detailDescriptionLabel.lineBreakMode = NSLineBreakByWordWrapping;
        self.detailDescriptionLabel.numberOfLines = 0;
        [self.detailDescriptionLabel sizeToFit];
    }
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    [self configureView];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
