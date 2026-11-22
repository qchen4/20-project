YUV×ªPGM£º
ffmpeg -s 352x288 -pix_fmt yuv420p -i ..\image\FOREMAN_352x288.yuv -frames 1 ..\image\testcase_1\FOREMAN_352x288.pgm
ffmpeg -s 1920x1088 -pix_fmt yuv420p -i ..\image\TheCreator_1920x1088.yuv -frames 1 ..\image\testcase_4\TheCreator_1920x1088.pgm
ffmpeg -s 1280x720 -pix_fmt yuv420p -i ..\image\vidyo3_1280x720.yuv -frames 1 ..\image\testcase_5\vidyo3_1280x720.pgm

JPEG lossless½âÂë£º
ffmpeg -i .\out.jls dec.yuv


ÏÔÊ¾Í¼Æ¬£º
ffplay   ..\image\testcase_1\out.jls
ffplay   ..\image\testcase_1\FOREMAN_352x288.pgm
ffplay   ..\image\testcase_5\vidyo3_1280x720.pgm
ffplay   ..\image\testcase_5\out.jls