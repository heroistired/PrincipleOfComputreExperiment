module Shake (clk,PB_UP,PB_Out);

input clk;
input PB_UP; //��������
output PB_Out; //ȥ����İ������

reg [2:0] count_high = 0; //��������ߵ�ƽ������
reg [2:0] count_low= 0; //��������͵�ƽ������
reg PB_reg= 0;

assign PB_Out=PB_reg;

//��������в���������
always @(posedge clk )
if(PB_UP==1'b0)
count_low<=count_low+1;//�Ե͵�ƽ����
else
count_low<=3'b000;
always @(posedge clk)
if(PB_UP==1'b1)
count_high<=count_high+1;//�Ըߵ�ƽ����
else
count_high<=3'b000;
//�������
always@(posedge clk)
if(count_high==3'b111) //�жϸߵ�ƽ�ź��Ƿ�����������
PB_reg<=1'b1; //����������������������ߵ�ƽ
else
if(count_low==3'b111) //�жϵ͵�ƽ�ź��Ƿ�����������
PB_reg<=1'b0; //����������������������͵�ƽ
else
PB_reg<=PB_reg;
endmodule