//
//  HSPrefProtocol.h
//  HazelnutScript
//
//  Created by Ke Yang on 4/12/14.
//  Copyright (c) 2014 Pyrus. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol HSPrefProtocol <NSObject>

@optional
- (void) setTheme:(NSInteger) index;
- (void) setShowInvisibles:(BOOL) visible;
@end
