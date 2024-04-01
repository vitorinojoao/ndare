@ECHO OFF

REM Batch file for PyPI packaging and distribution

pushd %~dp0

if not "%1" == "dist" goto HELP

echo.
echo.----------------------------------------------------------------------
echo.You should not go forward if the package is not fully tested.
echo.Do you wish to build a distribution?
set /P INPUT=Type 'yes' or 'no': 
if not "%INPUT%" == "yes" goto END

pip install build

py -m build .. --outdir ./dist

echo.
echo.----------------------------------------------------------------------
echo.You should not go forward if any errors occured in the previous step.
echo.Do you wish to check the distribution?
set /P INPUT=Type 'yes' or 'no': 
if not "%INPUT%" == "yes" goto END

pip install twine

twine check dist/*

echo.
echo.----------------------------------------------------------------------
echo.You should not go forward if any errors occured in the previous step.
echo.Do you wish to upload the distribution to PyPI?
set /P INPUT=Type 'yes' or 'no': 
if not "%INPUT%" == "yes" goto END

echo.
echo.The distribution will be publicly available. Do you confirm?
set /P INPUT=Type 'confirm' or 'cancel': 
if not "%INPUT%" == "confirm" goto END

twine upload dist/*

goto END

:HELP
echo.Please use 'make dist' to build a distribution.

:END
popd
