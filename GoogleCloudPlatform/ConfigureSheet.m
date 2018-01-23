//
//  ConfigureSheet.m
//  GoogleCloudPlatform
//
//  Created by Robert Burns on 11/28/17.
//  Copyright © 2017 Robert Burns. All rights reserved.
//

#import "ConfigureSheet.h"

@interface ConfigureSheet ()
@property (weak) IBOutlet NSButton *buttonOk;
@property (weak) IBOutlet NSButton *buttonCancel;
@property (weak) IBOutlet NSTextField *copyrightLabel;
@property (weak) IBOutlet NSTextField *productLabel;
@end

@implementation ConfigureSheet

- (void)windowDidLoad {
    [super windowDidLoad];
    [_buttonOk setTag:1];
    [_buttonCancel setTag:0];
    NSDictionary *infoDictionary;
    infoDictionary = [[NSBundle bundleForClass:self.class] infoDictionary];
    NSString *_productValue = [infoDictionary objectForKey:@"CFBundleExecutable"];
    NSString *_copyrightValue = [infoDictionary objectForKey:@"NSHumanReadableCopyright"];
    _productLabel.stringValue = _productValue;
    _copyrightLabel.stringValue = _copyrightValue;
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
