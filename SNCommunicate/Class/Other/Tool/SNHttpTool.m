//
//  SNHttpTool.m
//  SNCommunicate
//
//  Created by ZhuiYi on 15/4/14.
//  Copyright (c) 2015年 ZhuiYi. All rights reserved.
//

#import "SNHttpTool.h"
#import "AFNetworking.h"

#define HTTP @"http://123.57.206.151/"
#define SOAPAction @"http://123.57.206.151/"

static SNHttpTool *sharedInstance = nil;

@interface SNHttpTool ()<NSXMLParserDelegate>

@property (nonatomic, strong) NSMutableArray *videoList;
@property (nonatomic, strong) NSMutableString *nodeString;
@property (nonatomic, strong) NSString *IPAddress;
@property (nonatomic, strong) AFHTTPRequestOperation *operation;
@property (nonatomic, strong) id result;

@end

@implementation SNHttpTool

+ (SNHttpTool *)sharedInstance
{
    @synchronized(self){
        if (sharedInstance == nil) {
            sharedInstance = [[[self class] alloc] init];
        }
        return sharedInstance;
    }
}

+ (id)allocWithZone:(NSZone *)zone
{
    @synchronized(self){
        if (sharedInstance == nil) {
            sharedInstance = [super allocWithZone:zone];
        }
        return sharedInstance;
    }
}

+ (id)copyWithZone:(NSZone *)zone
{
    return sharedInstance;
}

/**
 *  根据级别返回商家信息
 *
 *  @param level   商家级别
 *  @param success 成功回掉
 *  @param failure 失败回掉
 */
+ (void)getLevelOfBusinessWithLevel:(NSString *)level
                             finish:(void (^)(id responseObject))success
                              error:(void (^)(NSError *error))failure
{
    NSString *soapMessage =
    [NSString stringWithFormat:
     @"<?xml version=\"1.0\" encoding=\"utf-8\"?>"
     "<soap:Envelope xmlns:xsi=\"http://www.w3.org/2001/XMLSchema-instance\" xmlns:xsd=\"http://www.w3.org/2001/XMLSchema\" xmlns:soap=\"http://schemas.xmlsoap.org/soap/envelope/\">"
     "<soap:Body>"
     "<getLevelOfBusiness xmlns=\"http://123.57.206.151/\">"
     "<Level>%@</Level>"
     "</getLevelOfBusiness>"
     "</soap:Body>"
     "</soap:Envelope>"
     , level];
    
    [[self sharedInstance] sendPOSTRequestWithSoapMessage:soapMessage
                                                   andURL:@"WSGetLevel.asmx"
                                            andSoapAction:@"getLevelOfBusiness"
                                                   finish:(void (^)(id responseObject))success
                                                    error:(void (^)(NSError *error))failure];
}

/**
 *  获取商家列表
 *
 *  @param type             商家类型
 *  @param startIndex       最大值,下拉加载
 *  @param pageSize         最小值,上啦刷新
 *  @param success          成功回掉
 *  @param failure          失败回掉
 */
+ (void)getBusinessWithType:(NSString *)type
                 startIndex:(NSInteger)startIndex
                   pageSize:(NSInteger)pageSize
                     finish:(void (^)(id responseObject))success
                      error:(void (^)(NSError *error))failure
{
    NSString *soapMessage =
    [NSString stringWithFormat:
     @"<?xml version=\"1.0\" encoding=\"utf-8\"?>"
     "<soap:Envelope xmlns:xsi=\"http://www.w3.org/2001/XMLSchema-instance\" xmlns:xsd=\"http://www.w3.org/2001/XMLSchema\" xmlns:soap=\"http://schemas.xmlsoap.org/soap/envelope/\">"
     "<soap:Body>"
     "<getTypeOfBusiness xmlns=\"http://123.57.206.151/\">"
     "<Type>%@</Type>"
     "<startIndex>%zd</startIndex>"
     "<pageSize>%zd</pageSize>"
     "</getTypeOfBusiness>"
     "</soap:Body>"
     "</soap:Envelope>"
     , type, startIndex, pageSize];
    [[self sharedInstance] sendPOSTRequestWithSoapMessage:soapMessage
                                                   andURL:@"WSTypeOfBusiness.asmx"
                                            andSoapAction:@"getTypeOfBusiness"
                                                   finish:(void (^)(id responseObject))success
                                                    error:(void (^)(NSError *error))failure];
}

