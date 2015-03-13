//
//  ImageUtil.m
//  Spring
//
//  Created by MeMac.cn on 11-6-21.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "ImageUtil.h"


@implementation ImageUtil

+ (UIImage *)scaleImage:(UIImage *)image toScale:(float)scaleSize {
	if(image==nil){
		return nil;
	}
	if(scaleSize<=0){
		scaleSize = 1.0f;
	}
	UIGraphicsBeginImageContext(CGSizeMake(image.size.width * scaleSize, image.size.height * scaleSize));
	[image drawInRect:CGRectMake(0, 0, image.size.width * scaleSize, image.size.height * scaleSize)];
	UIImage *scaledImage = UIGraphicsGetImageFromCurrentImageContext();
	UIGraphicsEndImageContext();	
	return scaledImage;	
}

+ (UIImage *)scaleImage:(UIImage *)image setWidth:(float)width setHeight:(float)height {
	if(image==nil){
		return nil;
	}
	if(width<=0){
		width = image.size.width;
	}
	if(height<=0){
		height = image.size.height;
	}
	UIGraphicsBeginImageContext(CGSizeMake(width, height));
	[image drawInRect:CGRectMake(0, 0, width, height)];
	UIImage *scaledImage = UIGraphicsGetImageFromCurrentImageContext();
	UIGraphicsEndImageContext();
	return scaledImage;	
}

+ (UIImage *)scaleImage:(UIImage *)image toSizeMake:(CGSize)sizeMake {
	if(image==nil){
		return nil;
	}	
	UIGraphicsBeginImageContext(sizeMake);
	[image drawInRect:CGRectMake(0, 0, sizeMake.width, sizeMake.height)];
	UIImage *scaledImage = UIGraphicsGetImageFromCurrentImageContext();
	UIGraphicsEndImageContext();	
	return scaledImage;	
}


+(UIImage *)createImageWithColor:(UIColor *)color{
    CGRect rect=CGRectMake(0.0f, 0.0f, 320.0f, 80.0f);
    UIGraphicsBeginImageContext(rect.size);
    CGContextRef context=UIGraphicsGetCurrentContext();
    CGContextSetFillColorWithColor(context, [color CGColor]);
    CGContextFillRect(context, rect);
    UIImage *theImage=UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return  theImage;
}
@end
