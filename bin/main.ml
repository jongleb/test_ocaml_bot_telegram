(* open Lwt.Syntax

open Bot_client *)
open Daemons

let () = 
  let daemon =
     Telegram_bot_check_urls_daemon.init
      ~check_timeout:10.
      ~timeout:10. ["https://mock.codes/420"] in 
  Lwt_main.run (Telegram_bot_check_urls_daemon.run daemon)