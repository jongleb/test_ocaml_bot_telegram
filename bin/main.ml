open Lwt.Syntax

let () = 
let client = Telegram_bot.Telegram_bot_client.make "5044188832:AAHE9WzQsD3eCP5T_m-WjWIkELGlMwKj1qg" in
Lwt_main.run begin
  let* _ = Telegram_bot.Telegram_bot_client.get_updates client in
  Lwt.return_unit
end