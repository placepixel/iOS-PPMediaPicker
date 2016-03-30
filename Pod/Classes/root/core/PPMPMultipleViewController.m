//
//  PPMPMultipleViewController.m
//  PPMediaPicker
//
//  Created by Alex Padalko on 3/29/16.
//  Copyright © 2016 PlacePixel. All rights reserved.
//

#import "PPMPMultipleViewController.h"
#import "PPMPMultipleViewControllerCell.h"
#import "PPMPMultipleViewControllerSelectorView.h"
@interface PPMPMultipleViewController () <UICollectionViewDelegate,UICollectionViewDataSource>


@property (nonatomic,retain)UICollectionView * contentCollectionView;
@property (nonatomic,retain)UICollectionViewFlowLayout * contentColelctionViewLayout;

@property (nonatomic,retain)PPMPMultipleViewControllerSelectorView * selectorView;


@end
@implementation PPMPMultipleViewController


-(instancetype)initWithViewControllers:(NSArray *)viewControllers{
    
    if (self=[super init]) {
        
        self.viewControllers=viewControllers;
    }
    return self;
    
}
#pragma mark - lc
-(void)viewDidLoad{
    [super viewDidLoad];
    
    [self.contentCollectionView registerClass:[PPMPMultipleViewControllerCell class] forCellWithReuseIdentifier:@"cell_indif"];
    [self.selectorView setHorScrollView:self.contentCollectionView];
    

    
    [self.navigationItem setTitleView:self.selectorView];
}
#pragma mark - layout
-(void)viewDidLayoutSubviews{
    [super viewDidLayoutSubviews];
    
    
    CGRect contentFrame = CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height);
    
//    [self.topBar setFrame:CGRectMake(0, 0, self.view.frame.size.width, 44)];
    
    [self.contentCollectionView setFrame:contentFrame];
    [self.contentColelctionViewLayout setItemSize:contentFrame.size];
}
#pragma mar- settersl
-(void)setViewControllers:(NSArray *)viewControllers{
    
    _viewControllers=viewControllers;
    NSMutableArray * titles=[[NSMutableArray alloc] init];
    for (UIViewController * vc in viewControllers) {
        
        [self addChildViewController:vc];
        
        [titles addObject:vc.title];
    }
    

    [self.contentCollectionView reloadData];
        [self.selectorView setTitles:titles];
}


#pragma mark - <UICollectionViewDelegate,UICollectionViewDataSource>

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return self.viewControllers.count;
}
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    
    
    PPMPMultipleViewControllerCell * cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"cell_indif" forIndexPath:indexPath];
    [cell setViewController:[self.viewControllers objectAtIndex:indexPath.row]];
    
    return cell;
}


#pragma mark - lazy init

-(PPMPMultipleViewControllerSelectorView *)selectorView{
    
    if (!_selectorView) {
        _selectorView=[[PPMPMultipleViewControllerSelectorView alloc] init];
            [_selectorView setFrame:CGRectMake(0, 0, self.view.frame.size.width-88, 44)];
    }
    return _selectorView;
}

-(UICollectionViewFlowLayout *)contentColelctionViewLayout{
    if (!_contentColelctionViewLayout) {
        _contentColelctionViewLayout=[[UICollectionViewFlowLayout alloc] init];
        [_contentColelctionViewLayout setMinimumLineSpacing:0];
        [_contentColelctionViewLayout setMinimumInteritemSpacing:0];
        [_contentColelctionViewLayout setScrollDirection:UICollectionViewScrollDirectionHorizontal];
        
        
    }
    return _contentColelctionViewLayout;
}
-(UICollectionView *)contentCollectionView{
    if (!_contentCollectionView) {
        _contentCollectionView=[[UICollectionView alloc] initWithFrame:CGRectZero collectionViewLayout:self.contentColelctionViewLayout];
        [_contentCollectionView setDelegate:self];
        [_contentCollectionView setDataSource:self];
        [_contentCollectionView setBackgroundColor:[[PPMPDefaults uiObject] defaultBackgroundColor] ];
        [self.view addSubview:_contentCollectionView];
        [_contentCollectionView setPagingEnabled:YES];
    }
    return _contentCollectionView;
}

@end
