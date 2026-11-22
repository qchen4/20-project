JPEG-LS Reference Encoder - V.1.00 *** FOR TESTING AND EVALUATION ONLY ***
(c) COPYRIGHT HEWLETT-PACKARD COMPANY, 1995-1999.

The following notice applies to each program in the software package:
------------------------------------------------------------------------
This software module was originally developed by Hewlett-Packard
Company in the course of development of the ITU-T Rec. T.87|ISO/IEC 
14495-1 standard. This software module is an implementation of 
a part of ITU-T Rec. T.87|ISO/IEC 14495-1. ISO/IEC gives users of 
ITU-T Rec. T.87|ISO/IEC 14495-1 free license to this 
software module or modifications thereof for use in testing hardware 
or software products which claim conformance to ITU-T Rec. 
T.87|ISO/IEC 14495-1. Those intending to use this software module are 
advised that its use may infringe existing patents. THE ORIGINAL 
DEVELOPER OF THIS SOFTWARE MODULE, ISO/IEC, AND ITU-T, HAVE NO 
LIABILITY FOR USE OF THIS SOFTWARE MODULE OR MODIFICATIONS THEREOF. 
No license to this software module is granted for any use other than 
in testing product conformance to ITU-T Rec. T.87|ISO/IEC 14495-1.
Hewlett-Packard Company retains full right to use the software module 
for its own purpose, assign or donate the software module to a third 
party and to inhibit third parties from using the code in a manner 
inconsistent with the terms of this license. This copyright notice 
must be included in all copies or derivative works of the software 
module. Copyright (c) Hewlett-Packard Company 1995-1999.
------------------------------------------------------------------------


This software package contains an implementation of JPEG-LS, a standard
for lossless/near-lossless compression of continuous-tone images
(ITU-T Rec. T.87|ISO/IEC 14495-1).

The names of the executables in the package derive from the acronym LOCO, 
as the core of the standard is based on the LOCO-I algorithm (LOw COmplexity 
LOssless COmpression for Images) developed at Hewlett-Packard Laboratories
(reference: M. Weinberger, G. Seroussi, G. Sapiro, "LOCO-I: A Low
Complexity, Context-Based, Lossless Image Compression Algorithm,"
Proc. IEEE Data Compression Conference, Snowbird, Utah, March-April 1996).

The term "near-lossless compression" refers to a lossy algorithm
for which each decompressed image sample differs from the corresponding
original image sample by not more than a pre-specified value, the (usually 
small) "loss."  Lossless compression corresponds to loss=0. 
Even though the term "continuous-tone image" refers in principle to any 
image whose components have more than one bit per sample, palletized images 
may require a reordering of the color palette for best compression results 
using JPEG-LS on the array of color indices. This functionality is not 
implemented in the present software, although it is supported by the
standard, and is fairly easy to implement with the tools given. Notice, 
however, that LOCO-I and JPEG-LS were not designed, and might not give 
optimal performance, for images that have been palletized through dithering. 

More information on JPEG-LS is available on the World Wide Web sites
  http://www.disc.org.uk/public/jpeghomepage.htm (JPEG web site),
  http://www.hpl.hp.com/loco                     (HP LOCO-I/JPEG-LS web site).


THIS PACKAGE CONTAINS:
----------------------

	README.TXT - this file
	[n]loco[16][ed].exe (MS-Windows 95/98/NT),  OR 
	[n]loco[16][ed] (UNIX) - executables
	testimg.pgm - a test image (256x256, 8 bits/pixel)

	(The image testimg.pgm is provided so that you can immediately 
	 try the executables.)


EXECUTABLES:
------------

	If you downloaded a zip file, all executables (*.exe files) are 
	32-bit Win95/98/NT binaries (Intel x86 architectures). They will NOT 
	run in a 16-bit environment. 
	If you downloaded a "tar" file, you have UNIX executables (HP-UX,
	SunOS, etc).

	Programs in the package:
		locoe 	 - 8 bit lossless compressor
		locod	 - 8 bit lossless decompressor
		nlocoe 	 - 8 bit near-lossless compressor
		nlocod	 - 8 bit near-lossless decompressor
		loco16e  - 16 bit lossless compressor
		loco16d	 - 16 bit lossless decompressor
		nloco16e - 16 bit near-lossless compressor
		nloco16d - 16 bit near-lossless decompressor

	"8 bit"  programs are used for images with at most 8 bits per color
	component.
	"16 bit" programs are used for images with between 9 and 16 bits per
	color component.

