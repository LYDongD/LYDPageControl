//
//  LYDPageControl.h
//  Utils
//
//  Created by lee on 16/9/3.
//  Copyright © 2016年 lee. All rights reserved.
//

#import <UIKit/UIKit.h>

//设置默认颜色
#define DefaultColor [UIColor lightGrayColor]
#define DefaultSelectColor [UIColor orangeColor]

//小圆点模式可设置颜色，自定义模式可设置图片，否则设置无效
typedef enum {
    PageControlStyleDefault, //小圆点模式
    PageControlStyleCustom //自定义图片模式
}PageControlStyle;

//pageBtn点击回调block类型
typedef void(^BtnHandle)(NSInteger index);


@interface LYDPageControl : UIView

/**
 *  使用此方法构造pageContrl
 *
 *  @param frame
 *  @param style 风格，目前共有两种风格，参见PageControlStyle，设置图片使用custom风格
 *  @param num   pageBtn小圆点的数量
 *  @param block pageBtn小圆点击回调
 *
 *  @return 返回实例
 */
+ (instancetype)pageControlWithFrame:(CGRect)frame style:(PageControlStyle)style pageNum:(NSInteger)num pageBtnClick:(BtnHandle)block;

/**
 *  pageControl风格
 *  1 PageControlStyleDefault 小圆点风格，可设置颜色
 *  2 PageControlStyleCustom 自定义风格，可设置图片
 */
@property (nonatomic, assign) PageControlStyle style;

/**
 *  设置小圆点的个数
 */
@property (nonatomic, assign) NSInteger pageNum;

/**
 *  设置当前选择小圆点的序号，从0开始
 */
@property (nonatomic, assign) NSInteger selectedIndex;

//PageControlStyleDefault下设置属性

/**
 *  小圆点未选中的颜色
 */
@property (nonatomic, copy) UIColor *pageBtnColor;

/**
 *  小圆点的选中颜色
 */
@property (nonatomic, copy) UIColor *currentPageBtnColor;

//PageControlStyleCustom下设置属性

/**
 *  小圆点选中的图片
 */
@property (nonatomic, strong) UIImage *pageBtnImg;
/**
 *  小圆点未选中的图片
 */
@property (nonatomic, strong) UIImage *currentPageBtnImg;

/**
 *  小圆点点击回调
 */
@property (nonatomic, copy) BtnHandle pageBtnClickHandle;

@end
