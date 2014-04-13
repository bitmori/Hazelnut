//
//  NSTextField+JSConsole.h
//  HazelnutScript
//
//  Created by Ke Yang on 4/12/14.
//  Copyright (c) 2014 Pyrus. All rights reserved.
//

#import <Cocoa/Cocoa.h>
#import <JavaScriptCore/JavaScriptCore.h>

@protocol NSTextFieldJSConsole <JSExport>

- (void)log:(NSString*)string;

@end

@interface NSTextField (JSConsole) <NSTextFieldJSConsole>

- (void)appendContent:(NSString*)string;

@end
