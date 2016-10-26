//
//  PFLanguageTool.h
//  localstring_demo
//
//  Created by peng on 16/10/19.
//  Copyright © 2016年 peng. All rights reserved.
//

#import <Foundation/Foundation.h>
#define AnnetStr(key,...) [[PFLanguageTool shareInstance] locatizedStringForkey:(key) comment:nil]
#define LanguageBundle [PFLanguageTool shareInstance].languageBundle
@interface PFLanguageTool : NSObject
@property (nonatomic,strong,readonly)NSBundle * languageBundle;

+(instancetype)shareInstance;
-(void)initLanguage;
-(void)setLanguage:(NSString *)languageStr;
-(NSString*)locatizedStringForkey:(NSString*)key comment:(NSString*)comment;
@end
