module traffic_light_controller(
    input clk,
    input rst,
    input vehicle,               // Vehicle detected on country road

    output reg [2:0] highway,
    output reg [2:0] country
);

// Light encoding
parameter RED    = 3'b100;
parameter YELLOW = 3'b010;
parameter GREEN  = 3'b001;

// FSM States
parameter HW_GREEN   = 2'd0;
parameter HW_YELLOW  = 2'd1;
parameter CT_GREEN   = 2'd2;
parameter CT_YELLOW  = 2'd3;

reg [1:0] state, next_state;
reg [3:0] timer;

// Timing (clock cycles)
parameter HW_GREEN_TIME  = 8;
parameter YELLOW_TIME    = 3;
parameter CT_GREEN_TIME  = 6;

//----------------------
// State Register
//----------------------
always @(posedge clk or posedge rst)
begin
    if(rst)
        state <= HW_GREEN;
    else
        state <= next_state;
end

//----------------------
// Timer
//----------------------
always @(posedge clk or posedge rst)
begin
    if(rst)
        timer <= 0;
    else if(state == next_state)
        timer <= timer + 1;
    else
        timer <= 0;
end

//----------------------
// Next-State Logic
//----------------------
always @(*)
begin
    next_state = state;

    case(state)

        // Highway has priority
        HW_GREEN:
        begin
            if(vehicle && timer >= HW_GREEN_TIME-1)
                next_state = HW_YELLOW;
        end

        HW_YELLOW:
        begin
            if(timer >= YELLOW_TIME-1)
                next_state = CT_GREEN;
        end

        CT_GREEN:
        begin
            if(!vehicle || timer >= CT_GREEN_TIME-1)
                next_state = CT_YELLOW;
        end

        CT_YELLOW:
        begin
            if(timer >= YELLOW_TIME-1)
                next_state = HW_GREEN;
        end

        default:
            next_state = HW_GREEN;

    endcase
end

//----------------------
// Output Logic
//----------------------
always @(*)
begin

    // Default
    highway = RED;
    country = RED;

    case(state)

        HW_GREEN:
        begin
            highway = GREEN;
            country = RED;
        end

        HW_YELLOW:
        begin
            highway = YELLOW;
            country = RED;
        end

        CT_GREEN:
        begin
            highway = RED;
            country = GREEN;
        end

        CT_YELLOW:
        begin
            highway = RED;
            country = YELLOW;
        end

    endcase

end

endmodule