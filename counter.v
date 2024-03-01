module Counter(
  input wire clk,
  input wire reset_n,
  input wire [3:0] count_to,
  input wire count_inc,
  input wire count_dec,
  input wire load_en,
  output reg flag_count_max,
  output reg flag_count_min
);

  reg [3:0] counter;
  reg [3:0] count_max;

  always @(posedge clk or negedge reset_n) begin
    if (~reset_n) begin
      counter <= 4'b0000;
    end else begin
      if (load_en) begin
        counter <= 4'b0000;
        count_max <= count_to;
      end else begin
        if (count_inc & ~count_dec) begin
          counter <= (counter == count_max) ? counter : counter + 1;
        end else if (~count_inc & count_dec) begin
          counter <= (counter == 4'b0000) ? counter : counter - 1;
        end
      end
    end
  end

  always @(posedge clk) begin
    flag_count_max <= (counter == count_max);
    flag_count_min <= (counter == 4'b0000);
  end

endmodule

