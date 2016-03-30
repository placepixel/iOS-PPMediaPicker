//
//  PPMPBaseViewController.h
//  PPMediaPicker
//
//  Created by Alex Padalko on 3/29/16.
//  Copyright © 2016 PlacePixel. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PPMPDefaults.h"
#import "PPMediaPickerViewController.h"
@interface PPMPBaseViewController : UIViewController

@property(nullable, nonatomic,readonly,strong) PPMediaPickerViewController *navigationController;
@end
