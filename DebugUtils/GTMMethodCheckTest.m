//
//  GTMMethodCheckTest.m
//  Copyright 2006-2008 Google Inc.
//
//  Licensed under the Apache License, Version 2.0 (the "License"); you may not
//  use this file except in compliance with the License.  You may obtain a copy
//  of the License at
// 
//  http://www.apache.org/licenses/LICENSE-2.0
// 
//  Unless required by applicable law or agreed to in writing, software
//  distributed under the License is distributed on an "AS IS" BASIS, WITHOUT
//  WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.  See the
//  License for the specific language governing permissions and limitations under
//  the License.
//

#import "GTMSenTestCase.h"
#import "GTMMethodCheck.h"

static BOOL gTestCheckVar = NO;

// This is a contrived class that doesn't inherit from NSObject, but does
// implement some of it's functionality to force test a case in 
// GTMMethodCheck.
@interface GTMClassThatDoesntInheritFromNSObject
+ (BOOL)instancesRespondToSelector:(SEL)selector;
+ (BOOL)respondsToSelector:(SEL)selector;
@end

@implementation GTMClassThatDoesntInheritFromNSObject
GTM_METHOD_CHECK(GTMClassThatDoesntInheritFromNSObject, GTMMethodCheckTestMethod);
- (void)GTMMethodCheckTestMethod {
}
+ (BOOL)instancesRespondToSelector:(SEL)selector {
  return YES;
}

+ (BOOL)respondsToSelector:(SEL)selector {
  return YES;
}
@end

@interface GTMMethodCheckTest : SenTestCase
@end

@implementation GTMMethodCheckTest
GTM_METHOD_CHECK(GTMMethodCheckTest, GTMMethodCheckTestMethod);
GTM_METHOD_CHECK(GTMMethodCheckTest, GTMMethodCheckTestClassMethod);

- (void)GTMMethodCheckTestMethod {
}

+ (void)GTMMethodCheckTestClassMethod {
}

+ (void)xxGTMMethodCheckMethodTestCheck {
  // This gets called because of its special name by GMMethodCheck
  // Look at the Macros in GMMethodCheck.h for details.
  gTestCheckVar = YES;
}

- (void)testGTMMethodCheck {
#ifdef DEBUG
  // GTMMethodCheck only runs in debug
  STAssertTrue(gTestCheckVar, @"Should be true");
#endif
}
@end
