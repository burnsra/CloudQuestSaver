//
//  GoogleCloudPlatformView.m
//  GoogleCloudPlatform
//
//  Created by Robert Burns on 11/27/17.
//  Copyright © 2017 Robert Burns. All rights reserved.
//

#import "ConfigureSheet.h"
#import "GoogleCloudPlatformView.h"
#import "NSColor+Hex.h"
#import "WebPreferences.m"
#import <QuartzCore/QuartzCore.h>
#import <WebKit/WebKit.h>

@implementation GoogleCloudPlatformView


NSArray *_myColorsArray;
NSString *_url;
NSTimer *_timer;
WebView *_webView;
NSString *myColors = @"#4285f4,#ea4335,#34a853,#fbbc05";

float colorAnimationDuration = 3.0f;
float colorAnimationInterval = 30.0f;
int currentColor = 0;


- (instancetype)initWithFrame:(NSRect)frame isPreview:(BOOL)isPreview
{
    self = [super initWithFrame:frame isPreview:isPreview];
    if (self) {
        [self initialize];
    }
    return self;
}

- (void)startAnimation
{
    [super startAnimation];
    if (self) {
        [self configureWebView];
        [self loadWebView];
    }
}

- (void)stopAnimation
{
    [super stopAnimation];
}

- (void)drawRect:(NSRect)rect
{
    [super drawRect:rect];
}

- (BOOL)hasConfigureSheet
{
    return YES;
}

- (NSWindow*)configureSheet
{
    if (!configureSheet)
    {
        configureSheet = [[ConfigureSheet alloc] initWithWindowNibName:@"ConfigureSheet"];
    }
    return [configureSheet window];
}

- (void)configureWebUrl
{
    _url = [NSString stringWithFormat:@"file://%@/html/index.html", [[NSBundle bundleForClass:[self class]] resourcePath]];
}

- (void)configureWebView
{
    WebPreferences* prefs = [_webView preferences];
    [prefs setAccelerated2dCanvasEnabled:YES];
    [prefs setAcceleratedDrawingEnabled:YES];
    [prefs setCanvasUsesAcceleratedDrawing:YES];
    [prefs setAcceleratedCompositingEnabled:YES];

    _webView = [[WebView alloc] initWithFrame:[self bounds]];
    [_webView setShouldUpdateWhileOffscreen:YES];
    [_webView setAutoresizingMask:NSViewWidthSizable|NSViewHeightSizable];
    [_webView setAutoresizesSubviews:YES];
    [_webView setDrawsBackground:NO];
    [_webView setMaintainsBackForwardList:NO];
    [_webView setPreferences:prefs];
    [_webView setWantsLayer:YES];
    _webView.layer.backgroundColor = [self getColor:currentColor % _myColorsArray.count].CGColor;

    [self addSubview:_webView];
}

- (void)initialize
{
    _myColorsArray = [myColors componentsSeparatedByString:@","];
    _timer = [NSTimer scheduledTimerWithTimeInterval:colorAnimationInterval target:self selector:@selector(updateTimer) userInfo:nil repeats:true];
    [self configureWebUrl];
    [self configureWebView];
}

- (void)loadWebView
{
    [_webView setMainFrameURL:[_url stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet URLQueryAllowedCharacterSet]]];
    [_webView reloadFromOrigin:nil];
}


- (CAAnimation*)displayAnimationForKeyPath:(NSString*)keyPath from:(NSColor*)from to:(NSColor*)to duration:(float)duration
{
    CABasicAnimation *animation;
    animation                       = [CABasicAnimation animationWithKeyPath:keyPath];
    animation.fromValue             = (id)from.CGColor;
    animation.toValue               = (id)to.CGColor;
    animation.duration              = duration;
    animation.fillMode              = kCAFillModeForwards;
    animation.removedOnCompletion   = NO;
    return animation;
}

- (NSColor *)getColor:(int)index {
    return [NSColor colorFromHexadecimalValue:[_myColorsArray objectAtIndex: index]];
}

- (void)colorCycle
{
    [[_webView layer] removeAllAnimations];
    CAAnimation *animation = [self
                              displayAnimationForKeyPath:@"backgroundColor"
                              from: [self getColor:(currentColor % _myColorsArray.count)]
                              to: [self getColor:((currentColor + 1) % _myColorsArray.count)]
                              duration: colorAnimationDuration
                              ];
    [[_webView layer] addAnimation:animation forKey:@"backgroundColor"];
    currentColor++;
}

- (void)updateTimer {
    [self colorCycle];
}


@end
