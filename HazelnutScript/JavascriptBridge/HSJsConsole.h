//
//  HSJsConsole.h
//  HazelnutScript
//
//  Created by Ke Yang on 4/12/14.
//  Copyright (c) 2014 Pyrus. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <JavaScriptCore/JavaScriptCore.h>

@protocol JsConsoleExport <JSExport>

- (void)log:(NSString*)string;

@end

@interface HSJsConsole : NSObject <JsConsoleExport>

@end
