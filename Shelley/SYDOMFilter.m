//
//  SYDOMFilter.m
//  Shelley
//
//  Created by Karl Krukow on 21/06/12.
//  Copyright (c) 2012 LessPainful. All rights reserved.
//

#import "SYDOMFilter.h"
#import "LPWebQuery.h"

@implementation SYDOMFilter

@synthesize type=_type;
@synthesize query=_query;


-(id)initWithType:(NSString *)type query:(NSString *)query
{
    self = [super init];
    if (self) 
    {
        if ([@"css" isEqualToString:type])
        {
            _type = LPWebQueryTypeCSS; 
        }
        else if ([@"xpath" isEqualToString:type])
        {
            _type = LPWebQueryTypeXPATH;            
        }
        else if ([@"webtext" isEqualToString:type])
        {
            _type = LPWebQueryTypeFreeText;
        }
        _query = [query copy];
    }
    return self;   
}

-(NSArray *)applyToView:(UIView *)view{
    if (![view isKindOfClass:[UIWebView class]])
    {
        return [NSArray array];
    }
    UIWebView *webView = (UIWebView *)view;
    
    return [LPWebQuery evaluateQuery:self.query ofType:self.type inWebView:webView];
}

@end
