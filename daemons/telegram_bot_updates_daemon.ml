open Bot_client
open Lwt.Syntax

let client = Telegram_bot_client.make "5044188832:AAHE9WzQsD3eCP5T_m-WjWIkELGlMwKj1qg"

let fetch_updates () = 
  let offset = Telegram_bot_updates_store.get_offset() in
  Telegram_bot_client.get_updates client ~offset

let updates_to_offset: Telegram_bot_client_response.updates -> int = fun u ->
  try
    let last = u |> List.rev |> List.hd in
    last.update_id
  with
    _ -> 0


let handle_pings () = 
  let* response = fetch_updates() in

  let open Telegram_bot_client in 
  let offset = updates_to_offset ((Result.get_ok response).result) in
  Lwt_io.print (Int.to_string offset)