IMAGE FORMATS:
--------------

	Encoder input (uncompressed) or decoder output (decompressed) 
	images are in either PGM (grayscale) or PPM (3-color) format. 
	These input/output formats are NOT part of the JPEG-LS standard, 
	and they were selected for the sake of simplicity in this 
	implementation.

	The PGM and PPM formats have an ASCII header consisting of 3 lines 
	of the following form:

	    * PGM (single component):

		line 1: P5
		line 2: cols rows
		line 3: maxval

	    * PPM (3 components)

		line 1: P6
		line 2: cols rows
		line 3: maxval
		
	P5 and P6 appear verbatim (in ASCII) in the header. The parameters 
	"cols," "rows," and "maxval" are decimal numbers in ASCII 
	representation.
	For PGM, the header is followed by cols*rows samples in binary format,
	where cols and rows are the number of columns and rows, respectively.
	For this implementation, each sample occupies one 8-bit byte if 
	maxval < 256, or two bytes if 256 <= maxval < 65536. In the case of 
	16-bit samples, BIG ENDIAN convention is used (most significant byte 
	first).

	For PPM, the header is followed by cols*rows TRIPLETS of symbols in
	binary format. Each symbol in a triplet represents a color component
	value (viewers usually interpret PPM triplets as RGB).

	A multi-component image can be specified to the encoder either as 
	a list of PGM files (each representing a color component), or as a 
	single PPM-type file.

MULTIPLE-COMPONENT IMAGES:
--------------------------

	Three modes of operation are supported for multi-component images
	(images of the type RGB, CMYK, YUV, etc). This is a subset of the 
	more general scan-based structure supported by JPEG-LS, and is 
	briefly described next:

	   * Plane-by-plane (PbP) compression. The image components are 
	     compressed one after the other, in a completely independent 
	     manner (in JPEG terminology, there is one component per scan). 
	     In this mode, the input to the encoder is one PGM file per 
	     component (i.e., no PPM input is allowed). The same applies to 
	     the output of the decoder.

           * Line-interleaved (LI) compression. One row per image component 
	     is processed at a time, in an interleaved manner (in JPEG
	     terminology, all the components are encoded in the same 
	     scan).  Both multiple PGM file and single-file PPM input 
	     (output) are supported by the encoder (decoder). LI mode is 
	     the default mode of this implementation. 

	   * Sample-interleaved (SI) compression. One sample per image 
	     component is processed at a time, in an interleaved manner
	     (again, all the components are encoded in the same scan). 
	     In this mode, the input to the encoder (output from the 
	     decoder) is always a single PPM file.

	Remarks:

        a) Sub-sampled components can be specified to the encoder in
	   PbP and LI modes (e.g., a YUV representation with the U and 
	   V components having a fraction of the number of columns and/or
	   rows of the Y component). For sub-sampled images, the input to the 
	   encoder must be given as a sequence of PGM files. JPEG-LS 
	   does not support sub-sampling in SI mode.

	b) Regardless of the input format, the output of the encoder (input 
	   to the decoder), is always a single JPEG-LS compressed bit-stream,
	   consisting of marker segments and compressed image data segments.

	c) The SI mode is recommended only for synthetic graphics or 
	   computer-generated compound documents (i.e., images likely 
	   to contain large flat areas that are common to all the 
	   components). On other image types, this mode is likely to be 
	   slower, and compress worse, than the other modes.

	d) For single-component images, the three modes are equivalent.
	   By default, the JPEG-LS header will indicate LI mode in this case.


COMMAND LINES:
--------------

	Lossless encoder (8 bits):
	--------------------------

        locoe [flags] infile1 [infile2,infile3,...] [-ooutfile]

	FILES:
	infile1    : Input file -- must be in PGM or PPM format. If there 
		     are additional input files, then infile1 must be in 
		     PGM format.
	infile2,...: Additional input files for PbP or LI modes. Must be 
		     in PGM format.
	outfile    : Output file in JPEG-LS format. Default = locoe.jls.

        FLAGS, PARAMETERS: 
	(*** NOTE: no spaces allowed between a flag and its argument ***)

	-i<infile> : Alternate input specification, use -i- for stdin.
	-o<outfile>: Output specification, use -o- for stdout 
		     (default=locoe.jls).
	-c<num>    : Mode for multi-component images (program default=1):
		     0:plane-by-plane  
		     1:line-interleaved  
		     2:sample-interleaved.

	-M         : Pause the legal notice (default= no pause).
	-h         : Print help.

        OTHER FLAGS AND PARAMETERS:
	The following optional flags allow for overriding of JPEG-LS
	default parameters. Please refer to JPEG-LS specification
	for details.  *** Use only if you know what you are doing! ***

	-r<num>	   : reset frequency
	-Ta<num>,
	-Tb<num>,
	-Tc<num>   : context modeling thresholds



	Lossless decoder (8 bits):
	--------------------------

	locod [flags] [infile] [outfile1 [outfile2,outfile3,...]]

	FILES:
	infile   : Input file in JPEG-LS format. Default = locoe.jls.
	outfile[1,2,...] : Output files. If a single PPM file is generated
		   for a multi-component image (in LI or SI modes), the
		   default name is locod.out. In all other cases, the
		   default names for the of PGM output files are
		   locod1.out, locod2.out, locod3.out, ...

	FLAGS, PARAMETERS:
	-i<infile> : Alternate input specification, use -i- for stdin.
	-o<outfile>: Alternate output specification, use -o- for stdout.
	-P         : Generate single PPM output file for SI or LI modes. This 
		     is the default for SI mode. The default for LI mode (and 
		     only option for PbP mode) is a sequence of PGM files.
	-M         : Pause the legal notice (default=no pause).


	Near-lossless encoder (8 bits):
	-------------------------------

        nlocoe [flags] [-e<loss>] infile1 [infile2,infile3,...] [-ooutfile]

	DEFAULTS:
	outfile    : nlocoe.jls
	<loss>     : 0 (lossless)

        Other flags and parameters: as in lossless encoder.

	Near-lossless decoder (8 bits):
	-------------------------------

	nlocod [flags] [infile] [outfile1 [outfile2, ...]]

	DEFAULTS:
	infile    : nlocoe.jls
	outfile   : nlocod[1,2,...].out

        Other flags and parameters: as in lossless decoder.


	16-bit encoders/decoders: loco16e/loco16d, nloco16e/nloco16d
	------------------------------------------------------------
	Same flags/parameters as 8-bit encoders/decoders.



