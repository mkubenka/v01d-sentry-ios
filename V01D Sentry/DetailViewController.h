//
//  DetailViewController.h
//  V01D Sentry
//
//  Created by Michal Kubenka on 21/04/14.
//  Copyright (c) 2014 V01D. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DetailViewController : UIViewController

@property (strong, nonatomic) id detailItem;

@property (weak, nonatomic) IBOutlet UILabel *detailDescriptionLabel;
@end
