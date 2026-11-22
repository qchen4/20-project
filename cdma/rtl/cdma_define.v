`ifndef _CDMA_GLOBAL_DEFINE_
`define	_CDMA_GLOBAL_DEFINE_

//-- if H264_TIMER_VALUE == 'd0, no timer function; else core stop at fixed time
//`define H264_TIMER_VALUE  32'h0           //no timer function
//`define H264_TIMER_VALUE  32'h21000000    //10 minutes
`define H264_TIMER_VALUE  32'h4b49d200      //0.5 hour
//`define H264_TIMER_VALUE  32'hd693a400    //1 hour
//`define H264_TIMER_VALUE  32'd200         //sim only

`endif

