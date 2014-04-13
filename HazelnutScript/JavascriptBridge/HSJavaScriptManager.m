//
//  HSJavaScriptManager.m
//  HazelnutScript
//
//  Created by Ke Yang on 4/12/14.
//  Copyright (c) 2014 Pyrus. All rights reserved.
//

#import "HSJavaScriptManager.h"
#import "HSJsConsole.h"

@implementation HSJavaScriptManager

+ (HSJavaScriptManager*) JSMan
{
    // this method is implemented by using GCD - grand central dispatch
    static HSJavaScriptManager* JsMan = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        JsMan = [[self alloc] init];
    });
    return JsMan;
}

- (id) init
{
    self = [super init];
    if (self) {
        self.context = [[JSContext alloc] init];
        [self addNativeObject:[[HSJsConsole alloc] init] WithName:@"console"];
    }
    return self;
}

- (JSValue*) eval:(NSString*)code
{
    return [self.context evaluateScript:code];
}

//- (void) addNativeObjects
//{
//    self.context[@"console"] = [[HSJsConsole alloc] init];
//}

- (void)addNativeObject:(id<JSExport>)obj WithName:(NSString*)name
{
    NSLog(@"just added %@", name);
    self.context[name] = obj;
}

@end
