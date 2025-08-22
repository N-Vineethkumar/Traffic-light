module Traffic(
input clk,rst, output reg [3:0]NS,EW
);
    parameter NS_Green = 3'b000;
    parameter NS_Yellow = 3'b001;
    parameter EW_Green = 3'b010;
    parameter EW_Yellow = 3'b011;
    
    parameter G=3'b001;
    parameter Y=3'b010;
    parameter R=3'b100;
    
    parameter gtime=10000;
    parameter ytime=1500;
    
    reg [2:0] c_state,nxt_state;
    
    reg [15:0] t_counter;
    
    always@(posedge clk or posedge rst)
    begin
    if(rst)begin
    c_state <= NS_Green;
    t_counter <= 0;
    end
    else begin
    c_state <= nxt_state;
    if(t_counter == 0) begin
    t_counter <= 0;
    end
    else begin
    t_counter <= t_counter - 1;
    end
    end
    end
    
    always@(c_state or t_counter)begin
    case(c_state)
    NS_Green:
    begin
    if(t_counter==0)begin
    nxt_state <= NS_Yellow;
    end
    else begin
    nxt_state <= NS_Green;
    end
    end
    NS_Yellow:
    begin
    if(t_counter==0)begin
    nxt_state <= EW_Green;
    end
    else begin
    nxt_state <= NS_Yellow;
    end
    end
    EW_Green:
    begin
    if(t_counter==0)begin
    nxt_state <= EW_Yellow;
    end
    else begin
    nxt_state <= EW_Green;
    end
    end
    EW_Yellow:
    begin
    if(t_counter==0)begin
    nxt_state <= NS_Green;
    end
    else begin
    nxt_state <= EW_Yellow;
    end
    end
    default:
    begin
    nxt_state <= NS_Green;
    end
    endcase
    end
    
    always@(c_state) begin
    case (c_state)
    NS_Green:
    begin
        NS=G;
        EW=R;
    end
    NS_Yellow:
    begin
        NS=Y;
        EW=R;
    end
    EW_Green:
    begin
        NS=R;
        EW=G;
    end
    EW_Yellow:
    begin
        NS=R;
        EW=Y;
    end
    endcase
    end
    
endmodule
