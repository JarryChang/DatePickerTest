//
//  ImageUtil.h
//  Spring
//
//  Created by MeMac.cn on 11-6-21.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface ImageUtil : NSObject {

}
/*
 * 将指定的图片按比例缩放,
 * image:需要缩放的原始图片
 * scaleSize:一个浮点数,大于1时表示放大,小于1时表示缩小,当小于等于0时表示不改变图片大小,通常使用一位小数,没有测试更多小数的情况,理论上没事
 * 返回对象:UIImage为缩放后的图片对象
 */
+ (UIImage *)scaleImage:(UIImage *)image toScale:(float)scaleSize;

+ (UIImage *)scaleImage:(UIImage *)image setWidth:(float)width setHeight:(float)height ;

+ (UIImage *)scaleImage:(UIImage *)image toSizeMake:(CGSize)sizeMake ;

//createImageWithColor
+(UIImage *)createImageWithColor:(UIColor *)color;

@end
