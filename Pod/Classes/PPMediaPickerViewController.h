//
//  PPMediaPickerViewController.h
//  PPMediaPicker
//
//  Created by Alex Padalko on 3/29/16.
//  Copyright © 2016 PlacePixel. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PPMPMediaObject.h"
@class PPMediaPickerViewController;
@protocol PPMediaPickerViewControllerDelegate <NSObject>

-(void)meidaPickerDidCancel:(PPMediaPickerViewController*)mediaPicker;
-(void)meidaPicker:(PPMediaPickerViewController*)mediaPicker didFinishWorkingWithMediaObject:(PPMPMediaObject*)media;
@end

@interface PPMediaPickerViewController : UINavigationController
-(instancetype)initMediaPicker;
@property (nonatomic,weak)id<PPMediaPickerViewControllerDelegate> pickerDelegate;
-(void)finishWithMediaObject:(PPMPMediaObject*)media;
-(void)close;

@end