MISCELLANEOUS REMARKS:
----------------------

	a) When run with loss=0 (-e0), the near-lossless encoder is 
	   functionally equivalent to the lossless one, but slower.
	   (by how much depends on the image, the machine you run on, etc).
	b) Various combinations of input/output specifications with color 
	   modes are illegal FOR THIS PARTICULAR IMPLEMENTATION (but may
	   be legal for JPEG-LS). 

EXAMPLES:
---------

	For the examples, assume:
	* red.pgm, green.pgm, and blue.pgm are 3 PGM components of a color
	  image, of the same size.
	* color.ppm is the color PPM image corresponding to red.pgm, 
	  green.pgm, blue.pgm.
	* hotely.pgm, hotelu.pgm, hotelv.pgm are 3 components of a color 
	  image sub-sampled in the horizontal direction 2:1:1


	a) locoe red.pgm green.pgm blue.pgm

	   Compresses the three components using the program default color 
	   mode (LI, c=1). Compressed bit-stream is locoe.jls

	   locod

	   Decompresses locoe.jls into 3 PGM files:
	   locod1.out, locod2.out, locod3.out

	   locod locoe.jls a.pgm b.pgm c.pgm

 	   Decompresses locoe.jls into 3 PGM files: a.pgm, b.pgm, c.pgm

 	   locod -P

 	   Decompresses locoe.jls into one PPM file: locod.out


	b) locoe color.ppm
      
 	   Same as (a), using single-file input


	c) locoe -c0 red.pgm green.pgm blue.pgm

 	   Compresses the three components in PbP mode. Compressed
	   bit-stream is locoe.jls

 	   locod

 	   Decompresses locoe.jls into 3 PGM files: locod1.out, locod2.out, 
 	   locod3.out.

 	   locod -P

	   This command will produce an error message. PPM output is not 
	   supported in PbP mode (c=0).

	d) locoe -c2 color.ppm

           Compresses color.ppm in SI mode. Only one (PPM) input file
	   can be specified in this mode. Compressed bit stream is locoe.jls.

 	   locod

 	   Decompresses locoe.jls into locod.out, a PPM file.
	   Note that -P needs not be specified in this case.

	e) nlocoe -e3 color.ppm

 	   Compresses color.ppm in LI mode with loss=3, i.e., maximum
	   allowed error of +/-3. The compressed bit-stream is nlocoe.jls.

 	   nlocod -P

 	   Decompresses (reconstructs) the image into nlocod.out, which 
	   differs from color.ppm by at most +/-3 per sample.

	f) nloco -e2 -c0 red.pgm green.pgm blue.pgm

 	   Compresses the three color planes in PbP mode, with
	   maximum error of +/-2.

 	   nlocod

     	   Outputs the reconstructed images nlocod1.out, nlocod2.out, and
	   nlocod3.out, which differ by at most +/-2 per sample
	   from red.pgm, green.pgm, and blue.pgm, respectively.

   
	g) locoe -Ta5 -Tb9 red.pgm

 	   Compresses red.pgm with context thresholds Ta=5, Tb=9, 
	   and Tc=DEFAULT

	h) locoe -r128 green.pgm

 	   Compresses green.pgm with RESET=128.


OTHER LIMITATIONS
=================

	* This software is NOT OPTIMIZED FOR RUNNING TIME and SHOULD NOT 
	  BE USED FOR BENCHMARKING PURPOSES.
	* This is NOT a complete implementation of JPEG-LS. In particular, 
	  only a minimal subset of the marker syntax is supported. The 
	  decoders provided in this package are designed to decompress 
	  only streams produced by the companion encoders. Other streams, 
	  even if standard-compliant, might not be decodable by these 
	  decoders. The encoders, however, are designed to produce valid 
	  streams decodable by any standard-compliant decoder. Also, the 
	  modes implemented cover most of the usual applications of lossless 
	  and near-lossless image compression.
	* Compressed file structure: the only modes currently supported are
	  either
	  a) a single scan with interleaved data (line or sample-interleaved),
	  or
	  b) multiple scans, each containing a single image component.
	  Moreover, all parameters must remain invariant between scans. 
	* Sample-mapping and palette tables (see standard specification) are 
	  not implemented in this implementation.
