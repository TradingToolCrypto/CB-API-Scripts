/*

   https://github.com/TradingToolCrypto/MT5-TradingToolCrypto/blob/master/MQL5/Include/TradingToolCrypto/CBP/CryptoBridgeProClass.mqh

*/

#property script_show_inputs
#include <TradingToolCrypto\CBP\CryptoBridgeProClass.mqh>
CryptoBridge bridge;      // cryptoBridge class



input group "TYPE IN THE ORDER TYPE"
input string Script_Open_Order = "STOPLIMIT_BUY";
input string Order_Price_Trigger = "12345";
input string Order_Price = "12345";
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
   
   if(Script_Open_Order == "STOPLIMIT_SELL")
     {
      bridge.Open_Trade_StopLimit(Exchange_Symbol_Name,"SELL","STOP_LOSS_LIMIT",DoubleToString(Exchange_Lotsize,Exchange_Lot_Precision),Order_Price,Order_Price_Trigger,Exchange_Quote_Precision, Exchange_Lot_Precision,Exchange_Number,Order_ID);
     }
     
   if(Script_Open_Order == "STOPLIMIT_BUY")
     {
      bridge.Open_Trade_StopLimit(Exchange_Symbol_Name,"BUY","STOP_LOSS_LIMIT",DoubleToString(Exchange_Lotsize,Exchange_Lot_Precision),Order_Price,Order_Price_Trigger,Exchange_Quote_Precision, Exchange_Lot_Precision,Exchange_Number,Order_ID);
     }


  }
//+------------------------------------------------------------------+
