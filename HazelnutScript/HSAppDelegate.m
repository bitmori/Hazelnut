//
//  HSAppDelegate.m
//  HazelnutScript
//
//  Created by Ke Yang on 4/12/14.
//  Copyright (c) 2014 Pyrus. All rights reserved.
//

#import "HSAppDelegate.h"
#import <ACEThemeNames.h>

@interface HSAppDelegate()
{
    NSSearchField* m_searchField;
}
- (IBAction)onMainMenuPreferences:(id)sender;

@end

@implementation HSAppDelegate

- (void)applicationDidFinishLaunching:(NSNotification *)aNotification
{
    [self.window setTitleBarHeight:60.0];
    [self.window setShowsTitle:YES];
    [self.window setVerticallyCenterTitle:YES];
//    [self setTitleBarView];
    
    NSUserDefaults* ud = [NSUserDefaults standardUserDefaults];
    if ([ud objectForKey:@"theme"]!=nil) {
        [self.aceEditorView setTheme:[ud integerForKey:@"theme"]];
    } else {
        [self.aceEditorView setTheme:ACEThemeXcode];
    }
    [self.aceEditorView setDelegate:self];
    [self.aceEditorView setMode:ACEModeJavaScript];
    [self.aceEditorView setShowInvisibles:NO];

    [self.prefPop setDelegate:self];
    [self prepareToolbar];
    HSJavaScriptManager* js = [HSJavaScriptManager JSMan];
    [js addNativeObject:self.consoleText WithName:@"console"];
}

// FIXME: need to recreate popover everytime to preserve the callout triangle.
#pragma mark - NSPopoverDelegate
- (NSWindow *)detachableWindowForPopover:(NSPopover *)popover
{
    if (!self.prefWndController) {
        HSPrefAboutViewController * about = [[HSPrefAboutViewController alloc] initWithNibName:@"HSPrefAboutViewController" bundle:nil];
        HSPrefEditorViewController * editor = [[HSPrefEditorViewController alloc] initWithNibName:@"HSPrefEditorViewController" bundle:nil];
        [editor setDelegate:self];
        HSPrefGeneralViewController * general = [[HSPrefGeneralViewController alloc] initWithNibName:@"HSPrefGeneralViewController" bundle:nil];
        NSArray * controllers = @[general, editor, [RHPreferencesWindowController flexibleSpacePlaceholderController], about];
        self.prefWndController = [[RHPreferencesWindowController alloc] initWithViewControllers:controllers andTitle:NSLocalizedString(@"Preferences", @"Preferences Window Title")];
    }
    if ([[self.prefWndController window] isVisible]) {
        [popover close];
        [[self.prefWndController window] makeKeyAndOrderFront:self];
        return nil;
    }
    return [self.prefWndController window];
}

#pragma mark - ACEViewDelegate
- (void) textDidChange:(NSNotification *)notification
{
}

#pragma mark - HSPrefProtocol
- (void) setTheme:(NSInteger)index
{
    NSLog(@"%@", [ACEThemeNames humanNameForTheme:index]);
    NSUserDefaults* ud = [NSUserDefaults standardUserDefaults];
    [ud setInteger:index forKey:@"theme"];
    [self.aceEditorView setTheme:index];
}

- (IBAction)onMainMenuPreferences:(id)sender {
    if (![[self.prefWndController window] isVisible]) {
        [self showPref];
    } else {
        [[self.prefWndController window] makeKeyAndOrderFront:self];
    }
}

- (void)showPref
{
    if (!self.prefWndController) {
        HSPrefAboutViewController * about = [[HSPrefAboutViewController alloc] initWithNibName:@"HSPrefAboutViewController" bundle:nil];
        HSPrefEditorViewController * editor = [[HSPrefEditorViewController alloc] initWithNibName:@"HSPrefEditorViewController" bundle:nil];
        HSPrefGeneralViewController * general = [[HSPrefGeneralViewController alloc] initWithNibName:@"HSPrefGeneralViewController" bundle:nil];
        [editor setDelegate:self];
        NSArray * controllers = @[general, editor, [RHPreferencesWindowController flexibleSpacePlaceholderController], about];
        self.prefWndController = [[RHPreferencesWindowController alloc] initWithViewControllers:controllers andTitle:NSLocalizedString(@"Preferences", @"Preferences Window Title")];
    }
    [self.prefWndController showWindow:self];
}