/**
 *  未登录状态下获得商家的详细信息
 *
 *  @param shangID 商家ID
 *  @param Type    商家类型
 *  @param big     最大值,下拉加载
 *  @param small   最小值,上啦刷新
 *  @param success 成功回调
 *  @param failure 失败回调
 */
+ (void)getShangInfoNoIdentityWithShangID:(NSString *)shangID
                                  andType:(NSString *)Type
                                      Big:(NSInteger)big
                                    Small:(NSInteger)small
                                   finish:(void (^)(id responseObject))success
                                    error:(void (^)(NSError *error))failure
{
    NSString *soapMessage =
    [NSString stringWithFormat:
     @"<?xml version=\"1.0\" encoding=\"utf-8\"?>"
     "<soap:Envelope xmlns:xsi=\"http://www.w3.org/2001/XMLSchema-instance\" xmlns:xsd=\"http://www.w3.org/2001/XMLSchema\" xmlns:soap=\"http://schemas.xmlsoap.org/soap/envelope/\">"
     "<soap:Body>"
     "<getShangInfoNoIdentity xmlns=\"http://123.57.206.151/\">"
     "<shangID>%@</shangID>"
     "<Type>%@</Type>"
     "<big>%zd</big>"
     "<small>%zd</small>"
     "</getShangInfoNoIdentity>"
     "</soap:Body>"
     "</soap:Envelope>"
     , shangID, Type, big, small];
    
    
    [[self sharedInstance] sendPOSTRequestWithSoapMessage:soapMessage
                                                   andURL:@"WSGetShangInfo.asmx"
                                            andSoapAction:@"getShangInfoNoIdentity"
                                                   finish:(void (^)(id responseObject))success
                                                    error:(void (^)(NSError *error))failure];
}

/**
 *  登录顾客获取商品详情
 *
 *  @param shangID     商品ID
 *  @param Type        类型
 *  @param phoneNumber 电话号码
 *  @param passWord    密码
 *  @param big         最大值,下拉加载
 *  @param small       最小值,上啦刷新
 *  @param success     成功回调
 *  @param failure     失败回调
 */
+ (void)getShangInfoByIdentityWithShangID:(NSString *)shangID
                                  andType:(NSString *)Type
                              phoneNumber:(NSString *)phoneNumber
                                 passWord:(NSString *)passWord
                                      Big:(NSInteger)big
                                    Small:(NSInteger)small
                                   finish:(void (^)(id responseObject))success
                                    error:(void (^)(NSError *error))failure
{
    NSString *soapMessage =
    [NSString stringWithFormat:
     @"<?xml version=\"1.0\" encoding=\"utf-8\"?>"
     "<soap:Envelope xmlns:xsi=\"http://www.w3.org/2001/XMLSchema-instance\" xmlns:xsd=\"http://www.w3.org/2001/XMLSchema\" xmlns:soap=\"http://schemas.xmlsoap.org/soap/envelope/\">"
     "<soap:Body>"
     "<getShangInfoByIdentity xmlns=\"http://123.57.206.151/\">"
     "<shangID>%@</shangID>"
     "<Type>%@</Type>"
     "<IP>%@</IP>"
     "<TEL>%@</TEL>"
     "<PWD>%@</PWD>"
     "<big>%zd</big>"
     "<small>%zd</small>"
     "</getShangInfoByIdentity>"
     "</soap:Body>"
     "</soap:Envelope>"
     , shangID, Type, [self sharedInstance].IPAddress, phoneNumber, passWord, big, small];
    
    [[self sharedInstance] sendPOSTRequestWithSoapMessage:soapMessage
                                                   andURL:@"WSGetShangInfo.asmx"
                                            andSoapAction:@"getShangInfoByIdentity"
                                                   finish:(void (^)(id responseObject))success
                                                    error:(void (^)(NSError *error))failure];
}

/**
 *  添加订单
 *
 *  @param shangID     商品ID
 *  @param phoneNumber 电话号码
 *  @param passWord    密码
 *  @param count       数量
 *  @param productID   产品ID
 *  @param success     成功回调
 *  @param failure     失败回调
 */
