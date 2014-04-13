//
//  HSPrefEditorViewController.m
//  HazelnutScript
//
//  Created by Ke Yang on 4/12/14.
//  Copyright (c) 2014 Pyrus. All rights reserved.
//

#import "HSPrefEditorViewController.h"
#import <ACEView/ACEThemeNames.h>

@interface HSPrefEditorViewController ()

@property (strong) IBOutlet NSView *prefView;
@property (weak) IBOutlet NSPopUpButton *themeList;
- (IBAction)onEditorThemeChanged:(id)sender;

@end

@implementation HSPrefEditorViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {}
    return self;
}

- (void)awakeFromNib
{
    [self.themeList removeAllItems];
    [self.themeList addItemsWithTitles:[NSArray arrayWithArray:[ACEThemeNames humanThemeNames]]];
    [self.themeList selectItemAtIndex:ACEThemeXcode];
}

-(NSString*)identifier{
    return NSStringFromClass(self.class);
}
-(NSImage*)toolbarItemImage{
    return [NSImage imageNamed:@"editor"];
}
-(NSString*)toolbarItemLabel{
    return NSLocalizedString(@"Editor", @"EditorToolbarItemLabel");
}

-(NSView*)initialKeyView{
    return self.prefView;
}

- (IBAction)onEditorThemeChanged:(id)sender {
    NSLog(@"_theme changed");
    [self.delegate setTheme:[self.themeList indexOfSelectedItem]];
}
@end
