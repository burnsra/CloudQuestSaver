//
//  GoogleCloudPlatformView.m
//  GoogleCloudPlatform
//
//  Created by Robert Burns on 11/27/17.
//  Copyright © 2017 Robert Burns. All rights reserved.
//

#import "ConfigureSheet.h"
#import "GoogleCloudPlatformView.h"
#import <WebKit/WebKit.h>

@implementation GoogleCloudPlatformView

WebView *_webView;
NSString *_url;

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

- (void)animateOneFrame
{
    return;
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
    _webView = [[WebView alloc] initWithFrame:[self bounds]];
    [_webView setShouldUpdateWhileOffscreen:YES];
    [_webView setAutoresizingMask:NSViewWidthSizable|NSViewHeightSizable];
    [_webView setAutoresizesSubviews:YES];
    [_webView setDrawsBackground:NO];
    [_webView setMaintainsBackForwardList:NO];
    [self addSubview:_webView];
}

- (void)initialize
{
    [self configureWebUrl];
    [self configureWebView];
}

- (void)loadWebView
{
    [_webView setMainFrameURL:[_url stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet URLQueryAllowedCharacterSet]]];
    [_webView reloadFromOrigin:nil];
}

@end