- (void)prepareToolbar
{
    KFToolbarItem *settingItem = [KFToolbarItem toolbarItemWithIcon:[NSImage imageNamed:@"pref"] tag:0];
    settingItem.toolTip = @"Settings";

    KFToolbarItem * openItem = [KFToolbarItem toolbarItemWithIcon:[NSImage imageNamed:@"open"] tag:1];
    openItem.toolTip = @"Open";
    
    KFToolbarItem *saveItem = [KFToolbarItem toolbarItemWithIcon:[NSImage imageNamed:@"save"] tag:2];
    saveItem.toolTip = @"Save";
    
    KFToolbarItem *clearItem = [KFToolbarItem toolbarItemWithIcon:[NSImage imageNamed:@"clear"] tag:3];
    clearItem.toolTip = @"Clean Codes";

    KFToolbarItem *consoleItem = [KFToolbarItem toolbarItemWithIcon:[NSImage imageNamed:@"console"] tag:4];
    consoleItem.toolTip = @"Show Console";
    
    KFToolbarItem *runItem = [KFToolbarItem toolbarItemWithIcon:[NSImage imageNamed:@"run"] tag:5];
    runItem.toolTip = @"Run";
    
    self.bottomToolbar.leftItems = @[settingItem, openItem, saveItem];
    self.bottomToolbar.rightItems = @[clearItem, consoleItem, runItem];
    [self.bottomToolbar setItemSelectionHandler:^(KFToolbarItemSelectionType selectionType, KFToolbarItem *toolbarItem, NSUInteger tag)
     {
         switch (tag)
         {
             case 0:
                 [self onSettingButton: toolbarItem];
                 break;
             case 1:
                 [self onOpenButton];
                 break;
             case 2:
                 [self onSaveButton];
                 break;
             case 3:
                 [self onClearButton];
                 break;
             case 4:
                 [self onShowConsole];
                 break;
             case 5:
                 [self onRunButton];
                 break;
             default:
                 break;
         }
     }];

}

- (void)onSettingButton:(NSButton*)button {
    if (![[self.prefWndController window] isVisible]) {
        if (![self.prefPop isShown]) {
            [self.prefPop showRelativeToRect:button.bounds ofView:button preferredEdge:NSMaxYEdge];
        } else {
            [self.prefPop close];
        }
    } else {
        [[self.prefWndController window] makeKeyAndOrderFront:self];
    }
}

- (void)onOpenButton
{
    NSOpenPanel* op = [NSOpenPanel openPanel];
    [op setCanChooseFiles:YES];
    [op setAllowedFileTypes:@[@"js", @"json", @"txt"]];
    [op setAllowsMultipleSelection:NO];
    [op setAllowsOtherFileTypes:NO];
    [op beginSheetModalForWindow:self.window completionHandler:^(NSInteger result) {
        if (result == NSFileHandlingPanelOKButton) {
            NSURL* path = [op URL];
            NSString * str = [[NSString alloc] initWithContentsOfURL:path encoding:NSUTF8StringEncoding error:nil];
            [self.aceEditorView setString:str];
        }
    }];
}

- (void)onSaveButton
{
    NSSavePanel* sv = [NSOpenPanel savePanel];
    [sv setMessage:@"Please select a path where to save the js file."];
    [sv setCanCreateDirectories:YES];
    [sv setAllowedFileTypes:@[@"js", @"json", @"txt"]];
    [sv setAllowsOtherFileTypes:YES];
    [sv beginSheetModalForWindow:self.window completionHandler:^(NSInteger result) {
        if (result == NSFileHandlingPanelOKButton) {
            NSURL* path = [sv URL];
            if (![self.aceEditorView.string writeToURL:path atomically:YES encoding:NSUTF8StringEncoding error:nil]) {
                [[NSAlert alertWithMessageText:@"Something went wrong!" defaultButton:@"OK" alternateButton:nil otherButton:nil informativeTextWithFormat:@"Hazelnut is unable to be planted to your Mac. :("] runModal];
            }
        }
    }];
}

- (void)onClearButton
{
    [self.aceEditorView setString:@""];
}

- (void)onRunButton
{
    HSJavaScriptManager* js = [HSJavaScriptManager JSMan];
    JSValue* result = [js eval:self.aceEditorView.string];
    if (![result isUndefined]&&![result isNull]&&![result isObject]) {
        [self.consoleText appendContent:[result toString]];
    }
}

- (void)onShowConsole
{
    if (self.consolePanel.isVisible) {
        [self.consolePanel orderOut:self];
    }else{
        [self.consolePanel makeKeyAndOrderFront:self];
    }
}

- (void)setTitleBarView
{
    NSView * titleBarView = self.window.titleBarView;
    NSSize viewSize = NSMakeSize(240.f, 22.f);
    NSRect viewFrame = NSMakeRect(72.f, NSMidY(titleBarView.bounds) - (viewSize.height / 2.f), viewSize.width, viewSize.height);
    m_searchField = [[NSSearchField alloc] initWithFrame:viewFrame];
    [titleBarView addSubview:m_searchField];
}

@end
