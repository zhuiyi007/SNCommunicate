//
//  SNHttpTool.h
//  SNCommunicate
//
//  Created by ZhuiYi on 15/4/14.
//  Copyright (c) 2015年 ZhuiYi. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface SNHttpTool : NSObject


/**
 *  根据级别返回商家信息
 *
 *  @param level   商家级别
 *  @param success 成功回掉
 *  @param failure 失败回掉
 */
+ (void)getLevelOfBusinessWithLevel:(NSString *)level
                             finish:(void (^)(id responseObject))success
                              error:(void (^)(NSError *error))failure;

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
                      error:(void (^)(NSError *error))failure;

/**
 *  通过shangID获取单个商家详情
 *
 *  @param shangID shangID
 *  @param success 成功回掉
 *  @param failure 失败回调
 */
+ (void)getOneShangJiaWithShangID:(NSString *)shangID
                           finish:(void (^)(id responseObject))success
                            error:(void (^)(NSError *error))failure;

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
                                    error:(void (^)(NSError *error))failure;

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
                                    error:(void (^)(NSError *error))failure;

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
                        error:(void (^)(NSError *error))failure;

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
                               error:(void (^)(NSError *error))failure;

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
                                 error:(void (^)(NSError *error))failure;

/**
 *  商家受理订单
 *
 *  @param loginNumber 商家登录码
 *  @param passWord    密码
 *  @param orderNumber 订单号
 *  @param success     成功回调
 *  @param failure     失败回调
 */
+ (void)shouliDingDannWithLoginNumber:(NSString *)loginNumber
                             passWord:(NSString *)passWord
                          orderNumber:(NSString *)orderNumber
                               finish:(void (^)(id responseObject))success
                                error:(void (^)(NSError *error))failure;

/**
 *  商家拒绝/删除订单
 *
 *  @param loginNumber 商家登录码
 *  @param passWord    密码
 *  @param orderNumber 订单号
 *  @param success     成功回调
 *  @param failure     失败回调
 */
+ (void)delDingDanWithLoginNumber:(NSString *)loginNumber
                         passWord:(NSString *)passWord
                      orderNumber:(NSString *)orderNumber
                           finish:(void (^)(id responseObject))success
                            error:(void (^)(NSError *error))failure;

/**
 *  获取商家订单
 *
 *  @param loginNum 商家登录码
 *  @param passWord 密码
 *  @param big      最大值
 *  @param small    最小值
 *  @param success  成功回调
 *  @param failure  失败回调
 */
+ (void)selectDingDanByLoginNum:(NSString *)loginNum
                       passWord:(NSString *)passWord
                            big:(NSInteger)big
                          small:(NSInteger)small
                         finish:(void (^)(id responseObject))success
                          error:(void (^)(NSError *error))failure;

/**
 *  获取商家所有商品
 *
 *  @param loginNum 商家登录码
 *  @param success  成功回调
 *  @param failure  失败回调
 */
+ (void)getShangPinByLoginNum:(NSString *)loginNum
                       finish:(void (^)(id responseObject))success
                        error:(void (^)(NSError *error))failure;

/**
 *  商家修改库存
 *
 *  @param loginNum  登录码
 *  @param password  密码
 *  @param store     库存数
 *  @param productID 产品ID
 *  @param success   成功回调
 *  @param failure   失败回调
 */
+ (void)changeStoreWithLoginNum:(NSString *)loginNum
                       passWord:(NSString *)password
                          store:(NSInteger)store
                      productID:(NSInteger)productID
                         finish:(void (^)(id responseObject))success
                          error:(void (^)(NSError *error))failure;

/**
 *  获取商家总订单数
 *
 *  @param shangID 商家ID
 *  @param success 成功回调
 *  @param failure 失败回调
 */
+ (void)getTotalDingDanWithShangID:(NSString *)shangID
                            finish:(void (^)(id responseObject))success
                             error:(void (^)(NSError *error))failure;
/**
 *  顾客点赞
 *
 *  @param shangID     商家ID
 *  @param phoneNumber 电话号码
 *  @param passWord    密码
 *  @param success     成功回调
 *  @param failure     失败回调
 */
+ (void)insertPointWithShangID:(NSString *)shangID
                   phoneNumber:(NSString *)phoneNumber
                      passWord:(NSString *)passWord
                        finish:(void (^)(id responseObject))success
                         error:(void (^)(NSError *error))failure;

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
                              error:(void (^)(NSError *error))failure;

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
                                  error:(void (^)(NSError *error))failure;

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
                         error:(void (^)(NSError *error))failure;

/**
 *  获取注册手机验证码
 *
 *  @param PhoneNumber 手机号
 *  @param success     成功回掉
 *  @param failure     失败回掉
 */
+ (void)getSMSSendWithPhoneNumber:(NSString *)PhoneNumber
                           finish:(void (^)(id responseObject))success
                            error:(void (^)(NSError *error))failure;

/**
 *  顾客通过旧密码修改密码
 *
 *  @param phoneNumber 电话号码
 *  @param oldPassWord 旧密码
 *  @param newPassWord 新密码
 *  @param success     成功回调
 *  @param failure     失败回调
 */
+ (void)changePWDByPWDWithPhoneNumber:(NSString *)phoneNumber
                          oldPassWord:(NSString *)oldPassWord
                          newPassWord:(NSString *)newPassWord
                               finish:(void (^)(id responseObject))success
                                error:(void (^)(NSError *error))failure;

/**
 *  商家通过旧密码修改密码
 *
 *  @param loginNumber 商家登录码
 *  @param oldPassWord 旧密码
 *  @param newPassWord 新密码
 *  @param success     成功回掉
 *  @param failure     失败回调
 */
+ (void)businessChangePWDByPWDWithLoginNumber:(NSString *)loginNumber
                                  oldPassWord:(NSString *)oldPassWord
                                  newPassWord:(NSString *)newPassWord
                                       finish:(void (^)(id responseObject))success
                                        error:(void (^)(NSError *error))failure;

/**
 *  顾客通过验证码修改密码
 *
 *  @param phoneNumber  电话号码
 *  @param newPassWord  新密码
 *  @param securityCode 验证码
 *  @param success      成功回调
 *  @param failure      失败回调
 */
+ (void)changePWDByVCWithPhoneNumber:(NSString *)phoneNumber
                         newPassWord:(NSString *)newPassWord
                        securityCode:(NSString *)securityCode
                              finish:(void (^)(id responseObject))success
                               error:(void (^)(NSError *error))failure;

/**
 *  商家通过手机验证码修改密码
 *
 *  @param loginNumber  商家登录码
 *  @param securityCode 验证码
 *  @param newPassWord  新密码
 *  @param phoneNumber  电话号码
 *  @param success      成功回调
 *  @param failure      失败回调
 */
+ (void)businessChangePWDByVCWithLoginNumber:(NSString *)loginNumber
                                securityCode:(NSString *)securityCode
                                 newPassWord:(NSString *)newPassWord
                                 phoneNumber:(NSString *)phoneNumber
                                      finish:(void (^)(id responseObject))success
                                       error:(void (^)(NSError *error))failure;

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
                                  error:(void (^)(NSError *error))failure;

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
                               error:(void (^)(NSError *error))failure;

/**
 *  商家登录
 *
 *  @param loginNumber 登录码
 *  @param passWord    密码
 *  @param success     成功回调
 *  @param failure     失败回调
 */
+ (void)businessLoginWithLoginNumber:(NSString *)loginNumber
                            passWord:(NSString *)passWord
                              finish:(void (^)(id responseObject))success
                               error:(void (^)(NSError *error))failure;


@end
