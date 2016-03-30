//
//  PPMPGalleryAlbumCollectionViewCell.m
//  PPMediaPicker
//
//  Created by Alex Padalko on 3/28/16.
//  Copyright © 2016 PlacePixel. All rights reserved.
//

#import "PPMPGalleryAlbumCollectionViewCell.h"

@interface PPMPGalleryAlbumCollectionViewCell ()

@property (nonatomic,retain)UIImageView * imageView;

@end

@implementation PPMPGalleryAlbumCollectionViewCell



-(void)setImage:(UIImage *)image{
    [self.imageView setImage:image];
}

-(void)layoutSubviews{
    [super layoutSubviews];
    
    [self.imageView setFrame:self.bounds];
}
-(UIImageView *)imageView{
    if (!_imageView) {
        _imageView=[[UIImageView alloc] init];
        
        [self addSubview:_imageView];
    }
    return _imageView;
}



@end
