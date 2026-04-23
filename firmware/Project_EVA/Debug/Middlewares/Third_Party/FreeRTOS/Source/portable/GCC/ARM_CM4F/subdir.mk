################################################################################
# Automatically-generated file. Do not edit!
# Toolchain: GNU Tools for STM32 (14.3.rel1)
################################################################################

# Add inputs and outputs from these tool invocations to the build variables 
C_SRCS += \
../Middlewares/Third_Party/FreeRTOS/Source/portable/GCC/ARM_CM4F/port.c 

C_DEPS += \
./Middlewares/Third_Party/FreeRTOS/Source/portable/GCC/ARM_CM4F/port.d 

OBJS += \
./Middlewares/Third_Party/FreeRTOS/Source/portable/GCC/ARM_CM4F/port.o 


# Each subdirectory must supply rules for building sources it contributes
Middlewares/Third_Party/FreeRTOS/Source/portable/GCC/ARM_CM4F/%.o Middlewares/Third_Party/FreeRTOS/Source/portable/GCC/ARM_CM4F/%.su Middlewares/Third_Party/FreeRTOS/Source/portable/GCC/ARM_CM4F/%.cyclo: ../Middlewares/Third_Party/FreeRTOS/Source/portable/GCC/ARM_CM4F/%.c Middlewares/Third_Party/FreeRTOS/Source/portable/GCC/ARM_CM4F/subdir.mk
	arm-none-eabi-gcc "$<" -mcpu=cortex-m4 -std=gnu11 -g3 -DSTM32F401xE -DUSE_HAL_DRIVER -c -I"/mnt/0854F03C54F02DD6/Project_STM32_EVA/firmware/Project_EVA/Middlewares/Third_Party/FreeRTOS/Source/include" -I"/mnt/0854F03C54F02DD6/Project_STM32_EVA/firmware/Project_EVA/Middlewares/Third_Party/FreeRTOS/Source/CMSIS_RTOS_V2" -I"/mnt/0854F03C54F02DD6/Project_STM32_EVA/firmware/Project_EVA/Drivers/STM32F4xx_HAL_Driver/Inc" -I"/mnt/0854F03C54F02DD6/Project_STM32_EVA/firmware/Project_EVA/Drivers/CMSIS/Include" -I"/mnt/0854F03C54F02DD6/Project_STM32_EVA/firmware/Project_EVA/Drivers/CMSIS/Device/ST/STM32F4xx/Include" -I"/mnt/0854F03C54F02DD6/Project_STM32_EVA/firmware/Project_EVA/Drivers/STM32F4xx_HAL_Driver/Inc/Legacy" -I"/mnt/0854F03C54F02DD6/Project_STM32_EVA/firmware/Project_EVA/Middlewares/Third_Party/FreeRTOS/Source/portable/GCC/ARM_CM4F" -I"/mnt/0854F03C54F02DD6/Project_STM32_EVA/firmware/Project_EVA/Middlewares/Third_Party/FreeRTOS/Source/portable/MemMang" -I"/mnt/0854F03C54F02DD6/Project_STM32_EVA/firmware/Project_EVA/Middlewares/Third_Party/FreeRTOS/Source/CMSIS_RTOS_V2" -I"/mnt/0854F03C54F02DD6/Project_STM32_EVA/firmware/Project_EVA/Core/Inc" -include"/mnt/0854F03C54F02DD6/Project_STM32_EVA/firmware/Project_EVA/Middlewares/Third_Party/FreeRTOS/Source/include/FreeRTOS.h" -O0 -ffunction-sections -fdata-sections -Wall -fstack-usage -fcyclomatic-complexity -MMD -MP -MF"$(@:%.o=%.d)" -MT"$@" --specs=nano.specs -mfpu=fpv4-sp-d16 -mfloat-abi=softfp -mthumb -o "$@"

clean: clean-Middlewares-2f-Third_Party-2f-FreeRTOS-2f-Source-2f-portable-2f-GCC-2f-ARM_CM4F

clean-Middlewares-2f-Third_Party-2f-FreeRTOS-2f-Source-2f-portable-2f-GCC-2f-ARM_CM4F:
	-$(RM) ./Middlewares/Third_Party/FreeRTOS/Source/portable/GCC/ARM_CM4F/port.cyclo ./Middlewares/Third_Party/FreeRTOS/Source/portable/GCC/ARM_CM4F/port.d ./Middlewares/Third_Party/FreeRTOS/Source/portable/GCC/ARM_CM4F/port.o ./Middlewares/Third_Party/FreeRTOS/Source/portable/GCC/ARM_CM4F/port.su

.PHONY: clean-Middlewares-2f-Third_Party-2f-FreeRTOS-2f-Source-2f-portable-2f-GCC-2f-ARM_CM4F