+ (void)addDingDanWithShangID:(NSString *)shangID
                  phoneNumber:(NSString *)phoneNumber
                     passWord:(NSString *)passWord
                        count:(NSInteger)count
                    productID:(NSInteger)productID
                       finish:(void (^)(id responseObject))success
                        error:(void (^)(NSError *error))failure
{
    NSString *soapMessage =
    [NSString stringWithFormat:
     @"<?xml version=\"1.0\" encoding=\"utf-8\"?>"
     "<soap:Envelope xmlns:xsi=\"http://www.w3.org/2001/XMLSchema-instance\" xmlns:xsd=\"http://www.w3.org/2001/XMLSchema\" xmlns:soap=\"http://schemas.xmlsoap.org/soap/envelope/\">"
     "<soap:Body>"
     "<AddDingDan xmlns=\"http://123.57.206.151/\">"
     "<TEL>%@</TEL>"
     "<PWD>%@</PWD>"
     "<Count>%zd</Count>"
     "<shangID>%@</shangID>"
     "<proID>%zd</proID>"
     "</AddDingDan>"
     "</soap:Body>"
     "</soap:Envelope>"
     , phoneNumber, passWord, count, shangID, productID];
    
    [[self sharedInstance] sendPOSTRequestWithSoapMessage:soapMessage
                                                   andURL:@"WSAddDingDan.asmx"
                                            andSoapAction:@"AddDingDan"
                                                   finish:(void (^)(id responseObject))success
                                                    error:(void (^)(NSError *error))failure];
}

/**
 *  查询顾客订单
 *
 *  @param phoneNumber 电话号码
 *  @param passWord    密码
 *  @param big         最大值
 *  @param small       最小值
 *  @param success     成功回调
 *  @param failure     失败回调
 */
+ (void)selectDingDanWithPhoneNumber:(NSString *)phoneNumber
                         passWord:(NSString *)passWord
                              big:(NSInteger)big
                            small:(NSInteger)small
                           finish:(void (^)(id responseObject))success
                            error:(void (^)(NSError *error))failure
{
    NSString *soapMessage =
    [NSString stringWithFormat:
     @"<?xml version=\"1.0\" encoding=\"utf-8\"?>"
     "<soap:Envelope xmlns:xsi=\"http://www.w3.org/2001/XMLSchema-instance\" xmlns:xsd=\"http://www.w3.org/2001/XMLSchema\" xmlns:soap=\"http://schemas.xmlsoap.org/soap/envelope/\">"
     "<soap:Body>"
     "<selectDingDanByGuKeTEL xmlns=\"http://123.57.206.151/\">"
     "<TEL>%@</TEL>"
     "<PWD>%@</PWD>"
     "<big>%zd</big>"
     "<small>%zd</small>"
     "</selectDingDanByGuKeTEL>"
     "</soap:Body>"
     "</soap:Envelope>"
     , phoneNumber, passWord, big, small];
    
    [[self sharedInstance] sendPOSTRequestWithSoapMessage:soapMessage
                                                   andURL:@"WSGetDingDan.asmx"
                                            andSoapAction:@"selectDingDanByGuKeTEL"
                                                   finish:(void (^)(id responseObject))success
                                                    error:(void (^)(NSError *error))failure];
}

/**
 *  顾客完成订单
 *
 *  @param phoneNumber 顾客手机号
 *  @param passWord    密码
 *  @param orderNumber 订单号
 *  @param success     成功回调
 *  @param failure     失败回调
 */
+ (void)completeDingDanWithPhoneNumber:(NSString *)phoneNumber
                            passWord:(NSString *)passWord
                         orderNumber:(NSString *)orderNumber
                              finish:(void (^)(id responseObject))success
                               error:(void (^)(NSError *error))failure
{
    NSString *soapMessage =
    [NSString stringWithFormat:
     @"<?xml version=\"1.0\" encoding=\"utf-8\"?>"
     "<soap:Envelope xmlns:xsi=\"http://www.w3.org/2001/XMLSchema-instance\" xmlns:xsd=\"http://www.w3.org/2001/XMLSchema\" xmlns:soap=\"http://schemas.xmlsoap.org/soap/envelope/\">"
     "<soap:Body>"
     "<CompleteDingDan xmlns=\"http://123.57.206.151/\">"
     "<TEL>%@</TEL>"
     "<PWD>%@</PWD>"
     "<orderNum>%@</orderNum>"
     "</CompleteDingDan>"
     "</soap:Body>"
     "</soap:Envelope>"
     , phoneNumber, passWord, orderNumber];
    
    [[self sharedInstance] sendPOSTRequestWithSoapMessage:soapMessage
                                                   andURL:@"WSCompleteDingDan.asmx"
                                            andSoapAction:@"CompleteDingDan"
                                                   finish:(void (^)(id responseObject))success
                                                    error:(void (^)(NSError *error))failure];
}



