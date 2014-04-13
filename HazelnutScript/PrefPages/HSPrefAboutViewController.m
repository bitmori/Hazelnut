//
//  HSPrefAboutViewController.m
//  HazelnutScript
//
//  Created by Ke Yang on 4/12/14.
//  Copyright (c) 2014 Pyrus. All rights reserved.
//

#import "HSPrefAboutViewController.h"

@interface HSPrefAboutViewController ()
@property (strong) IBOutlet NSView *prefView;

@end

@implementation HSPrefAboutViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Initialization code here.
    }
    return self;
}

-(NSString*)identifier{
    return NSStringFromClass(self.class);
}
-(NSImage*)toolbarItemImage{
    return [NSImage imageNamed:@"about"];
}
-(NSString*)toolbarItemLabel{
    return NSLocalizedString(@"About", @"AboutToolbarItemLabel");
}

-(NSView*)initialKeyView{
    return self.prefView;
}

@end
