//
//  ViewController.m
//  国际化_demo
//
//  Created by peng on 16/10/17.
//  Copyright © 2016年 peng. All rights reserved.
//

#import "ViewController.h"
#import "AppDelegate.h"
#import "PFLanguageTool.h"
@interface ViewController ()
@property (weak, nonatomic) IBOutlet UILabel *hello;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    NSString * str  = AnnetStr(@"hello",@"ddd");
    self.hello.text = str;// [[PFLanguageTool shareInstance] locatizedStringForkey:@"hello" comment:nil];
    // Do any additional setup after loading the view, typically from a nib.
  
    NSString * path = [[PFLanguageTool shareInstance].languageBundle pathForResource:@"lantext" ofType:@"plist"];
    NSDictionary* dic = [NSDictionary dictionaryWithContentsOfFile:path];
    if ([dic[@"people"] isKindOfClass:[NSString class]]) {
        NSLog(@"%@",dic[@"people"]);
    }
}

- (IBAction)changeLanguages:(UIButton*)sender {
    id languages = [[NSUserDefaults standardUserDefaults] valueForKey:@"AppleLanguages"];
    NSLog(@"%@",languages);
    NSString * lanStr = languages[0];
    if ([lanStr isEqualToString:@"en"]) {
        [[PFLanguageTool shareInstance] setLanguage:@"zh-Hans"];
    }else{
        [[PFLanguageTool shareInstance] setLanguage:@"en"];
    }
    ViewController * controller  = [[UIStoryboard storyboardWithName:@"Main" bundle:[PFLanguageTool shareInstance].languageBundle]instantiateViewControllerWithIdentifier:@"vvvv"];
    UIWindow * window = [UIApplication sharedApplication].keyWindow;
    window.rootViewController = controller;
    [window makeKeyAndVisible];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
