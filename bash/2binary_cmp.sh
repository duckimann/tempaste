cmp -l subl_orig.exe subl_rep.exe | gawk --non-decimal-data '{printf "%d %02X %02X\n", $1-1, strtonum(0$2), strtonum(0$3)}' > cmp.txt
cmp -l subl_orig.exe subl_rep.exe | gawk --non-decimal-data '{printf "%d = 0x%02X\n", $1-1, strtonum(0$2), strtonum(0$3)}' > cmp.txt

cmp -l file1.bin file2.bin | gawk '{printf "%08X %02X %02X\n", $1-1, strtonum(0$2), strtonum(0$3)}'

cmp -l file1.bin file2.bin | gawk '{printf "%08X %02X %02X\n", $1, strtonum(0$2), strtonum(0$3)}'
cmp -l file1.bin file2.bin | gawk '{printf "%08X %02X %02X\n", $1-1, strtonum(0$2), strtonum(0$3)}' # Offset start @ 0
# https://superuser.com/questions/125376/how-do-i-compare-binary-files-in-linux