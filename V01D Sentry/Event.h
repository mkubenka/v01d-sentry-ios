//
//  Event.h
//  V01D Sentry
//
//  Created by Michal Kubenka on 21/04/14.
//  Copyright (c) 2014 V01D. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Event : NSObject

@property (nonatomic, strong) NSString *title;
@property (nonatomic, strong) NSString *lecturer;
@property (nonatomic, strong) NSString *abstract;
@property (nonatomic, strong) NSDate *start;

@end
