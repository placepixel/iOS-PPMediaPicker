//
//  PPMPCameraShutterButtonView.h
//  PPMediaPicker
//
//  Created by Alex Padalko on 3/29/16.
//  Copyright © 2016 PlacePixel. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface PPMPCameraShutterButtonView : UIView
@property (nonatomic,getter=isRecording)BOOL recording;

-(void)setRecording:(BOOL)recording animated:(BOOL)animated;



@end
