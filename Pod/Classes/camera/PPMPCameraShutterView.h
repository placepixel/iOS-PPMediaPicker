//
//  PPMPCameraShutterView.h
//  PPMediaPicker
//
//  Created by Alex Padalko on 3/29/16.
//  Copyright © 2016 PlacePixel. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "PPMPCameraShutterButtonView.h"
@protocol  PPMPCammeraShutterViewDelegate<NSObject>


- (void)ppmps_wantToCaptureImage;
- (BOOL)ppmps_wantToStartRecordingVideo;///reurnt successs
- (void)ppmps_wantToEndRecordingVideo;

@end
@interface PPMPCameraShutterView : UIView

@property (weak,nonatomic)id<PPMPCammeraShutterViewDelegate>delegate;

@property (nonatomic,retain)PPMPCameraShutterButtonView * buttonView;

-(void)startRecording;
-(void)stopRecording;
-(void)captureImage;

@end
