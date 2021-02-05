# Copyright (C) 2021 The OmniROM Project
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#      http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.

#
# This file is the build configuration for a full Android
# build for grouper hardware. This cleanly combines a set of
# device-specific aspects (drivers) with a device-agnostic
# product configuration (apps).
#

COMMON_PATH := device/motorola/dynamic_common

TARGET_NO_BOOTLOADER := true
TARGET_NO_RECOVERY := false
TARGET_NO_KERNEL := false

# Architecture
TARGET_ARCH := arm64
TARGET_ARCH_VARIANT := armv8-a
TARGET_CPU_ABI := arm64-v8a
TARGET_CPU_ABI2 :=
TARGET_CPU_VARIANT := generic

TARGET_2ND_ARCH := arm
TARGET_2ND_ARCH_VARIANT := armv7-a-neon
TARGET_2ND_CPU_ABI := armeabi-v7a
TARGET_2ND_CPU_ABI2 := armeabi
TARGET_2ND_CPU_VARIANT := cortex-a9

TARGET_KERNEL_ARCH := arm64
TARGET_KERNEL_HEADER_ARCH := arm64
TARGET_COMPILE_WITH_MSM_KERNEL := true
TARGET_KERNEL_CLANG_COMPILE := true
TARGET_KERNEL_CLANG_VERSION := r365631c

BOARD_PRODUCTIMAGE_FILE_SYSTEM_TYPE := ext4
BOARD_SYSTEMIMAGE_FILE_SYSTEM_TYPE := ext4
TARGET_USERIMAGES_USE_EXT4 := true
TARGET_USERIMAGES_USE_F2FS := true
TARGET_USES_MKE2FS := true

BOARD_SUPER_PARTITION_GROUPS := qti_dynamic_partitions

BOARD_QTI_DYNAMIC_PARTITIONS_PARTITION_LIST := \
    system \
    product

TARGET_COPY_OUT_VENDOR := vendor
TARGET_COPY_OUT_PRODUCT := product

BOARD_USES_VENDORIMAGE := true

ifeq ($(PRODUCT_BUILD_SYSTEM_EXT_IMAGE),true)
BOARD_QTI_DYNAMIC_PARTITIONS_PARTITION_LIST += \
    system_ext

BOARD_SYSTEM_EXTIMAGE_FILE_SYSTEM_TYPE := ext4
TARGET_COPY_OUT_SYSTEM_EXT := system_ext
endif

BOARD_FLASH_BLOCK_SIZE := 131072 # (BOARD_KERNEL_PAGESIZE * 64)

BOARD_USES_SNAPDRAGONCAMERA_VERSION := 2


# charger
HEALTHD_USE_BATTERY_INFO := true
BOARD_CHARGER_ENABLE_SUSPEND := true

BOARD_PROPERTY_OVERRIDES_SPLIT_ENABLED := true

TARGET_SYSTEM_PROP += $(COMMON_PATH)/system.prop

include vendor/omni/sepolicy/sepolicy.mk
include device/qcom/sepolicy/SEPolicy.mk
BOARD_PLAT_PUBLIC_SEPOLICY_DIR += $(COMMON_PATH)/sepolicy/public
BOARD_PLAT_PRIVATE_SEPOLICY_DIR += $(COMMON_PATH)/sepolicy/private

BOARD_SECCOMP_POLICY += $(COMMON_PATH)/seccomp_policy

PRODUCT_FULL_TREBLE := true
BOARD_VNDK_VERSION := current
BOARD_VNDK_RUNTIME_DISABLE := false



# AVB
BOARD_AVB_ENABLE := true
BOARD_AVB_MAKE_VBMETA_IMAGE_ARGS += --set_hashtree_disabled_flag
BOARD_AVB_MAKE_VBMETA_IMAGE_ARGS += --flags 2
BOARD_USES_VENDORIMAGE := true
BOARD_AVB_VBMETA_SYSTEM := system
BOARD_AVB_VBMETA_SYSTEM_KEY_PATH := external/avb/test/data/testkey_rsa2048.pem
BOARD_AVB_VBMETA_SYSTEM_ALGORITHM := SHA256_RSA2048
BOARD_AVB_VBMETA_SYSTEM_ROLLBACK_INDEX := $(PLATFORM_SECURITY_PATCH_TIMESTAMP)
BOARD_AVB_VBMETA_SYSTEM_ROLLBACK_INDEX_LOCATION := 1

PRODUCT_SOONG_NAMESPACES += $(COMMON_PATH)

# Split selinux policy
PRODUCT_SEPOLICY_SPLIT := true

# Android generic system image always create metadata partition
BOARD_USES_METADATA_PARTITION := true

BUILD_BROKEN_DUP_RULES := true

DEXPREOPT_GENERATE_APEX_IMAGE := true
USE_XML_AUDIO_POLICY_CONF := 1