/**
 *  添加收藏
 *
 *  @param shangID     商品ID
 *  @param passWord    密码
 *  @param phoneNumber 电话
 *  @param shangName   商家名称
 *  @param success     成功回调
 *  @param failure     失败回调
 */
+ (void)insertCollectionWithShangID:(NSString *)shangID
                           passWord:(NSString *)passWord
                        phoneNumber:(NSString *)phoneNumber
                          shangName:(NSString *)shangName
                             finish:(void (^)(id responseObject))success
                              error:(void (^)(NSError *error))failure
{
    NSString *soapMessage =
    [NSString stringWithFormat:
     @"<?xml version=\"1.0\" encoding=\"utf-8\"?>"
     "<soap:Envelope xmlns:xsi=\"http://www.w3.org/2001/XMLSchema-instance\" xmlns:xsd=\"http://www.w3.org/2001/XMLSchema\" xmlns:soap=\"http://schemas.xmlsoap.org/soap/envelope/\">"
     "<soap:Body>"
     "<insertCollection xmlns=\"http://123.57.206.151/\">"
     "<shangID>%@</shangID>"
     "<customerTEL>%@</customerTEL>"
     "<shangName>%@</shangName>"
     "<PWD>%@</PWD>"
     "</insertCollection>"
     "</soap:Body>"
     "</soap:Envelope>"
     , shangID, phoneNumber, shangName, passWord];

    
    [[self sharedInstance] sendPOSTRequestWithSoapMessage:soapMessage
                                                   andURL:@"WSCollection.asmx"
                                            andSoapAction:@"insertCollection"
                                                   finish:(void (^)(id responseObject))success
                                                    error:(void (^)(NSError *error))failure];
}

/**
 *  查询收藏夹
 *
 *  @param phoneNumber 顾客电话号码
 *  @param passWord    密码
 *  @param success     成功回调
 *  @param failure     失败回调
 */
+ (void)selectCollectionWithPhoneNumber:(NSString *)phoneNumber
                               passWord:(NSString *)passWord
                                 finish:(void (^)(id responseObject))success
                                  error:(void (^)(NSError *error))failure
{
    NSString *soapMessage =
    [NSString stringWithFormat:
     @"<?xml version=\"1.0\" encoding=\"utf-8\"?>"
     "<soap:Envelope xmlns:xsi=\"http://www.w3.org/2001/XMLSchema-instance\" xmlns:xsd=\"http://www.w3.org/2001/XMLSchema\" xmlns:soap=\"http://schemas.xmlsoap.org/soap/envelope/\">"
     "<soap:Body>"
     "<selectCollectionByTEL xmlns=\"http://123.57.206.151/\">"
     "<TEL>%@</TEL>"
     "<PWD>%@</PWD>"
     "</selectCollectionByTEL>"
     "</soap:Body>"
     "</soap:Envelope>"
     , phoneNumber, passWord];
    
    [[self sharedInstance] sendPOSTRequestWithSoapMessage:soapMessage
                                                   andURL:@"WSCollection.asmx"
                                            andSoapAction:@"selectCollectionByTEL"
                                                   finish:(void (^)(id responseObject))success
                                                    error:(void (^)(NSError *error))failure];
}

/**
 *  删除收藏夹
 *
 *  @param ID          收藏夹ID
 *  @param phoneNumber 电话号码
 *  @param passWord    密码
 *  @param success     成功回调
 *  @param failure     失败回调
 */
