这个仓库是使用Verilog来实验（前仿，增加延时）SoC中常见的无毛刺时钟切换电路。

电路使用的《数字IC设计入门》中的电路

单独的DFF模块，可以方便修改为使用上升沿或下降沿触发器、模拟触发器不同的延迟等。

# 电路1
[clk_exchange1.v](src/clk_exchange1.v)

![](images/circuit1.excalidraw.svg)

大致可分4级：

1. sel信号switch
2. 同步器
3. 下降沿采样
4. 时钟与和或

## 下降沿采样的必要性
下图是模拟触发器有一定延迟时采用上升沿采样的现象，有毛刺
![](images/exchange1_delay_posedge.png)

下图是同样触发器有延迟，采用下降沿采样的现象，无毛刺
![](images/exchange1_delay_negedge.png)