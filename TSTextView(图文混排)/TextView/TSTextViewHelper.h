//
//  TSTextViewHelper.h
//  TSTextView(图文混排)
//
//  Created by apple2015 on 16/7/21.
//  Copyright © 2016年 apple2015. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface TSTextViewHelper : NSObject

@property(nonatomic,strong)NSMutableArray * keyArr;
@property(nonatomic,strong)NSMutableArray * valueArr;
@property(nonatomic,strong)NSArray * linkArr;
+ (NSArray * )getKeyofString:(NSString *)string;
- (NSArray *)getLinkRangeOfString:(NSString *)string;

+(TSTextViewHelper *)sharedTSTextViewHelper;
@end
