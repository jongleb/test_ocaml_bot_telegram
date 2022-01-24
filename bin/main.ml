(* open Lwt.Syntax

open Bot_client *)
open Daemons

let () = Lwt_main.run (Telegram_bot_updates_daemon.handle_pings ())