+ (void)deleteCollectionWithID:(NSString *)ID
                   phoneNumber:(NSString *)phoneNumber
                      passWord:(NSString *)passWord
                        finish:(void (^)(id responseObject))success
                         error:(void (^)(NSError *error))failure
{
    NSString *soapMessage =
    [NSString stringWithFormat:
     @"<?xml version=\"1.0\" encoding=\"utf-8\"?>"
     "<soap:Envelope xmlns:xsi=\"http://www.w3.org/2001/XMLSchema-instance\" xmlns:xsd=\"http://www.w3.org/2001/XMLSchema\" xmlns:soap=\"http://schemas.xmlsoap.org/soap/envelope/\">"
     "<soap:Body>"
     "<delCollection xmlns=\"http://123.57.206.151/\">"
     "<ID>%@</ID>"
     "<TEL>%@</TEL>"
     "<PWD>%@</PWD>"
     "</delCollection>"
     "</soap:Body>"
     "</soap:Envelope>"
     , ID, phoneNumber, passWord];
    
    [[self sharedInstance] sendPOSTRequestWithSoapMessage:soapMessage
                                                   andURL:@"WSCollection.asmx"
                                            andSoapAction:@"delCollection"
                                                   finish:(void (^)(id responseObject))success
                                                    error:(void (^)(NSError *error))failure];
}



/**
 *  获取注册手机验证码
 *
 *  @param PhoneNumber 手机号
 *  @param success     成功回掉
 *  @param failure     失败回掉
 */
+ (void)getSMSSendWithPhoneNumber:(NSString *)PhoneNumber
                           finish:(void (^)(id responseObject))success
                            error:(void (^)(NSError *error))failure
{
    NSString *soapMessage =
    [NSString stringWithFormat:
     @"<?xml version=\"1.0\" encoding=\"utf-8\"?>"
     "<soap:Envelope xmlns:xsi=\"http://www.w3.org/2001/XMLSchema-instance\" xmlns:xsd=\"http://www.w3.org/2001/XMLSchema\" xmlns:soap=\"http://schemas.xmlsoap.org/soap/envelope/\">"
     "<soap:Body>"
     "<SMSSend xmlns=\"http://123.57.206.151/\">"
     "<TEL>%@</TEL>"
     "<IP>%@</IP>"
     "</SMSSend>"
     "</soap:Body>"
     "</soap:Envelope>"
     , PhoneNumber, [self sharedInstance].IPAddress];
    
    
    
    [[self sharedInstance] sendPOSTRequestWithSoapMessage:soapMessage
                                                   andURL:@"WSSMSSend.asmx"
                                            andSoapAction:@"SMSSend"
                                                   finish:(void (^)(id responseObject))success
                                                    error:(void (^)(NSError *error))failure];
}

/**
 *  顾客注册
 *
 *  @param PhoneNumber  手机号码
 *  @param passWord     密码
 *  @param name         姓名
 *  @param securityCode 验证码
 *  @param success      成功回掉
 *  @param failure      失败回调
 */
+ (void)customerRegisterWithPhoneNumber:(NSString *)PhoneNumber
                               passWord:(NSString *)passWord
                                   name:(NSString *)name
                           securityCode:(NSString *)securityCode
                                 finish:(void (^)(id responseObject))success
                                  error:(void (^)(NSError *error))failure
{
    NSString *soapMessage =
    [NSString stringWithFormat:
     @"<?xml version=\"1.0\" encoding=\"utf-8\"?>"
     "<soap:Envelope xmlns:xsi=\"http://www.w3.org/2001/XMLSchema-instance\" xmlns:xsd=\"http://www.w3.org/2001/XMLSchema\" xmlns:soap=\"http://schemas.xmlsoap.org/soap/envelope/\">"
     "<soap:Body>"
     "<CustomerRegister xmlns=\"http://123.57.206.151/\">"
     "<TEL>%@</TEL>"
     "<PWD>%@</PWD>"
     "<Name>%@</Name>"
     "<VerificationCode>%@</VerificationCode>"
     "<IP>%@</IP>"
     "</CustomerRegister>"
     "</soap:Body>"
     "</soap:Envelope>"
     , PhoneNumber, passWord, name, securityCode, [self sharedInstance].IPAddress];
    
    
    [[self sharedInstance] sendPOSTRequestWithSoapMessage:soapMessage
                                                   andURL:@"WSCustomerRegister.asmx"
                                            andSoapAction:@"CustomerRegister"
                                                   finish:(void (^)(id responseObject))success
                                                    error:(void (^)(NSError *error))failure];
}

