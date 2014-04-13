//
//  HSAppDelegate.h
//  HazelnutScript
//
//  Created by Ke Yang on 4/12/14.
//  Copyright (c) 2014 Pyrus. All rights reserved.
//

#import <Cocoa/Cocoa.h>
#import <ACEView/ACEView.h>
//#import <KFToolbar/KFToolbar.h>
#import "KFToolbar/KFToolbar.h"
#import <RHPreferences/RHPreferences.h>

#import "HSPrefAboutViewController.h"
#import "HSPrefEditorViewController.h"
#import "HSPrefGeneralViewController.h"
#import "HSPrefProtocol.h"

#import "HSJavaScriptManager.h"
#import "NSTextField+JSConsole.h"

@interface HSAppDelegate : NSObject <NSApplicationDelegate, NSPopoverDelegate, ACEViewDelegate, HSPrefProtocol>

@property (assign) IBOutlet NSWindow *window;
@property (unsafe_unretained) IBOutlet NSPanel *consolePanel;
@property (weak) IBOutlet NSTextField *consoleText;

@property (weak) IBOutlet KFToolbar *bottomToolbar;
@property (weak) IBOutlet ACEView *aceEditorView;
@property (weak) IBOutlet NSPopover *prefPop;

@property (strong) RHPreferencesWindowController * prefWndController;

@end
