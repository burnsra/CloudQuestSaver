//
//  WebPreferences.m
//  Google Cloud Platform
//
//  Created by Robert Burns on 4/6/18.
//  Copyright © 2018 Robert Burns. All rights reserved.
//

#import <WebKit/WebKit.h>

@interface WebPreferences (WebPrivate)

- (BOOL)accelerated2dCanvasEnabled;
- (void)setAccelerated2dCanvasEnabled:(BOOL)enabled;

- (BOOL)acceleratedDrawingEnabled;
- (void)setAcceleratedDrawingEnabled:(BOOL)enabled;

- (BOOL)canvasUsesAcceleratedDrawing;
- (void)setCanvasUsesAcceleratedDrawing:(BOOL)enabled;

- (BOOL)acceleratedCompositingEnabled;
- (void)setAcceleratedCompositingEnabled:(BOOL)enabled;

@end
