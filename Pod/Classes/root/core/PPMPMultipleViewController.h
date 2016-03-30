//
//  PPMPMultipleViewController.h
//  PPMediaPicker
//
//  Created by Alex Padalko on 3/29/16.
//  Copyright © 2016 PlacePixel. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PPMPBaseViewController.h"
@interface PPMPMultipleViewController : PPMPBaseViewController

-(instancetype)initWithViewControllers:(NSArray*)viewControllers;
@property (nonatomic,retain)NSArray * viewControllers;


@end
