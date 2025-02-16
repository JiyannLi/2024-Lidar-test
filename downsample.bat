@echo off
REM 设置 LAStools 路径
SET LASTOOLS_PATH=D:\LAStools\bin

REM 设置输入文件夹路径
SET INPUT_DIR=D:\Califulia_Lidar\ground_cleaned

REM 设置输出文件夹路径
SET OUTPUT_DIR=D:\Califulia_Lidar\downsampled_data

REM 创建输出文件夹（如果不存在）
IF NOT EXIST "%OUTPUT_DIR%" (
    mkdir "%OUTPUT_DIR%"
)

REM 执行 las2las 进行下采样处理
FOR %%F IN ("%INPUT_DIR%\*.las") DO (
    echo 正在处理文件：%%F
    "%LASTOOLS_PATH%\las2las.exe" -i "%%F" -o "%OUTPUT_DIR%\downsampled_%%~nF.las" ^
        -keep_every_nth 10 ^                      
 IF %ERRORLEVEL% NEQ 0 (
        echo 错误：lasnoise.exe 处理文件 %%F 失败。
    ) ELSE (
        echo 文件 %%F 处理成功。
    )
)

REM 完成后提示
echo 下采样处理完成！
pause


