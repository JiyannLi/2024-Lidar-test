@echo off
REM ���� LAStools ·��
SET LASTOOLS_PATH=D:\LAStools\bin

REM ���������ļ���·��
SET INPUT_DIR=D:\Califulia_Lidar\split

REM ��������ļ���·��
SET OUTPUT_DIR=D:\Califulia_Lidar\C_ground

REM ��������ļ��У���������ڣ�
IF NOT EXIST "%OUTPUT_DIR%" (
    mkdir "%OUTPUT_DIR%"
)

REM ִ�� lasground ��ÿ���ָ��� .las �ļ����е����ͷǵ�������
FOR %%F IN ("%INPUT_DIR%\*.las") DO (
    echo ���ڴ����ļ���%%F
    "%LASTOOLS_PATH%\lasground.exe" -i "%%F" -o "%OUTPUT_DIR%\ground_%%~nF.las" ^
        -step 1.0 ^
        -spike 0.5 ^
        -bulge 0.5 ^
        -verbose
    IF %ERRORLEVEL% NEQ 0 (
        echo ����lasground.exe �����ļ� %%F ʧ�ܡ�
    ) ELSE (
        echo �ļ� %%F ����ɹ���
    )
)

REM ��ɺ���ʾ
echo �����ͷǵ���������ɣ�
pause







