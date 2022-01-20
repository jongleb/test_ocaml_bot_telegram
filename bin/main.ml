open Lwt.Syntax

open Bot_client

let () = 
let client = Telegram_bot_client.make "5044188832:AAHE9WzQsD3eCP5T_m-WjWIkELGlMwKj1qg" in
Lwt_main.run begin
  let offset = Telegram_bot_updates_store.get_offset() in
  let* _ = Telegram_bot_client.get_updates client ~offset in
  Lwt.return_unit
end