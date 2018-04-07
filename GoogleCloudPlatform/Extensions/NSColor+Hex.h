//
//  NSColor+Hex.h
//  GoogleCloudPlatform
//
//  Created by Robert Burns on 4/7/18.
//  Copyright © 2018 Robert Burns. All rights reserved.
//

#import <Cocoa/Cocoa.h>

@interface NSColor (Hex)

- (NSString *)hexadecimalValue;
+ (NSColor *)colorFromHexadecimalValue:(NSString *)hex;

@end
