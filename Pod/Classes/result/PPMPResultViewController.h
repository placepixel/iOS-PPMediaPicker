//
//  PPMPResultViewController.h
//  PPMediaPicker
//
//  Created by Alex Padalko on 3/29/16.
//  Copyright © 2016 PlacePixel. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "PPMPMediaObject.h"
#import "PPMPBaseViewController.h"
@interface PPMPResultViewController : PPMPBaseViewController

-(instancetype)initWithMedia:(PPMPMediaObject*)media allowToEdit:(BOOL)allowToEdit;


@end
