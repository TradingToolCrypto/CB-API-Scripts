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

   Cancel a pending order that has not been filled yet.

   Cancel a pending order that you placed.

   Cancel a pending order where you know the clientOrderID

   -----------------------------------------------------------
   Cancel_Trade(string sym, string orderId, int exchangeNumber, int order_number, string clientOrderId)

     symbol          -
     orderId         - from the exchange ( the order id that the exchange generates for you)
                     - if you do not have this orderID, then leave the value blank with ""
     exchangeNumber  - the selected exchange
     order_number    - only used within the CryptoBridge GUI (not needed for custom robots)
     clientOrderId   -
   */
   
    bridge.Cancel_Trade(Exchange_Symbol_Name,"",Exchange_Number,0,Order_ID);
  }
//+------------------------------------------------------------------+
