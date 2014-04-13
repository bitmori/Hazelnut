//
//  HSPrefEditorViewController.h
//  HazelnutScript
//
//  Created by Ke Yang on 4/12/14.
//  Copyright (c) 2014 Pyrus. All rights reserved.
//

#import <Cocoa/Cocoa.h>
#import <RHPreferences/RHPreferences.h>
#import "HSPrefProtocol.h"

@interface HSPrefEditorViewController : NSViewController <RHPreferencesViewControllerProtocol>

@property (assign, nonatomic) id<HSPrefProtocol> delegate;

@end