/**
 *  顾客登录
 *
 *  @param PhoneNumber 电话号码
 *  @param passWord    密码
 *  @param success     成功回调
 *  @param failure     失败回调
 */
+ (void)customerLoginWithPhoneNumber:(NSString *)PhoneNumber
                            passWord:(NSString *)passWord
                              finish:(void (^)(id responseObject))success
                               error:(void (^)(NSError *error))failure
{
    NSString *soapMessage =
    [NSString stringWithFormat:
     @"<?xml version=\"1.0\" encoding=\"utf-8\"?>"
     "<soap:Envelope xmlns:xsi=\"http://www.w3.org/2001/XMLSchema-instance\" xmlns:xsd=\"http://www.w3.org/2001/XMLSchema\" xmlns:soap=\"http://schemas.xmlsoap.org/soap/envelope/\">"
     "<soap:Body>"
     "<CustomerLogin xmlns=\"http://123.57.206.151/\">"
     "<TEL>%@</TEL>"
     "<PWD>%@</PWD>"
     "<loginIP>%@</loginIP>"
     "</CustomerLogin>"
     "</soap:Body>"
     "</soap:Envelope>"
     , PhoneNumber, passWord, [self sharedInstance].IPAddress];
    [[self sharedInstance] sendPOSTRequestWithSoapMessage:soapMessage
                                                   andURL:@"WSCustomerLogin.asmx"
                                            andSoapAction:@"CustomerLogin"
                                                   finish:(void (^)(id responseObject))success
                                                    error:(void (^)(NSError *error))failure];
}


- (void)sendPOSTRequestWithSoapMessage:(NSString *)soapMessage
                                andURL:(NSString *)urlSuffix
                         andSoapAction:(NSString *)action
                                finish:(void (^)(id responseObject))success
                                 error:(void (^)(NSError *error))failure
{
    if (![[SNNetManger instance] isNetworkRunning]) {
        [MBProgressHUD hideHUD];
        [MBProgressHUD showError:@"网络未连接"];
        return;
    }
    NSURL *url = [NSURL URLWithString:[NSString stringWithFormat:@"%@%@",HTTP,urlSuffix]];
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:url];
    
    NSString *msgLength = [NSString stringWithFormat:@"%lu", (unsigned long)[soapMessage length]];
    
    [request addValue:@"text/xml; charset=utf-8" forHTTPHeaderField:@"Content-Type"];
    NSString *str = [NSString stringWithFormat:@"%@%@",SOAPAction, action];
    [request addValue:str forHTTPHeaderField:@"SOAPAction"];
    [request addValue:msgLength forHTTPHeaderField:@"Content-Length"];
    [request setHTTPMethod:@"POST"];
    [request setHTTPBody:[soapMessage dataUsingEncoding:NSUTF8StringEncoding]];
    AFHTTPRequestOperation *operation = [[AFHTTPRequestOperation alloc] initWithRequest:request];
    operation.responseSerializer = [AFXMLParserResponseSerializer serializer];
    [operation setCompletionBlockWithSuccess:^(AFHTTPRequestOperation *operation, NSXMLParser *responseObject) {
        responseObject.delegate = self;
        [responseObject parse];
        success(_result);
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        failure(error);
    }];
    [self.operation cancel];
    [operation start];
    self.operation = operation;
}

- (NSMutableString *)nodeString {
    if (_nodeString == nil) {
        _nodeString = [NSMutableString string];
    }
    return _nodeString;
}

- (void)parser:(NSXMLParser *)parser didStartElement:(NSString *)elementName namespaceURI:(NSString *)namespaceURI qualifiedName:(NSString *)qName attributes:(NSDictionary *)attributeDict {
    [self.nodeString setString:@""];
}

- (void)parser:(NSXMLParser *)parser foundCharacters:(NSString *)string {
    [self.nodeString appendString:string];
}

- (void)parserDidEndDocument:(NSXMLParser *)parser {
    NSData *data = [self.nodeString dataUsingEncoding:NSUTF8StringEncoding];
    self.result = [NSJSONSerialization JSONObjectWithData:data options:0 error:NULL];
}

@end
