//
//  PFLanguageTool.m
//  localstring_demo
//
//  Created by peng on 16/10/19.
//  Copyright © 2016年 peng. All rights reserved.
//

#import "PFLanguageTool.h"
@interface PFLanguageTool()
@end
@implementation PFLanguageTool
@synthesize languageBundle = _languageBundle;

+(instancetype)shareInstance{
    static PFLanguageTool * tool = nil;
    static  dispatch_once_t token;
    dispatch_once(&token, ^{
        tool = [[PFLanguageTool alloc]init];
    });
    return tool;
}
-(void)initLanguage{
    /**
     原理是切换语言@"AppleLanguages"设置后调用相应的NSBundle
     */
    NSBundle* lanBundle = nil;
    NSArray* languages = [[NSUserDefaults standardUserDefaults] valueForKey:@"AppleLanguages"];
    NSLog(@"%@",languages);
    if ([languages isKindOfClass:[NSArray class]]) {
        NSString * lanStr = languages[0];
        NSString * lanBunPath = nil;
        //系统不同有时会带有相应的后缀如 "zh-Hans-JP","en-JP",
        if ([lanStr containsString:@"zh-Hans"]) {
            lanBunPath = [[NSBundle mainBundle] pathForResource:@"zh-Hans" ofType:@"lproj"];
        }else if ([lanStr containsString:@"en"]){
            lanBunPath = [[NSBundle mainBundle] pathForResource:@"en" ofType:@"lproj"];
        }
        lanBundle = [NSBundle bundleWithPath:lanBunPath];
    }
    if (lanBundle == nil) {
        lanBundle = [NSBundle mainBundle];
    }
    _languageBundle = lanBundle;
}
-(void)setLanguage:(NSString *)languageStr{
    if (!languageStr) {
        return;
    }
    [[NSUserDefaults standardUserDefaults] setValue:@[languageStr] forKey:@"AppleLanguages"];
    NSString * lanBunPath = [[NSBundle mainBundle] pathForResource:languageStr ofType:@"lproj"];
    [[NSUserDefaults standardUserDefaults] synchronize];

    NSBundle* lanBundle = [NSBundle bundleWithPath:lanBunPath];
    if (lanBundle) {
        _languageBundle = lanBundle;
    }
}
-(NSBundle *)languageBundle{
    if (!_languageBundle) {
        _languageBundle = [NSBundle mainBundle];
    }
    return _languageBundle;
}
-(NSString*)locatizedStringForkey:(NSString*)key comment:(NSString*)comment{
    return NSLocalizedStringFromTableInBundle(key, nil,self.languageBundle, comment);
    
}
@end
