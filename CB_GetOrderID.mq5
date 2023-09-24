/*

   https://github.com/TradingToolCrypto/MT5-TradingToolCrypto/blob/master/MQL5/Include/TradingToolCrypto/CBP/CryptoBridgeProClass.mqh

*/

#property script_show_inputs
#include <TradingToolCrypto\CBP\CryptoBridgeProClass.mqh>
CryptoBridge bridge;      // cryptoBridge class

//+------------------------------------------------------------------+
//| Script program start function                                    |
//+------------------------------------------------------------------+
void OnStart()
  {

   if(bridge.Init_Api_Keys(Exchange_Number))
     {
      Print("Api Keys Loaded");
     }

   string name = bridge.Get_Exchange_Name(Exchange_Number);

   if(bridge.Get_OpenOrders(Exchange_Symbol_Name,Exchange_Number,8))
     {


      bridge.Parse_Orders(name,500,1000);

      /*
      exchange data now within the arrays
      */



      int loop = ArraySize(exchange_name);
      for(int i = 0; i<loop; i++)
        {
         if(Exchange_Symbol_Name ==  exchange_symbol[i])
           {

            Print(" Order ID=" + exchange_orderid[i]);

           }
        }

     }




   bridge.Deinit_Api_Keys(Exchange_Number);

  }
//+------------------------------------------------------------------+
