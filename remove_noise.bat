@echo off
REM ���� LAStools ·��
SET LASTOOLS_PATH=D:\LAStools\bin

REM ���������ļ���·��
SET INPUT_DIR=D:\Califulia_Lidar\C_ground

REM ��������ļ���·��
SET OUTPUT_DIR=D:\Califulia_Lidar\ground_cleaned

REM ��������ļ��У���������ڣ�
IF NOT EXIST "%OUTPUT_DIR%" (
    mkdir "%OUTPUT_DIR%"
)

REM ִ�� lasnoise ��ÿ���ļ�����ȥ�������������
FOR %%F IN ("%INPUT_DIR%\*.las") DO (
    echo ���ڴ����ļ���%%F
    "%LASTOOLS_PATH%\lasnoise.exe" -i "%%F" -o "%OUTPUT_DIR%\cleaned_%%~nF.las" ^
        -isolated 2.0 ^ 
    IF %ERRORLEVEL% NEQ 0 (
        echo ����lasnoise.exe �����ļ� %%F ʧ�ܡ�
    ) ELSE (
        echo �ļ� %%F ����ɹ���
    )
)

REM ��ɺ���ʾ
echo ȥ���������㴦����ɣ�
pause
