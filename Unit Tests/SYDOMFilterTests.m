//
//  SYDOMFilterTests.m
//  Shelley
//
//  Created by Karl Krukow on 21/06/12.
//  Copyright (c) 2012 LessPainful. All rights reserved.
//

#import "SYDOMFilterTests.h"
#import "SYDOMFilter.h"

@implementation SYDOMFilterTests

- (void)testCSSQuery {
    UIWebView *view = [[UIWebView new] autorelease];
    [view loadHTMLString:@"<html><head><title>Google</title></head>\
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

    
    SYDOMFilter *domFilter = [[[SYDOMFilter alloc] initWithType:@"css" query:@"li"] autorelease];
    
    NSArray *filteredViews = [domFilter applyToView:view];
    //TODO doesn't seem to work in unit test
    NSLog(@"DOM: %@",filteredViews);
}
@end
