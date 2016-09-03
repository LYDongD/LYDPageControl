//
//  LYDPageControl.m
//  Utils
//
//  Created by lee on 16/9/3.
//  Copyright © 2016年 lee. All rights reserved.
//

#import "LYDPageControl.h"

#define BaseTag 35678
#define margin 5


@interface LYDPageControl ()

@property (nonatomic, strong) NSArray *pageBtns;

@property (nonatomic, weak) UIView *pageBtnBackView;

@end

@implementation LYDPageControl

+ (instancetype)pageControlWithFrame:(CGRect)frame style:(PageControlStyle)style pageNum:(NSInteger)num pageBtnClick:(BtnHandle)block {
    
    LYDPageControl *pageControl = [[LYDPageControl alloc]initWithFrame:frame];
    pageControl.pageBtnClickHandle = block;
    pageControl.style = style;
    pageControl.pageNum = num;
    pageControl.selectedIndex = 0;
    
    return pageControl;
}


- (void)setPageNum:(NSInteger)pageNum {
    _pageNum = pageNum;
    
    //backView
    CGFloat width = 10;
    CGFloat backViewWidth = width * pageNum + margin * (pageNum - 1);
    CGFloat backViewHeight = 20;
    
    UIView *pageBtnBackView = [[UIView alloc]init];
    _pageBtnBackView = pageBtnBackView;
    pageBtnBackView.backgroundColor = [UIColor clearColor];
    [self addSubview:pageBtnBackView];
    pageBtnBackView.frame = CGRectMake((self.frame.size.width - backViewWidth) * 0.5, (self.frame.size.height - backViewHeight) * 0.5, backViewWidth, backViewHeight);
    
    //设置btn
    NSMutableArray *tem = [@[]mutableCopy];
    for (int i = 0; i < pageNum; i++) {
        UIButton *pageBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [pageBtnBackView addSubview:pageBtn];
        [tem addObject:pageBtn];
        pageBtn.frame = CGRectMake((margin + width) * i, 0, width, width);
        
        [pageBtn setAdjustsImageWhenHighlighted:NO];
        
        if (self.style == PageControlStyleDefault) {
            pageBtn.backgroundColor = self.pageBtnColor ? self.pageBtnColor : DefaultColor;
            //默认样式为小圆点
            pageBtn.layer.cornerRadius = width * 0.5;
            pageBtn.layer.masksToBounds = YES;
        }
      
        //pageBtn自身保存index数
        pageBtn.tag = BaseTag + i;
        
        [pageBtn addTarget:self action:@selector(pageBtnClicked:) forControlEvents:UIControlEventTouchUpInside];
    }
    _pageBtns =[tem copy];
}

- (void)pageBtnClicked:(UIButton*)sender {
    
    //刷新按钮的状态
    for (UIButton *pageBtn in self.pageBtns) {
        pageBtn.selected = NO;
        pageBtn.userInteractionEnabled = YES;
        
        if (self.style == PageControlStyleDefault) {
             pageBtn.backgroundColor = self.pageBtnColor ? self.pageBtnColor : DefaultColor;
            
        }
    }
    sender.selected = YES;
    sender.userInteractionEnabled = NO;
    
    if (self.style == PageControlStyleDefault) {
        sender.backgroundColor = self.currentPageBtnColor ? self.currentPageBtnColor : DefaultSelectColor;
    }
    
    //回调
    if (self.pageBtnClickHandle) {
        self.pageBtnClickHandle(sender.tag - BaseTag);
    }
}

- (void)setPageBtnColor:(UIColor *)pageBtnColor{
    _pageBtnColor = pageBtnColor;
    if (self.style == PageControlStyleDefault) {
        for (UIButton *pageBtn in self.pageBtns) {
            if (!pageBtn.selected) {
                pageBtn.backgroundColor = pageBtnColor;
            }
        }
    }
    
}

- (void)setCurrentPageBtnColor:(UIColor *)currentPageBtnColor{
    _currentPageBtnColor = currentPageBtnColor;
    
    if (self.style == PageControlStyleDefault) {
        for (UIButton *pageBtn in self.pageBtns) {
            if (pageBtn.selected) {
                pageBtn.backgroundColor = currentPageBtnColor;
            }
        }
    }
}

-(void)setPageBtnImg:(UIImage *)pageBtnImg {
    _pageBtnImg = pageBtnImg;
    
    if (self.style == PageControlStyleCustom) {
        for (UIButton *pageBtn in self.pageBtns) {
            [pageBtn setImage:pageBtnImg forState:UIControlStateNormal];
        }
    }
    
    [self layoutSubviews];
}

- (void)setCurrentPageBtnImg:(UIImage *)currentPageBtnImg {
    _currentPageBtnImg = currentPageBtnImg;
    
    if (self.style == PageControlStyleCustom) {
        for (UIButton *pageBtn in self.pageBtns) {
            [pageBtn setImage:currentPageBtnImg forState:UIControlStateSelected];

        }
    }
}

- (void)setSelectedIndex:(NSInteger)selectedIndex {
    _selectedIndex = selectedIndex;
    
    for (UIButton *pageBtn in self.pageBtns) {
        pageBtn.selected = NO;
        pageBtn.userInteractionEnabled = YES;
        
        if (self.style == PageControlStyleDefault) {
            pageBtn.backgroundColor = self.pageBtnColor ? self.pageBtnColor : DefaultColor;
        }
        
        if (pageBtn.tag - BaseTag == selectedIndex) {
            pageBtn.selected = YES;
            pageBtn.userInteractionEnabled = NO;
            
            if (self.style == PageControlStyleDefault) {
                pageBtn.backgroundColor = self.currentPageBtnColor ? self.currentPageBtnColor : DefaultSelectColor;
            }
        }
    }
}

- (void)layoutSubviews{
    [super layoutSubviews];
    
    if (self.style == PageControlStyleCustom) {
        
        CGSize size = self.pageBtnBackView.frame.size;
        CGPoint origin = self.pageBtnBackView.frame.origin;
        CGFloat backViewWidth = self.pageBtnImg.size.width * self.pageNum + margin * (self.pageNum - 1);
        size.width = backViewWidth;
        self.pageBtnBackView.frame = CGRectMake((self.frame.size.width - backViewWidth) * 0.5, origin.y,200, size.height);
        
        
        for (UIButton *pageBtn in self.pageBtns) {
            CGSize size = pageBtn.frame.size;
            CGPoint origin = pageBtn.frame.origin;
            size = self.pageBtnImg.size;
            pageBtn.frame = CGRectMake((size.width + margin) * (pageBtn.tag - BaseTag), origin.y, size.width, size.height);
        }
    }
}

@end
