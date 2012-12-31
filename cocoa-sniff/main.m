//
//  main.m
//  cocoa-encoding
//
//  Created by Alexis Gallagher on 2012-03-02.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "PSLog.h"
#import "ALGUtilities.h"

void PrintSupportedEncodings(void);
void PrintNSString(NSString * s);
void PrintLnNSString(NSString * s);


void PrintNSString(NSString * s)
{
  printf("%s",[s UTF8String]);
}
void PrintLnNSString(NSString * s)
{
  printf("%s\n",[s UTF8String]);
}


void PrintSupportedEncodings()
{
  PrintLnNSString(@"IANA_CharSetName\t\tNSSttringEncoding\\ttvalue");
  NSDictionary * namesAndValues = [ALGUtilities dictionaryWithNSStringEncodingNamesAndValues];
  [namesAndValues enumerateKeysAndObjectsUsingBlock:^(id encodingName, id encodingValue, BOOL *stop) {
    NSStringEncoding encoding = [encodingValue unsignedIntegerValue];
    NSString * IANAname = [ALGUtilities nameOfEncoding:encoding];
    
    PrintLnNSString([NSString stringWithFormat:@"%@\t\t%@\t\t%@",IANAname,encodingName,encodingValue]);
  }];
  
}


int main (int argc, const char * argv[])
{
  @autoreleasepool {
    
    if (argc != 2) {
      PrintLnNSString(@"usage: cocoa-sniff [filename]");
      PrintLnNSString(@"usage: cocoa-sniff --list");
      exit(1);
    }
    
    NSString * arg = [NSString stringWithCString:argv[1] encoding:NSASCIIStringEncoding];
    if ([arg isEqualToString:@"--list"]) {
      PrintSupportedEncodings();
    }
    else {
      // try utf-8, then windows-1252, then macintosh.
      /**
       Not clear if it is ever the case that windows-1252 fails where macintosh succeeds.
       Unfortunately, successfully reading a file with a specified encoding does not
       mean that was the correct encoding.
       
       */
      NSString * fileData = [ALGUtilities stringWithContentsOfFile:arg
                                            tryingIANACharSetNames:
                             [NSArray arrayWithObjects:@"utf-8",@"windows-1252",@"macintosh",@"",nil]];
      
//      NSLog(@"file's contents=%@",fileData);
    }
  }
  return 0;
}

