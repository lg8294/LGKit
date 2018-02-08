#!/bin/sh

#  Script.sh
#  ArrcenKit
#
#  Created by iOS on 16/9/23.
#  Copyright © 2016年 iOS. All rights reserved.

# 如果工程名称和Framework的Target名称不一样的话，要自定义FMKNAME
# 例如: FMK_NAME = "MyFramework"
FMK_NAME="LGKit"

# 自定义输出路径
OUTPUT_DIR=${SRCROOT}/Products/${FMK_NAME}.framework

#命令行编译默认输出路径
WRK_DIR=build

#真机发布版本路径
DEVICE_RELEASE_DIR=${WRK_DIR}/Release-iphoneos/${FMK_NAME}.framework

#模拟器发布版本路径
SIMULATOR_RELEASE_DIR=${WRK_DIR}/Release-iphonesimulator/${FMK_NAME}.framework

# 清理工程并编译
#xcodebuild -configuration "Release" -target "${FMK_NAME}" -sdk iphoneos -arch armv7 -arch armv7s -arch arm64 clean build
#xcodebuild -configuration "Release" -target "${FMK_NAME}" -sdk iphonesimulator -arch x86_64 -arch i386 clean build

xcodebuild -configuration "Release" -target "${FMK_NAME}" -sdk iphoneos clean build
xcodebuild -configuration "Release" -target "${FMK_NAME}" -sdk iphonesimulator clean build

#删除自定义的输出文件夹
if [ -d "${OUTPUT_DIR}" ] #判断是否是文件，如果不存在返回false
then
rm -rf "${OUTPUT_DIR}"
fi

#创建自定义的输出文件夹
mkdir -p "${OUTPUT_DIR}" #-p参数可以确保各个创建成功，即使指定的路径不存在也会逐层创建

#拷贝真机发布版本到自定义输出路径
cp -R "${DEVICE_RELEASE_DIR}/" "${OUTPUT_DIR}/"

#使用Lipo工具合并真机发布版本和模拟器发布版本并输出到自定义文件夹
lipo -create "${DEVICE_RELEASE_DIR}/${FMK_NAME}" "${SIMULATOR_RELEASE_DIR}/${FMK_NAME}" -output "${OUTPUT_DIR}/${FMK_NAME}"

#打开自定义输出文件夹
open "${SRCROOT}/Products/"

#删除默认输出文件夹
#rm -r "${WRK_DIR}" #这里有时会由于库文件还没有合并完成就删除了原始库，导致合并失败


