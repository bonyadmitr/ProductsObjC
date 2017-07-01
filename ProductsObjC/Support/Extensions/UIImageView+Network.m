//
//  UIImageView+Network.m
//  ProductsObjC
//
//  Created by Bondar Yaroslav on 30/06/2017.
//  Copyright © 2017 Bondar Yaroslav. All rights reserved.
//

#import "UIImageView+Network.h"
#import "CacheManager.h"
#import <objc/runtime.h>
#import "UIImage+Size.h"

@implementation UIImageView (Network)

- (void)loadImageFromStringURL:(NSString *)stringUrl {
    
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_HIGH, 0), ^{
        
        NSURL *url = [NSURL URLWithString:stringUrl];
        NSString *key = url.absoluteString;
        
        [CacheManager.sharedInstance objectForKey:key complitionHandler:^(NSData *cachedData) {
            if (cachedData) {
                UIImage *loadedImage = [UIImage imageWithData:cachedData];
//                UIImage *resizedImage = [loadedImage imageWithSize: self.bounds.size];
                dispatch_sync(dispatch_get_main_queue(), ^{
                    self.image = loadedImage;
                    [self setNeedsLayout];
                });
                return;
            }
            
            NSData *data = [NSData dataWithContentsOfURL:url];
            if (!data) {
                return;
            }
            UIImage *imageFromData = [UIImage imageWithData:data];
//            UIImage *resizedImage = [imageFromData imageWithSize: self.bounds.size];
            
            [CacheManager.sharedInstance setObject:data forKey:key];
            
            if (imageFromData) {
                dispatch_sync(dispatch_get_main_queue(), ^{
                    self.image = imageFromData;
                    [self setNeedsLayout];
                });
            }
        }];

    });
}

@end
