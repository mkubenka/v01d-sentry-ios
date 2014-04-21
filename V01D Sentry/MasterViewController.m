//
//  MasterViewController.m
//  V01D Sentry
//
//  Created by Michal Kubenka on 21/04/14.
//  Copyright (c) 2014 V01D. All rights reserved.
//

#import "MasterViewController.h"

#import "DetailViewController.h"

#import <RestKit/RestKit.h>
#import "Event.h"

@interface MasterViewController ()

@property (nonatomic, strong) NSArray *events;

@end

@implementation MasterViewController

- (void)awakeFromNib
{
    [super awakeFromNib];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self configureRestKit];
    [self loadEvents];

    UIBarButtonItem *aboutButton = [[UIBarButtonItem alloc] initWithTitle:@"About" style:UIBarButtonItemStyleBordered target:self action:@selector(about:)];
    self.navigationItem.rightBarButtonItem = aboutButton;
}

- (void)configureRestKit
{
    NSURL *baseURL = [NSURL URLWithString:apiURL];
    AFHTTPClient *client = [[AFHTTPClient alloc] initWithBaseURL:baseURL];
    
    RKObjectManager *objectManager = [[RKObjectManager alloc] initWithHTTPClient:client];
    
    RKObjectMapping *eventMapping = [RKObjectMapping mappingForClass:[Event class]];
    [eventMapping addAttributeMappingsFromArray:@[
                                                  @"title",
                                                  @"lecturer",
                                                  @"abstract",
                                                  @"start"]];
    
    RKResponseDescriptor *eventResponseDescriptor =
    [RKResponseDescriptor responseDescriptorWithMapping:eventMapping
                                                 method:RKRequestMethodGET
                                            pathPattern:@"/api/v1/events"
                                                keyPath:@"events"
                                            statusCodes:[NSIndexSet indexSetWithIndex:200]];
    
    [objectManager addResponseDescriptor:eventResponseDescriptor];
}

- (void)loadEvents
{
    [[RKObjectManager sharedManager] getObjectsAtPath:@"/api/v1/events"
                                           parameters:NULL
                                              success:^(RKObjectRequestOperation *operation, RKMappingResult *mappingResult) {
                                                  _events = mappingResult.array;
                                                  [self.tableView reloadData];
                                              }
                                              failure:^(RKObjectRequestOperation *operation, NSError *error) {
                                                  NSString *errorMessage = [NSString stringWithFormat:@"RKObjectRequestOperation failure %@", error];
                                                  
                                                  [[RavenClient sharedClient] captureMessage:errorMessage level:kRavenLogLevelDebugError method:__FUNCTION__ file:__FILE__ line:__LINE__];
                                                  
                                              }];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table View

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return _events.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Cell" forIndexPath:indexPath];

    Event *event = _events[indexPath.row];
    cell.textLabel.text = event.title;
    
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setTimeStyle:NSDateFormatterShortStyle];
    [dateFormatter setDateStyle:NSDateFormatterMediumStyle];
    
    cell.detailTextLabel.text = [NSString stringWithFormat:@"%@ (%@)", [dateFormatter stringFromDate:event.start], event.lecturer];
    return cell;
}

- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the specified item to be editable.
    return YES;
}

- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSException* myException = [NSException
                                exceptionWithName:@"FooBarException"
                                reason:@"FooBar Not Found on System"
                                userInfo:nil];
    @throw myException;
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([[segue identifier] isEqualToString:@"showDetail"]) {
        NSIndexPath *indexPath = [self.tableView indexPathForSelectedRow];
        NSDate *object = _events[indexPath.row];
        [[segue destinationViewController] setDetailItem:object];
    }
}

@end
