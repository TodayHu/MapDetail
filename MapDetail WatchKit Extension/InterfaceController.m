//
//  InterfaceController.m
//  MapDetail WatchKit Extension
//
//  Created by MAEDAHAJIME on 2015/04/11.
//  Copyright (c) 2015年 MAEDAHAJIME. All rights reserved.
//

#import "InterfaceController.h"

// 接続
@interface InterfaceController()

// 地図
@property (weak, nonatomic) IBOutlet WKInterfaceMap *map;
//
@property (nonatomic) MKCoordinateRegion currentRegion;
// 表示領域 緯度経度方向の幅を表す値
@property (nonatomic) MKCoordinateSpan currentSpan;

@property (weak, nonatomic) IBOutlet WKInterfaceButton *appleButton;
@property (weak, nonatomic) IBOutlet WKInterfaceButton *tokyoButton;
@property (weak, nonatomic) IBOutlet WKInterfaceButton *inButton;
@property (weak, nonatomic) IBOutlet WKInterfaceButton *outButton;
@property (weak, nonatomic) IBOutlet WKInterfaceButton *pinsButton;
@property (weak, nonatomic) IBOutlet WKInterfaceButton *imagesButton;
@property (weak, nonatomic) IBOutlet WKInterfaceButton *removeAllButton;

@end


@implementation InterfaceController

- (void)awakeWithContext:(id)context {
    [super awakeWithContext:context];

    // Configure interface objects here.
    
    // 表示領域 緯度経度方向の幅を表す値
    _currentSpan = MKCoordinateSpanMake(1.0f, 1.0f);
    
    // Apple Map
    CLLocationCoordinate2D coordinate = CLLocationCoordinate2DMake(37.331793f, -122.029584f);
    [self setMapToCoordinate:coordinate];
    
}

- (void)willActivate {
    // This method is called when watch view controller is about to be visible to user
    [super willActivate];
}

- (void)didDeactivate {
    // This method is called when watch view controller is no longer visible
    [super didDeactivate];
}

// 東京 Map
- (IBAction)goToTokyo {
    CLLocationCoordinate2D coordinate = CLLocationCoordinate2DMake(35.4f, 139.4f);
    
    [self setMapToCoordinate:coordinate];
}

// Apple Map
- (IBAction)goToApple {
    CLLocationCoordinate2D coordinate = CLLocationCoordinate2DMake(37.331793f, -122.029584f);
    
    [self setMapToCoordinate:coordinate];
}

// 地図表示
- (void)setMapToCoordinate:(CLLocationCoordinate2D)coordinate {
    MKCoordinateRegion region = MKCoordinateRegionMake(coordinate, self.currentSpan);
    self.currentRegion = region;
    
    MKMapPoint newCenterPoint = MKMapPointForCoordinate(coordinate);
    
    [self.map setVisibleMapRect:MKMapRectMake(newCenterPoint.x, newCenterPoint.y, self.currentSpan.latitudeDelta, self.currentSpan.longitudeDelta)];
    [self.map setRegion:region];
}

// ズームアウト
- (IBAction)zoomOut {
    MKCoordinateSpan span = MKCoordinateSpanMake(self.currentSpan.latitudeDelta * 2, self.currentSpan.longitudeDelta * 2);
    MKCoordinateRegion region = MKCoordinateRegionMake(self.currentRegion.center, span);
    
    self.currentSpan = span;
    [self.map setRegion:region];
}

// ズームイン
- (IBAction)zoomIn {
    MKCoordinateSpan span = MKCoordinateSpanMake(self.currentSpan.latitudeDelta * 0.5f, self.currentSpan.longitudeDelta * 0.5f);
    MKCoordinateRegion region = MKCoordinateRegionMake(self.currentRegion.center, span);
    
    self.currentSpan = span;
    [self.map setRegion:region];
}

// ピン
- (IBAction)addPinAnnotations {
    
    // 赤ピン
    [self.map addAnnotation:self.currentRegion.center withPinColor:WKInterfaceMapPinColorRed];
    
    CLLocationCoordinate2D greenCoordinate = CLLocationCoordinate2DMake(self.currentRegion.center.latitude, self.currentRegion.center.longitude - 0.3f);
    // 緑ピン
    [self.map addAnnotation:greenCoordinate withPinColor:WKInterfaceMapPinColorGreen];
    
    CLLocationCoordinate2D purpleCoordinate = CLLocationCoordinate2DMake(self.currentRegion.center.latitude, self.currentRegion.center.longitude + 0.3f);
    // 紫ピン
    [self.map addAnnotation:purpleCoordinate withPinColor:WKInterfaceMapPinColorPurple];
}

// イメージ画像表示
- (IBAction)addImageAnnotations {
    
    CLLocationCoordinate2D firstCoordinate = CLLocationCoordinate2DMake(self.currentRegion.center.latitude, self.currentRegion.center.longitude - 0.3f);
    
    // Uses image in WatchKit app bundle.
    [self.map addAnnotation:firstCoordinate withImageNamed:@"Whale" centerOffset:CGPointZero];
    
    CLLocationCoordinate2D secondCoordinate = CLLocationCoordinate2DMake(self.currentRegion.center.latitude, self.currentRegion.center.longitude + 0.4f);
    
    // Uses image in WatchKit Extension bundle.
    UIImage *image = [UIImage imageNamed:@"Bumblebee"];
    [self.map addAnnotation:secondCoordinate withImage:image centerOffset:CGPointZero];
}

// Annotation画像削除
- (IBAction)removeAll {
    [self.map removeAllAnnotations];
}

@end



