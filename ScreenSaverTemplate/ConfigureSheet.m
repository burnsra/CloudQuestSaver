//
//  ConfigureSheet.m
//  ScreenSaverTemplate
//
//  Created by Robert Burns on 11/28/17.
//  Copyright © 2017 Robert Burns. All rights reserved.
//

#import "ConfigureSheet.h"

@interface ConfigureSheet ()

@end

@implementation ConfigureSheet

- (void)windowDidLoad {
    [super windowDidLoad];
}

- (id)initWithWindowNibName:(NSString *)windowNibName owner:(id)owner
{
    self = [super initWithWindowNibName:windowNibName owner:owner];
    return self;
}

- (IBAction)closeConfigureSheet:(NSButton *)sender
{
    [[NSApplication sharedApplication] endSheet:[self window] returnCode:([sender tag] == 1) ? NSModalResponseOK : NSModalResponseCancel];
}

@end
