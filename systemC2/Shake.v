module Shake (clk,PB_UP,PB_Out);

input clk;
input PB_UP; //按键输入
output PB_Out; //去抖后的按键输出

reg [2:0] count_high = 0; //按键输入高电平计数器
reg [2:0] count_low= 0; //按键输入低电平计数器
reg PB_reg= 0;

assign PB_Out=PB_reg;

//对输入进行采样，计数
always @(posedge clk )
if(PB_UP==1'b0)
count_low<=count_low+1;//对低电平计数
else
count_low<=3'b000;
always @(posedge clk)
if(PB_UP==1'b1)
count_high<=count_high+1;//对高电平计数
else
count_high<=3'b000;
//防抖输出
always@(posedge clk)
if(count_high==3'b111) //判断高电平信号是否符合输出条件
PB_reg<=1'b1; //如果符合条件，则防抖输出高电平
else
if(count_low==3'b111) //判断低电平信号是否符合输出条件
PB_reg<=1'b0; //如果符合条件，则防抖输出低电平
else
PB_reg<=PB_reg;
endmodule
