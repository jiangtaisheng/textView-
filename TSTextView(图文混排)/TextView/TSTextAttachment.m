//
//  TSTextAttachment.m
//  TSTextView(图文混排)
//
//  Created by apple2015 on 16/7/21.
//  Copyright © 2016年 apple2015. All rights reserved.
//

#import "TSTextAttachment.h"

@implementation TSTextAttachment

- (CGRect)attachmentBoundsForTextContainer:(NSTextContainer *)textContainer proposedLineFragment:(CGRect)lineFrag glyphPosition:(CGPoint)position characterIndex:(NSUInteger)charIndex
{
    if ((int)self.imgSize.width > 0) {
        return CGRectMake(0, -5, self.imgSize.width, self.imgSize.height);
    }
    return CGRectMake(0, -5, 30, 30);
}

//-(UIImage *)imageForBounds:(CGRect)imageBounds textContainer:(NSTextContainer *)textContainer characterIndex:(NSUInteger)charIndex
//{
//
//
//
//
//}
@end
