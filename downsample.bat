@echo off
REM ���� LAStools ·��
SET LASTOOLS_PATH=D:\LAStools\bin

REM ���������ļ���·��
SET INPUT_DIR=D:\Califulia_Lidar\ground_cleaned

REM ��������ļ���·��
SET OUTPUT_DIR=D:\Califulia_Lidar\downsampled_data

REM ��������ļ��У���������ڣ�
IF NOT EXIST "%OUTPUT_DIR%" (
    mkdir "%OUTPUT_DIR%"
)

REM ִ�� las2las �����²�������
FOR %%F IN ("%INPUT_DIR%\*.las") DO (
    echo ���ڴ����ļ���%%F
    "%LASTOOLS_PATH%\las2las.exe" -i "%%F" -o "%OUTPUT_DIR%\downsampled_%%~nF.las" ^
        -keep_every_nth 10 ^                      
 IF %ERRORLEVEL% NEQ 0 (
        echo ����lasnoise.exe �����ļ� %%F ʧ�ܡ�
    ) ELSE (
        echo �ļ� %%F ����ɹ���
    )
)

REM ��ɺ���ʾ
echo �²���������ɣ�
pause


