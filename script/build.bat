@ECHO OFF

for /f %%a in ('powershell -Command "[int](python3 -c 'import multiprocessing as mp; print(int(mp.cpu_count() * 1.5))')"') do set CPU_COUNT_MULTIPLIER=%%a

start pwsh -NoExit -Command "make external -j %CPU_COUNT_MULTIPLIER% && make main -j %CPU_COUNT_MULTIPLIER%"
