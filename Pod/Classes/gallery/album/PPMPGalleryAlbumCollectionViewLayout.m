//
//  PPMPGalleryAlbumCollectionViewLayout.m
//  PPMediaPicker
//
//  Created by Alex Padalko on 3/29/16.
//  Copyright © 2016 PlacePixel. All rights reserved.
//

#import "PPMPGalleryAlbumCollectionViewLayout.h"

@implementation PPMPGalleryAlbumCollectionViewLayout
-(CGSize)collectionViewContentSize{
    
    return CGSizeMake(self.collectionView.frame.size.width, MAX(self.collectionView.frame.size.height+[self.collectionView contentInset].top+self.headerReferenceSize.height, [super collectionViewContentSize].height));
    
}
@end
