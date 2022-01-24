open Bot_client
open Lwt.Syntax
open Telegram_bot_client_response

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

let handle_result { result } =
  let offset = updates_to_offset (result) in
  let () = Telegram_bot_updates_store.save_offset offset in
  Lwt_list.iter_s(
    fun i -> match i.message.text with
      | "/start" -> Lwt.return (Telegram_bot_chats_store.add i.message.chat.id)
      | "/ping" -> Lwt.return_unit (* сheck_url
       который он чекает и timeout зы таймаут в
       не понятно до конца
        случае таймаута или просто конфиг таймут *)
      | _ -> Lwt.return_unit
  ) result


let rec handle_pings () =
  let* response = fetch_updates() in

  let* () = match response with
    | Ok(r) -> handle_result r
    | _ -> Lwt_io.print "kibana log updates fail" in

  let* () = Lwt_unix.sleep 3. in

  handle_pings()