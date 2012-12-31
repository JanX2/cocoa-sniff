//
//  ALGUtilities.h
//  OHI
//
//  Created by Alexis Gallagher on 2011-12-29.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ALGUtilities : NSObject

// encoding
+(NSDictionary*)dictionaryWithNSStringEncodingNamesAndValues;
+(NSStringEncoding)encodingForIANACharSetName:(NSString*)theIANAName;
+(NSString*)nameOfEncoding:(NSStringEncoding) encoding;
+(NSString*)stringWithContentsOfFile:(NSString*)filepath
              tryingIANACharSetNames:(NSArray*)theIANACharSetNames;
+(BOOL) fileIsUTF8Encoded:(NSString*)theFilepath;

@end
