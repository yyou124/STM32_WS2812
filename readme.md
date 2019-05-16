# 使用STM32F407驱动WS2812

平台：Eclipse、STM32CubeMX、OpenOCD、CMSIS-DAP

思路基于以下方案：

<http://www.stmcu.org.cn/module/forum/forum.php?mod=viewthread&tid=614783&extra=&highlight=WS281&page=1>

通过STM32的SPI功能来驱动WS2182

## 首先在STM32CubeMX创建工程模板

![1557987014788](C:\Users\Administrator\AppData\Roaming\Typora\typora-user-images\1557987014788.png)

SPI频率4MHz。

生成文件时，`Toolchain/IDE`选择`TrueSTUDIO`，这种文件结构与Eclipse的比较相似。

## 在Eclipse创建Project

首先搭建好Eclipse的环境，安装CDT插件、ARM交叉编译工具、make工具、OpenOCD工具，参照：<https://gnu-mcu-eclipse.github.io/>

新建一个`C Project`，起名为`REB-E`,`Toolchain`选择`ARM Cross GCC`，选择`Empty project`，创建一个空的工程，将`STM32CubeMX`生成的文件复制进去，然后进行配置。

由于Eclipse自身的原因，只能识别以`.S`结尾的启动文件，所以我们将`startup_stm32f407xx.s`重命名为`startup_stm32f407xx.S`

在`C/C++ Build->Settings->Tool Settings->GNU ARM Cross C Compiler->Preprocessor`中设置宏定义。这里我们添加两个宏定义`USE_HAL_DERIVER`和`STM32F407XX`

在`C/C++ Build->Settings->Tool Settings->GNU ARM Cross C Compiler->Includes`中设置`.h`文件的`Include`目录

在`C/C++ Build->Settings->Tool Settings->GNU ARM Cross C Linker->General`中设置`.ld`文件的目录。

这样基本上就可以编译了



**![1557987718365](C:\Users\Administrator\AppData\Roaming\Typora\typora-user-images\1557987718365.png)**



将`Adafruit NeoPixel`库函数移植进去，就可以驱动WS2182了。

## 使用`OpenOCD`+`CMSIS-DAP`进行调试

参照<https://blog.csdn.net/dldw8816/article/details/54947357>

## GUN C(GCC C)中重定向`printf`方法

添加以下代码：

``` c
int _write(int fd, char *ptr, int len)
{
    int i = 0;
    /*
     * write "len" of char from "ptr" to file id "fd"
     * Return number of char written.
     *
    * Only work for STDOUT, STDIN, and STDERR
     */
    if (fd > 2)
    {
        return -1;
    }
    while (*ptr && (i < len))
    {
    	HAL_UART_Transmit(&huart1, (uint8_t *)ptr, 1, 0xFFFF);
        if (*ptr == '\n')
        {
        	char *ttt ;
        	*ttt = '\r';
            HAL_UART_Transmit(&huart1, (uint8_t *) ttt, 1, 0xFFFF);
        }
        i++;
        ptr++;
    }
    return i;
}
```

参照：

<https://blog.csdn.net/zhengyangliu123/article/details/54966402>