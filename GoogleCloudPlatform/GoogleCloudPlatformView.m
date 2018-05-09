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

static BOOL firstInstance = true;

NSArray *_myColorsArray;
NSString *_myColors = @"#4285f4,#ea4335,#34a853,#fbbc05";
NSString *_url;
NSTimer *_timer;
WebView *_webView;

float colorAnimationDuration = 2.0f;
float colorAnimationInterval = 10.0f;
int currentColor;

- (instancetype)initWithFrame:(NSRect)frame isPreview:(BOOL)isPreview

{
    self = [super initWithFrame:frame isPreview:isPreview];
    preview = primaryMonitor = false;

    if(isPreview) {
        preview = true;
    } else {
        if(firstInstance) {
            primaryMonitor = true;
            firstInstance = false;
        }
    }
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
    return true;
}

- (NSWindow*)configureSheet
{
    if (!configureSheet)
    {
        configureSheet = [[ConfigureSheet alloc] initWithWindowNibName:@"ConfigureSheet"];
    }
    return [configureSheet window];
}

- (void)configureWebBackground
{
    self.layer = [CALayer layer];
    self.layer.backgroundColor = [self getColor:currentColor % _myColorsArray.count].CGColor;
    self.layer.frame = NSRectToCGRect(self.bounds);
    self.layer.needsDisplayOnBoundsChange = true;
    self.wantsLayer = true;
    //[self.layer setNeedsDisplay];
}

- (void)configureWebUrl
{
    _url = [NSString stringWithFormat:@"file://%@/html/index.html", [[NSBundle bundleForClass:[self class]] resourcePath]];
}

- (void)configureWebView
{
    WebPreferences* prefs = [_webView preferences];
    [prefs setAccelerated2dCanvasEnabled:true];
    [prefs setAcceleratedCompositingEnabled:true];
    [prefs setAcceleratedDrawingEnabled:true];
    [prefs setCanvasUsesAcceleratedDrawing:true];

    _webView = [[WebView alloc] initWithFrame:[self bounds]];
    [_webView setAutoresizesSubviews:true];
    [_webView setAutoresizingMask:NSViewWidthSizable|NSViewHeightSizable];
    [_webView setDrawsBackground:false];
    [_webView setMaintainsBackForwardList:false];
    [_webView setPreferences:prefs];
    [_webView setShouldUpdateWhileOffscreen:true];
    //[_webView setWantsLayer:YES];
    //_webView.layer.backgroundColor = [self getColor:currentColor % _myColorsArray.count].CGColor;

    [self addSubview:_webView];
}

- (void)initialize
{
    _myColorsArray = [_myColors componentsSeparatedByString:@","];
    currentColor = 0;
    [self configureWebBackground];
    [self configureWebUrl];
    [self configureWebView];
    _timer = [NSTimer scheduledTimerWithTimeInterval:colorAnimationInterval target:self selector:@selector(updateTimer) userInfo:nil repeats:true];
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
    animation.removedOnCompletion   = false;
    return animation;
}

- (NSColor *)getColor:(int)index {
    return [NSColor colorFromHexadecimalValue:[_myColorsArray objectAtIndex: index]];
}

- (void)colorCycle
{
    [[self layer] removeAllAnimations];
    CAAnimation *animation = [self
                              displayAnimationForKeyPath:@"backgroundColor"
                              from: [self getColor:(currentColor % _myColorsArray.count)]
                              to: [self getColor:((currentColor + 1) % _myColorsArray.count)]
                              duration: colorAnimationDuration
                              ];
    [[self layer] addAnimation:animation forKey:@"backgroundColor"];
    NSArray *screenArray = [NSScreen screens];
    NSInteger screenCount = [screenArray count];
    if ([[[self window] screen] isEqual:[[NSScreen screens] objectAtIndex:screenCount - 1]] || preview) {
        currentColor++;
    }
}

- (void)updateTimer {
    [self colorCycle];
}

@end
