//
//  TSTextView.m
//  TSTextView(图文混排)
//
//  Created by apple2015 on 16/7/21.
//  Copyright © 2016年 apple2015. All rights reserved.
//

#import "TSTextView.h"
#import "TSTextAttachment.h"
#import "TSTextViewHelper.h"
#import "Header.h"
#import "UIImageView+WebCache.h"

@implementation TSTextView
{
  
    TSTextViewHelper * helper;

}
- (instancetype)initWithFrame:(CGRect)frame
{

    if (self=[super initWithFrame:frame]) {
        
        helper=[TSTextViewHelper sharedTSTextViewHelper];
//        self.scrollEnabled=NO;
        self.editable=NO;
    }

    return self;
}


- (void)setTextString:(NSString *)string
{

    NSDictionary * attrDic=[NSDictionary dictionaryWithObjectsAndKeys:[UIFont systemFontOfSize:15],NSFontAttributeName, [UIColor blackColor],NSForegroundColorAttributeName,nil];
    NSMutableAttributedString  * attributedString=[[NSMutableAttributedString alloc]initWithString:string attributes:attrDic];

    NSMutableParagraphStyle   *paragraphStyle=[[NSMutableParagraphStyle alloc]init];
    paragraphStyle.lineSpacing=10.0;
    paragraphStyle.paragraphSpacing=20.0;
    paragraphStyle.lineBreakMode=NSLineBreakByCharWrapping;
    [attributedString addAttribute:NSParagraphStyleAttributeName value:paragraphStyle range:NSMakeRange(0, string.length)];
    
      NSArray * keyArray=[TSTextViewHelper getKeyofString:string];
    
    for ( NSString * str in keyArray) {
         TSTextAttachment  *texttAttachment=[[TSTextAttachment alloc]init];
        if([str isEqualToString:@"[图]"]){
        NSURL * urls=[NSURL URLWithString:@"http://img.xunbao178.com/download/appavatar/20160506/o_2200472634_1382105_j1v6e9_100_100.jpg"];
            UIImageView * imageView=[[UIImageView alloc]initWithFrame:CGRectMake(0, 0, 0, 0)];
            [self addSubview:imageView];

            texttAttachment.imgSize=CGSizeMake(200, 200);
            
            [imageView sd_setImageWithURL:urls completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
                
                texttAttachment.image=image;
                NSRange  range=[attributedString.string rangeOfString:str options:NSCaseInsensitiveSearch range:NSMakeRange(0, attributedString.string.length)];
                NSAttributedString * attr=[NSAttributedString attributedStringWithAttachment:texttAttachment] ;
                [attributedString replaceCharactersInRange:range withAttributedString:attr];
                
                [attributedString addAttribute:NSLinkAttributeName value:@"https://www.baidu.com" range:NSMakeRange(range.location, 1)];
                self.attributedText=attributedString;

            }];

        }else{
        
            NSInteger index=[helper.keyArr indexOfObject:str];
            NSString * valueString=[helper.valueArr objectAtIndex:index];
            texttAttachment.image=[UIImage imageNamed:valueString];
            texttAttachment.imgSize=CGSizeMake(36, 20);
            NSRange  range=[attributedString.string rangeOfString:str options:NSCaseInsensitiveSearch range:NSMakeRange(0, attributedString.string.length)];
            NSAttributedString * attr=[NSAttributedString attributedStringWithAttachment:texttAttachment] ;
            [attributedString replaceCharactersInRange:range withAttributedString:attr];
            
            [attributedString addAttribute:NSLinkAttributeName value:@"https://www.baidu.com" range:NSMakeRange(range.location, 1)];
        }
            
        

    }


    NSArray * linkArr=helper.linkArr;
    
    for (NSString * str in linkArr) {
        if ([attributedString.string hasSuffix:str]) {
            NSRange range = [attributedString.string rangeOfString:str];

            [attributedString addAttribute:NSLinkAttributeName value:@"https://www.baidu.com" range:range];
        }
    }
    
    NSArray * urlArray=[helper getLinkRangeOfString:attributedString.string];
    
    for (int i=0; i<urlArray.count; i++) {
        NSRange  range= [urlArray[i] rangeValue];
        NSString * url=[attributedString.string substringWithRange:range];
        [attributedString addAttribute:NSLinkAttributeName value:url range:range];
        [attributedString addAttributes:@{NSForegroundColorAttributeName:[UIColor blueColor],NSUnderlineStyleAttributeName:@"1",NSUnderlineColorAttributeName:[UIColor blueColor]} range:range];

       
    }
    
    
    NSDictionary *linkAttributes =
    @{NSForegroundColorAttributeName:[UIColor blueColor], NSUnderlineColorAttributeName:[UIColor lightGrayColor], NSUnderlineStyleAttributeName:@(NSUnderlinePatternSolid)};
    self.linkTextAttributes=linkAttributes;

    
    self.attributedText=attributedString;

    
    
    

}
/**
 *  http://img.xunbao178.com/download/appavatar/20160506/o_2200472634_1382105_j1v6e9_100_100.jpg

 http://wx.qlogo.cn/mmopen/BY993EzmNia8nehDlfWmscl3DdRkiblxohac24CxuAeuMRcKWqku67Bs5cNqDQ9OJxPPMy2l2QxQfIy2RSFyd07bQUWsqZwJKg/o

 
 */



@end
