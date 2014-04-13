//
//  HSJavaScriptManager.h
//  HazelnutScript
//
//  Created by Ke Yang on 4/12/14.
//  Copyright (c) 2014 Pyrus. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <JavaScriptCore/JavaScriptCore.h>

@interface HSJavaScriptManager : NSObject

@property (strong, nonatomic) JSContext* context;

+ (HSJavaScriptManager*) JSMan;
- (JSValue*) eval:(NSString*)code;
- (void)addNativeObject:(id<JSExport>)obj WithName:(NSString*)name;


@end
