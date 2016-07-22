//
//  TSTextViewHelper.m
//  TSTextView(图文混排)
//
//  Created by apple2015 on 16/7/21.
//  Copyright © 2016年 apple2015. All rights reserved.
//

#import "TSTextViewHelper.h"
#import "Header.h"

@implementation TSTextViewHelper

SYNTHESIZE_SINGLETON_FOR_CLASS(TSTextViewHelper)

-(instancetype)init
{

    if (self=[super init]) {
        NSArray *addArr = @[@{@"[发帖]": @"icon_style_1"}, @{@"[报名]": @"icon_style_2"}, @{@"[健身]": @"icon_style_3"}, @{@"[领水]": @"icon_style_4"}, @{@"[约战]": @"icon_style_5"}, @{@"[置顶]": @"icon_style_6"},@{@"[图]": @"icon_style_7"}];
        _keyArr=[[NSMutableArray alloc]initWithCapacity:0];
        _valueArr=[[NSMutableArray alloc]initWithCapacity:0];
        
        for (NSDictionary * dic in addArr) {
            
            [_keyArr addObject:[dic allKeys][0]];
            [_valueArr addObject:[dic allValues][0]];
        }

        _linkArr=@[@" 围观一下"];
    }

    return self;

}


+ (NSArray * )getKeyofString:(NSString *)string
{
    NSMutableArray * keyArry=[NSMutableArray arrayWithCapacity:0];
    TSTextViewHelper * helper=[TSTextViewHelper sharedTSTextViewHelper];
    NSArray * array=[string componentsSeparatedByString:@"["];
    for (int i=0; i<array.count; i++) {
        NSString * str=array[i];
        NSArray * arr=[str componentsSeparatedByString:@"]"];
        for (int j=0; j<arr.count-1; j++) {
            NSString * key=[NSString stringWithFormat:@"[%@]",arr[j]];
            if ([helper.keyArr containsObject:key]) {
                
                [keyArry addObject:key];
                
            }
            
        }
        
    }
  
    return keyArry;

}


- (NSArray *)getLinkRangeOfString:(NSString *)string
{
    
    NSMutableArray * array=[NSMutableArray arrayWithCapacity:0];
    //适用于任何网址
    NSString *regulaStr = @"((http[s]{0,1}|ftp)://[a-zA-Z0-9\\.\\-]+\\.([a-zA-Z]{2,3})(:\\d+)?(/[a-zA-Z0-9\\.\\-~!@#$%^&*+?:_/=<>]*)?)|(www.[a-zA-Z0-9\\.\\-]+\\.([a-zA-Z]{2,3})(:\\d+)?(/[a-zA-Z0-9\\.\\-~!@#$%^&*+?:_/=<>]*)?)";

    NSRegularExpression *regex = [NSRegularExpression regularExpressionWithPattern:regulaStr options:NSRegularExpressionCaseInsensitive error:nil];
    NSArray *result = [regex matchesInString:string options:NSMatchingReportProgress range:NSMakeRange(0, string.length)];
    for (NSTextCheckingResult * textCheckingResult in result) {
        
        [array addObject: [NSValue valueWithRange:textCheckingResult.range] ];
        
    }
    

    return array;
}

@end
