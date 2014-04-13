//
//  HSPrefGeneralViewController.m
//  HazelnutScript
//
//  Created by Ke Yang on 4/12/14.
//  Copyright (c) 2014 Pyrus. All rights reserved.
//

#import "HSPrefGeneralViewController.h"

@interface HSPrefGeneralViewController ()

@property (strong) IBOutlet NSView *prefView;

@end

@implementation HSPrefGeneralViewController

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
    return [NSImage imageNamed:@"general"];
}
-(NSString*)toolbarItemLabel{
    return NSLocalizedString(@"General", @"GeneralToolbarItemLabel");
}

-(NSView*)initialKeyView{
    return self.prefView;
}

@end
