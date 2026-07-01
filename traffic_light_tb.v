`timescale 1ns/1ps

module traffic_light_tb;

reg clk;
reg rst;
reg vehicle;

wire [2:0] highway;
wire [2:0] country;

traffic_light_controller uut(
    .clk(clk),
    .rst(rst),
    .vehicle(vehicle),
    .highway(highway),
    .country(country)
);

// Clock generation
always #5 clk = ~clk;

initial
begin
    clk = 0;
    rst = 1;
    vehicle = 0;

    #20;
    rst = 0;

    // Highway stays green
    #80;

    // Vehicle arrives
    vehicle = 1;

    // Wait for side road green
    #120;

    // Vehicle leaves
    vehicle = 0;

    #80;

    $finish;
end

initial
begin
    $monitor("Time=%0t  State Lights -> Highway=%b  Country=%b  Vehicle=%b",
             $time, highway, country, vehicle);
end

initial begin
    $dumpfile("traffic.vcd");
    $dumpvars(0, traffic_light_tb);
end

endmodule