open Bot_client
open Lwt.Syntax
open Telegram_bot_client_response


type t = {
  urls: string list;
  timeout: float;
  client: Telegram_bot_client.t
}

let make ~urls ~telegram_bot_key ~timeout = {
  client=Telegram_bot_client.make telegram_bot_key;
  urls;
  timeout;
}

let fetch_updates client = 
  let offset = Telegram_bot_updates_store.get_offset() in
  Telegram_bot_client.get_updates client ~offset

let updates_to_offset: Telegram_bot_client_response.updates -> int = fun u ->
  try
    let last = u |> List.rev |> List.hd in
    last.update_id
  with
    _ -> 0

let react_for_ping { client; urls; timeout; } chat_id =
  Lwt_list.iter_s (fun s -> 
    let message = Printf.sprintf "The url is %s and timeout as is %s" s (Float.to_string timeout) in
    Telegram_bot_client.send_message client ~chat_id ~text:message
  ) urls

let handle_result { result } config =
  let offset = updates_to_offset (result) in
  let () = Telegram_bot_updates_store.save_offset offset in
  Lwt_list.iter_s(
    fun i -> match i.message.text with
      | "/start" -> Lwt.return (Telegram_bot_chats_store.add i.message.chat.id)
      | "/ping" -> react_for_ping config i.message.chat.id (* сheck_url
       который он чекает и timeout зы таймаут в
       не понятно до конца
        случае таймаута или просто конфиг таймут *)
      | _ -> Lwt.return_unit
  ) result


let rec handle_pings conf =
  let* response = fetch_updates conf.client in

  let* () = match response with
    | Ok(r) -> handle_result r conf
    | _ -> Lwt_io.print "kibana log updates fail" in

  let* () = Lwt_unix.sleep 3. in

  handle_pings conf