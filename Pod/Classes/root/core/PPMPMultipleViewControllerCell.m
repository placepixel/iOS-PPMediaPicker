//
//  PPMPMultipleViewControllerCell.m
//  PPMediaPicker
//
//  Created by Alex Padalko on 3/29/16.
//  Copyright © 2016 PlacePixel. All rights reserved.
//

#import "PPMPMultipleViewControllerCell.h"

@implementation PPMPMultipleViewControllerCell


-(void)setViewController:(UIViewController *)viewController{
    if (_viewController==viewController) {
        return;
    }
    if (_viewController) {
        [[_viewController view] removeFromSuperview];
    }
    _viewController=viewController;
    
    [self addSubview:_viewController.view];
}

-(void)layoutSubviews{
    
    [super layoutSubviews];
    
    [self.viewController.view setFrame:self.bounds];
}

@end
