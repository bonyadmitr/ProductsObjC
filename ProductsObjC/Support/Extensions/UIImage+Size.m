//
//  UIImage+Size.m
//  ProductsObjC
//
//  Created by Bondar Yaroslav on 01/07/2017.
//  Copyright © 2017 Bondar Yaroslav. All rights reserved.
//

#import "UIImage+Size.h"

@implementation UIImage (Size)

- (UIImage *)imageWithSize:(CGSize)size {
    UIGraphicsBeginImageContext(size);
    [self drawInRect:CGRectMake(0, 0, size.width, size.height)];
    UIImage *destImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return destImage;
}

@end
