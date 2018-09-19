//
//  MyGifImage.h
//  LzyHelper
//
//  Created by Lzy on 2017/11/11.
//  Copyright © 2017年 Lzy. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MyGifImage : UIImage

/**
 A C array containing the frame durations.

 The number of frames is defined by the count of the `images` array property.
 */
@property (nonatomic, readonly) NSTimeInterval *frameDurations;

/**
 Total duration of the animated image.
 */
@property (nonatomic, readonly) NSTimeInterval totalDuration;

/**
 Number of loops the image can do before it stops
 */
@property (nonatomic, readonly) NSUInteger loopCount;

- (UIImage*)getFrameWithIndex:(NSUInteger)idx;
@end
