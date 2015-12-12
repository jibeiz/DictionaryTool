//
//  ECdictionary.m
//  DictionaryTool
//
//  Created by 苏余昕龙 on 15/12/12.
//  Copyright © 2015年 DevSu. All rights reserved.
//

#import "ECdictionary.h"

@implementation ECdictionary



//静态字典变量，存放中英文参考
static NSDictionary * dictTrans = nil;

//加载字典
+ (void)loadDictRef {
    //字典已经加载了，就不要重新操作，直接返回
    if (dictTrans != nil) {
        return;
    }
    //读取资源txt文件
    NSString * txtForDictPath = [[NSBundle mainBundle] pathForResource:@"dict" ofType:@"txt"];
    NSString * txtDict = [NSString stringWithContentsOfFile:txtForDictPath encoding:NSUTF8StringEncoding error:nil];
    //临时存储字典数据
    NSMutableDictionary * tempDict = [[NSMutableDictionary alloc] init];
    //以＃分开
    NSArray * arrJSplit = [txtDict componentsSeparatedByString:@"#"];
    for (int i = 0; i < arrJSplit.count; i++) {
        if (![[arrJSplit objectAtIndex:i] isEqualToString:@""]) {
            //以Trans:分割
            NSArray * arrTransSplit = [[arrJSplit objectAtIndex:i] componentsSeparatedByString:@"Trans:"];
            if (arrTransSplit.count == 2) {
                //  key: 英文   value:中文
                [tempDict setValue:[[arrTransSplit objectAtIndex:1] stringByReplacingOccurrencesOfString:@"\n" withString:@""] forKey:[[arrTransSplit objectAtIndex:0] stringByReplacingOccurrencesOfString:@"\n" withString:@""]];
            }
        }
    }
    //从临时字典中获取数据
    dictTrans = [NSDictionary dictionaryWithDictionary:tempDict];
}

//英文翻译成中文
+ (NSString *)ENGTransToCHN:(NSString *)enStr {
    //先加载字典
    [ECdictionary loadDictRef];
    //直接以key获取返回值对应的中文释义(lowercaseString：字符串小写字母的转换)
    return [dictTrans objectForKey:[enStr lowercaseString]];
}

+(NSString *)CHNTransToENG:(NSString *)chnStr {
    //先加载字典
    [ECdictionary loadDictRef];
//    存放查询后的英文，以分号分割
    NSMutableString * strResult = [[NSMutableString alloc] init];
    //获取所有中文
    NSArray * arrCHN = [dictTrans allValues];
    //获取所有英文
    NSArray * arrEN = [dictTrans allKeys];
    for (int i = 0; i < arrCHN.count; i++) {
        if ([[arrCHN objectAtIndex:i] containsString:chnStr]) {
            [strResult appendFormat:@"%@: ",[arrEN objectAtIndex:i]];
        }
    }
    return strResult;
}
@end
