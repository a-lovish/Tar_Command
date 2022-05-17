# Tar_Command

This shell script replicates the behaviour of the tar command in linux operating system.

Metadata is stored in a file called “metadata.txt”. Please note that the tar archive should be a plain text file (without .tar) and the tar archive can be created only once in a directory. The existing “metadata.txt” needs to be deleted for creating a new archive. Archiving of media files is not supported.

I have implemented the following options:-
1. tar -cf archive.txt file1.txt file2.cpp
2. tar -cvf archive.txt file1.txt file2.cpp
3. tar -rf archive.txt file3.c
4. tar -rvf archive.txt file3.c
5. tar -tf archive.txt
6. tar -tvf archive.txt
7. tar -xf archive.txt
8. tar -xf archive.txt file1.txt file3.c
9. tar -xvf archive.txt
10. tar -xvf archive.txt file1.txt file3.c

You can also use *.c in place of file3.c to archive all .c files into the tar archive but do not use *.txt in place of file1.txt as it will include archive.txt and metadata.txt which may cause loss of data. However, *.c, *.cpp, etc. for -cf, -cvf, -rf and -rvf options are supported.
Ex: tar -rf archive.txt *.c file1.txt
