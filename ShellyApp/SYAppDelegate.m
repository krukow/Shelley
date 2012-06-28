//
//  SYAppDelegate.m
//  ShellyApp
//
//  Created by Karl Krukow on 21/06/12.
//  Copyright (c) 2012 Trifork. All rights reserved.
//

#import "SYAppDelegate.h"
#import "Shelley.h"


@implementation SYAppDelegate

@synthesize window = _window;

- (void)dealloc
{
    [_window release];
    [super dealloc];
}

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    self.window = [[[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]] autorelease];
    // Override point for customization after application launch.
    UIViewController *vc = [[[UIViewController alloc]initWithNibName:@"view" bundle:nil] autorelease];
    
    
    self.window.rootViewController = vc;
    [self.window makeKeyAndVisible];
    
    UIWebView *webView = (UIWebView*)[vc.view viewWithTag:1];
    [self performSelector:@selector(performQueriesOnWebView:) withObject:vc.view afterDelay:5];

    [webView loadHTMLString:@"<html><head><title>Google</title></head>\
     <style>.menu {position: absolute; left:0;top:0} .menu ul {position: absolute; left:50px; top:100px}\
     a {position:absolute; left:100px}\
     </style>\
     <body><h1>Google header</h1>\
     <div class='menu'><span class='heading'>Heading</span></div>\
     A\
     <ul>\
     <li>one\
     <li>two\
     <li>one\
     <li>two\
     <li>one\
     <li>two\
     <li>one\
     <li>two\
     <li>one\
     <li>two\
     <li>one\
     <li>two\
     <li>one\
     <li>two\
     <li>one\
     <li>two\
     <li>one\
     <li>two\
     <li>one\
     <li style='display:none'>ten\
     <li><a href='http://www.googl.com'>link</a>\
     <li>Googles phase\
     </ul></body>" 
     
                 baseURL:[NSURL URLWithString:@"http://localhost:8080"]];

    return YES;
}

-(void)performQueriesOnWebView:(UIView*)view
{
    
    Shelley *sh = [[Shelley alloc] initWithSelectorString:@"webView css:'a'"];
    NSArray *arr = [sh selectFrom:view];
    
    NSLog(@"%@",arr);
    
}

- (void)applicationWillResignActive:(UIApplication *)application
{
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application
{
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later. 
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application
{
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application
{
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application
{
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

@end
