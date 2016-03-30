//
//  PPMPCameraShutterButtonView.m
//  PPMediaPicker
//
//  Created by Alex Padalko on 3/29/16.
//  Copyright © 2016 PlacePixel. All rights reserved.
//

#import "PPMPCameraShutterButtonView.h"
@interface PPMPCameraShutterButtonView ()

@property (nonatomic,retain)UIView * innerView;

@end
@implementation PPMPCameraShutterButtonView


-(instancetype)initWithFrame:(CGRect)frame{
    if (self=[super initWithFrame:frame]) {
        
        [self.layer setBorderWidth:4];
        
        [self.layer setBorderColor:[UIColor whiteColor].CGColor];
        
        [self setBackgroundColor:[UIColor clearColor]];
        [self setRecording:NO];
        
        

        
        
    }
    return self;
}
#pragma mark - layout
-(void)layoutSubviews{
    
    [super layoutSubviews];
    
    [self.innerView setFrame:CGRectMake(10, 10, self.frame.size.width-20, self.frame.size.height-20)];
    
    [self.innerView.layer setCornerRadius:self.innerView.frame.size.height/2];
    
    [self.layer setCornerRadius:self.frame.size.height/2];
    
}






#pragma mark - setters

-(void)setRecording:(BOOL)recording animated:(BOOL)animated{
    
    if (animated) {
        [UIView animateWithDuration:0.33 animations:^{
            self.recording=recording;
        }];
    }
    else{
        
        self.recording=recording;
        
    }
    
}

-(void)setRecording:(BOOL)recording{
    
    _recording=recording;
    
    if (!_recording) {
          [self.innerView setBackgroundColor:[UIColor whiteColor]];
    }else{
          [self.innerView setBackgroundColor:[UIColor redColor]];
    }
  
    
    
}

#pragma mark - li

-(UIView *)innerView{
    if (!_innerView) {
        
        _innerView=[[UIView alloc] init];
        
        [self addSubview:_innerView];
    }
    return _innerView;
    
}

@end
