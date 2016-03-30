//
//  PPMPCameraShutterView.m
//  PPMediaPicker
//
//  Created by Alex Padalko on 3/29/16.
//  Copyright © 2016 PlacePixel. All rights reserved.
//

#import "PPMPCameraShutterView.h"




@interface PPMPCameraShutterView ()


@end
@implementation PPMPCameraShutterView


-(instancetype)initWithFrame:(CGRect)frame{
    if (self=[super initWithFrame:frame]) {
        
        UITapGestureRecognizer *tapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(onTap:)];
        
        [self addGestureRecognizer:tapGesture];

        
        
        UILongPressGestureRecognizer * longPress = [[UILongPressGestureRecognizer alloc] initWithTarget:self action:@selector(onLongPress:)];
        longPress.minimumPressDuration=0.2;
        
        [self addGestureRecognizer:longPress];

        
    }
    return self;
}

#pragma mark - layout

-(void)layoutSubviews{
    
    [super layoutSubviews];
    
    [self.buttonView setFrame:self.bounds];
    
    
    
}


#pragma mark - gestures


- (void) onTap:(UITapGestureRecognizer*)tap
{
    [self captureImage];
}
-(void)onLongPress:(UILongPressGestureRecognizer*)gesture{
    
    switch (gesture.state) {
        case UIGestureRecognizerStateBegan:{
            
            [self startRecording];
            
        }
            break;
        case UIGestureRecognizerStateEnded:
        case UIGestureRecognizerStateCancelled:
        {
            
            [self stopRecording];
        }
            
        case UIGestureRecognizerStateChanged:
        {
            
            
        }
            break;
            
        default:
            break;
    }
}
#pragma mark - capturing

-(void)captureImage{

    
    [self.delegate ppmps_wantToCaptureImage];
    
}

-(void)stopRecording{
    [[self buttonView] setRecording:NO animated:YES];
        [self.delegate ppmps_wantToEndRecordingVideo];
}
-(void)startRecording{
    BOOL result=[self.delegate ppmps_wantToStartRecordingVideo];
    
    if (result) {
        [[self buttonView] setRecording:YES animated:YES];
    }
    
    
}



#pragma mark - li

-(PPMPCameraShutterButtonView *)buttonView{
    
    if (!_buttonView) {
        _buttonView=[[PPMPCameraShutterButtonView alloc] init];
        
        [self addSubview:_buttonView];
    }
    return _buttonView;
}
@end
