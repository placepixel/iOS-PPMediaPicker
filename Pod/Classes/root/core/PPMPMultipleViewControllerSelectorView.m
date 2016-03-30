//
//  PPMPMultipleViewControllerSelectorView.m
//  PPMediaPicker
//
//  Created by Alex Padalko on 3/29/16.
//  Copyright © 2016 PlacePixel. All rights reserved.
//

#import "PPMPMultipleViewControllerSelectorView.h"
#import "PPMPDefaults.h"
@interface PPMPMultipleViewControllerSelectorView ()

@property (nonatomic)CGSize contentSize;
@property (nonatomic)CGPoint offset;
@property (nonatomic,retain)UIView * selectorView;


@property (nonatomic,retain)NSMutableArray * buttonsArray;

@end

@implementation PPMPMultipleViewControllerSelectorView

-(instancetype)initWithFrame:(CGRect)frame{
    
    if (self=[super initWithFrame:frame]) {
        
        [self setClipsToBounds:YES];
        [self setBackgroundColor:[UIColor yellowColor]];
        
    }
    return self;
}

-(void)setTitles:(NSArray *)titles{
    _titles=titles;
    
    for (UIView * v in self.buttonsArray) {
        [v removeFromSuperview];
    }
    
    self.buttonsArray=[[NSMutableArray alloc] init];
    NSInteger a=0;
    for (NSString * title in titles) {
        
        UIButton * label =[UIButton buttonWithType:UIButtonTypeCustom];
        [label setTag:a];
        [label setTitle:[title uppercaseString] forState:UIControlStateNormal];
      
        [self addSubview:label];
        
        [label.titleLabel setFont:[[PPMPDefaults uiObject] selector_titleFont]];
        
        [label setTitleColor:[[PPMPDefaults uiObject] selector_unselectedColor] forState:UIControlStateSelected];
        [label setTitleColor:[[PPMPDefaults uiObject] selector_selectedColor] forState:UIControlStateSelected];
        [label addTarget:self action:@selector(onButton:) forControlEvents:UIControlEventTouchUpInside];
        [self.buttonsArray addObject:label];
        a++;
    }
    
}

-(void)onButton:(UIButton*)but{
    

    [self.horScrollView setContentOffset:CGPointMake(but.tag*self.horScrollView.frame.size.width, 0)animated:YES];
    
}


-(void)layoutSubviews{
    
    [super layoutSubviews];
    
    
    float w = self.frame.size.width/self.buttonsArray.count;
    for (NSInteger a= 0; a<self.buttonsArray.count; a++) {
        
        UIButton *  b =[self.buttonsArray objectAtIndex:a];
        
        [b setFrame:CGRectMake(w*a, 0, w, self.frame.size.height)];
        
        
    }
    
    [self.selectorView setFrame:CGRectMake(self.offset.x, self.frame.size.height-4, w, 4)];
    
}

-(void)setHorScrollView:(UIScrollView *)horScrollView{
    
    if (_horScrollView) {
        @try {
            [_horScrollView removeObserver:self forKeyPath:@"contentOffset"];
            [_horScrollView removeObserver:self forKeyPath:@"contentSize"];
        } @catch (NSException *exception) {
            
        }
 
    }
    
    
    _horScrollView=horScrollView;
    
    
    [_horScrollView addObserver:self forKeyPath:@"contentOffset" options:0 context:nil];
//     [_horScrollView addObserver:self forKeyPath:@"contentSize" options:0 context:nil];
    
}
-(void)setContentSize:(CGSize)contentSize{
    _contentSize=contentSize;
}
-(void)setOffset:(CGPoint)offset{
    if (self.horScrollView.contentSize.width<=0||self.buttonsArray.count==0) {
        return;
    }
    
    _offset=CGPointMake(offset.x * (self.frame.size.width/self.horScrollView.contentSize.width), 0);
    float w = self.frame.size.width/self.buttonsArray.count;
    [self.selectorView setFrame:CGRectMake(self.offset.x, self.frame.size.height-4, w, 4)];
    NSLog(@"%@",NSStringFromCGPoint(offset));
    
    

    NSInteger sIdx=roundf(_offset.x/w);
    
    for (NSInteger a=0; a<self.buttonsArray.count; a++) {
        UIButton * b = [self.buttonsArray objectAtIndex:a];
        
        if (a==sIdx) {
            [b setSelected:YES];
        }else{
            [b setSelected:NO];
        }
    }

}

-(void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSString *,id> *)change context:(void *)context{
    
    
    if ([object isEqual:_horScrollView]) {
        
        if ([keyPath isEqualToString:@"contentOffset"]) {
            self.offset=[self.horScrollView contentOffset];
        }else if ([keyPath isEqualToString:@"contentSize"]){
            self.contentSize=[self.horScrollView contentSize];
            
        }
        
    }
    
}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/
-(UIView *)selectorView{
    if (!_selectorView) {
        _selectorView=[[UIView alloc] init];
        [_selectorView setBackgroundColor:[[PPMPDefaults uiObject] selector_selectedColor]];
        [self addSubview:_selectorView];
    }
    return _selectorView;
}
-(void)dealloc{
    
    self.horScrollView=nil;
}

@end
