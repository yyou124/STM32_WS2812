################################################################################
# Automatically-generated file. Do not edit!
################################################################################

# Add inputs and outputs from these tool invocations to the build variables 
C_SRCS += \
../BSP/WS28.c 

OBJS += \
./BSP/WS28.o 

C_DEPS += \
./BSP/WS28.d 


# Each subdirectory must supply rules for building sources it contributes
BSP/%.o: ../BSP/%.c
	@echo 'Building file: $<'
	@echo 'Invoking: GNU ARM Cross C Compiler'
	arm-none-eabi-gcc -mcpu=cortex-m3 -mthumb -O0 -fmessage-length=0 -fsigned-char -ffunction-sections -fdata-sections  -g3 -DUSE_HAL_DRIVER -DSTM32F407xx -I"D:\CodeLib\RGB-E\Inc" -I"D:\CodeLib\RGB-E\Drivers\CMSIS\Device\ST\STM32F4xx\Include" -I"D:\CodeLib\RGB-E\Drivers\STM32F4xx_HAL_Driver\Inc" -I"D:\CodeLib\RGB-E\Drivers\CMSIS\Include" -I"D:\CodeLib\RGB-E\BSP" -std=gnu11 -MMD -MP -MF"$(@:%.o=%.d)" -MT"$(@)" -c -o "$@" "$<"
	@echo 'Finished building: $<'
	@echo ' '


