//
//  ECdictionary.h
//  DictionaryTool
//
//  Created by 苏余昕龙 on 15/12/12.
//  Copyright © 2015年 DevSu. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ECdictionary : NSObject
// 创建一个类方法来把字典封装了

//英文翻译成中文
+ (NSString *)ENGTransToCHN:(NSString *)enStr;

//中文翻译成英文
+ (NSString *)CHNTransToENG:(NSString *)chnStr;

@end
