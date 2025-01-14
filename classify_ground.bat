@echo off
REM 设置 LAStools 路径
SET LASTOOLS_PATH=D:\LAStools\bin

REM 设置输入文件夹路径
SET INPUT_DIR=D:\Califulia_Lidar\split

REM 设置输出文件夹路径
SET OUTPUT_DIR=D:\Califulia_Lidar\C_ground

REM 创建输出文件夹（如果不存在）
IF NOT EXIST "%OUTPUT_DIR%" (
    mkdir "%OUTPUT_DIR%"
)

REM 执行 lasground 对每个分割后的 .las 文件进行地面点和非地面点分类
FOR %%F IN ("%INPUT_DIR%\*.las") DO (
    echo 正在处理文件：%%F
    "%LASTOOLS_PATH%\lasground.exe" -i "%%F" -o "%OUTPUT_DIR%\ground_%%~nF.las" ^
        -step 1.0 ^
        -spike 0.5 ^
        -bulge 0.5 ^
        -verbose
    IF %ERRORLEVEL% NEQ 0 (
        echo 错误：lasground.exe 处理文件 %%F 失败。
    ) ELSE (
        echo 文件 %%F 处理成功。
    )
)

REM 完成后提示
echo 地面点和非地面点分类完成！
pause







