//
//  NSTextField+JSConsole.m
//  HazelnutScript
//
//  Created by Ke Yang on 4/12/14.
//  Copyright (c) 2014 Pyrus. All rights reserved.
//

#import "NSTextField+JSConsole.h"

@implementation NSTextField (JSConsole)

- (void) appendContent:(NSString *)string
{
    NSDate * date = [NSDate date];
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc]init];
    [dateFormatter setDateFormat:@"YYYY-MM-dd HH:mm:ss"];
    NSString* content = [[NSString alloc] initWithFormat:@"%@ - %@%@\n", [dateFormatter stringFromDate:date], [self stringValue], string];
    [self setStringValue:content];
}

- (void)log:(NSString*)string
{
    [self appendContent:string];
}

@end
