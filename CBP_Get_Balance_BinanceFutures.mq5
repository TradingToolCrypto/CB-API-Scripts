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

   /*
   Example using exchange
   - Binance Futures
   */

   string name_of_exchange = bridge.Get_Exchange_Name(Exchange_Number);

   if(bridge.Get_Balance("","",Exchange_Number))
     {

      Print("Balance Loaded into Global Variables");

      double wallet_balance_busd =  parse_globals(name_of_exchange, "Wallet", "BUSD","");

      Print("Wallet Balance BUSD ==>" + wallet_balance_busd);

      double wallet_balance_usdt =  parse_globals(name_of_exchange, "Wallet", "USDT","");

      Print("Wallet Balance USDT ==>" + wallet_balance_usdt);

      double wallet_balance_bnb =  parse_globals(name_of_exchange, "Wallet", "BNB","");

      Print("Wallet Balance BNB ==>" + wallet_balance_bnb);

      double wallet_balance_busd_margin =  parse_globals(name_of_exchange, "Wallet", "BUSD","MARGIN");

      Print("Wallet Balance BUSD MARGIN ==>" + wallet_balance_busd_margin);

      double wallet_balance_busd_pnl =  parse_globals(name_of_exchange, "Wallet", "BUSD","PNL");

      Print("Wallet Balance BUSD PNL ==>" + wallet_balance_busd_pnl);

     }

  }
/*

 Wallet balance is saved as a globale variable . The Global Name will look as the following
 - Binance_Wallet_BTC
   - Exchange Name
   - Wallet
   - Base currency or wallet name

 - Example
   parse_globals("Binance", "Wallet", "BUSD" ,"");

*/

//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
double parse_globals(string ex_name, string item, string base, string item_type)
  {
   bool debug = false;
   string sep="_";                // A separator as a character
   ushort u_sep;                  // The code of the separator character
   string result[];               // An array to get strings
   u_sep=StringGetCharacter(sep,0);
   int total = GlobalVariablesTotal();
   string name = "";
   int k =0;


   for(int i = 0; i < total; i++)
     {
      name = GlobalVariableName(i);
      k=StringSplit(name,u_sep,result);
      /*
      exchange name matches
      */
      if(result[0] == ex_name)
        {
         if(debug)
            Print(" compare 0 " + result[0]);
         /*
            Wallet found

         */
         if(result[1] == item)
           {
            if(debug)
               Print(" compare 1 " + result[1]);

            /*
            Search for the base currency such as  BTC, USDT, BUSD, ETH, BNB etc
            */

            if(result[2] == base)
              {
               if(debug)
                  Print(" compare 2 " + result[2]);

               /*
               Search for the base currency PNL, MARGIN , or return the  Balance
               */

               if(item_type == "")
                 {
                  if(debug)
                     Print(" Found the balance ");
                  return(GlobalVariableGet(name));
                 }
               else
                 {

                  /*
                  k is the size of the elements within the result[] array
                  some of the global variables only have 3 elements, therefore we to make sure the elements is equal to 4 before looking the value
                  otherwise we will get an array error
                  */

                  if(k == 4)
                    {

                     if(result[3] == item_type)
                       {
                        if(debug)
                           Print(" Found the balance item type " + item_type);
                        return(GlobalVariableGet(name));

                       }
                    }
                 }
              }
           }
        }
     }
   return(0);
  }
