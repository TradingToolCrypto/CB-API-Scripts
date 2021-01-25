/*

   https://github.com/TradingToolCrypto/MT5-TradingToolCrypto/blob/master/MQL5/Include/TradingToolCrypto/CBP/CryptoBridgeProClass.mqh

*/

#property script_show_inputs
#include <TradingToolCrypto\CBP\CryptoBridgeProClass.mqh>
CryptoBridge bridge;      // cryptoBridge class



input group "TYPE IN THE ORDER TYPE"
input string Script_Open_Order = "STOP_BUY";
input string Order_Price_Trigger = "12345";
input string Order_ID = "ID12345";

//+------------------------------------------------------------------+
//| Script program start function                                    |
//+------------------------------------------------------------------+
void OnStart()
  {

   if(bridge.Init_Api_Keys(Exchange_Number))
     {
      Print("Api Keys Loaded");
     }

   /*
   Example using exchange
   - Binance Futures
   */

   string name_of_exchange = bridge.Get_Exchange_Name(Exchange_Number);

   if(Script_Open_Order == "STOP_SELL")
     {
      bridge.Open_Trade_Stop(Exchange_Symbol_Name,"SELL","STOP_LOSS",DoubleToString(Exchange_Lotsize,Exchange_Lot_Precision),Order_Price_Trigger,Exchange_Quote_Precision, Exchange_Lot_Precision,Exchange_Number,Order_ID);
     }

   if(Script_Open_Order == "STOP_BUY")
     {
      bridge.Open_Trade_Stop(Exchange_Symbol_Name,"BUY","STOP_LOSS",DoubleToString(Exchange_Lotsize,Exchange_Lot_Precision),Order_Price_Trigger,Exchange_Quote_Precision, Exchange_Lot_Precision,Exchange_Number,Order_ID);
     }

   /*

   Modify the order up or down by 1%

   - Only STOP_LOSS and LIMIT orders can be modified.
       - STOP_LOSS_LIMIT orders are currently not supported. These Orders need to be canceled them a new order needs to be sent.

   */
   double price_percentage = StringToDouble(Order_Price_Trigger) * 0.01;
   double price = StringToDouble(Order_Price_Trigger);
   double price_move_down = price - price_percentage;
   double price_move_up = price + price_percentage;

   /*

   need to create a new Order ID

   */
   string order_id = "ID123456";



   if(Script_Open_Order == "STOP_BUY")
     {
      bridge.Modify_Trade(Exchange_Symbol_Name,"BUY","STOP_LOSS",DoubleToString(Exchange_Lotsize,Exchange_Lot_Precision),DoubleToString(price_move_up,Exchange_Quote_Precision),order_id,Order_ID,0,Exchange_Quote_Precision,Exchange_Lot_Precision,Exchange_Number);
     }
   if(Script_Open_Order == "STOP_SELL")
     {
      bridge.Modify_Trade(Exchange_Symbol_Name,"BUY","STOP_LOSS",DoubleToString(Exchange_Lotsize,Exchange_Lot_Precision),DoubleToString(price_move_down,Exchange_Quote_Precision),order_id,Order_ID,0,Exchange_Quote_Precision,Exchange_Lot_Precision,Exchange_Number);
     }



  }
//+------------------------------------------------------------------+
