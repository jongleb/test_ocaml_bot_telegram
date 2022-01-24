open Check_url

open Lwt.Syntax

open Bot_client

open Telegram_bot_check_url_response

type t = Telegram_bot_check_url.t list

let telegram_client = Telegram_bot_client.make "5044188832:AAHE9WzQsD3eCP5T_m-WjWIkELGlMwKj1qg"

let sleep = ref(15.)

let init ~check_timeout ~timeout = 
  let () = sleep := check_timeout in
  List.map (Telegram_bot_check_url.make timeout)

let send_all_timeout { url; timeout } =
  let message = Printf.sprintf "The url %s was ended with timeout %s\n" url (Float.to_string timeout) in
  Lwt_list.iter_s (fun i -> 
    Telegram_bot_client.send_message telegram_client ~chat_id:i ~text: message
  ) (Telegram_bot_chats_store.to_list())

let send_all_fail { url; body; code } = 
  let m1 = Printf.sprintf "The url %s was ended with fail, code %n\n" url code in
  let m2 = Printf.sprintf "Body is %s" body in
  Lwt_list.iter_s (fun i -> 
    Lwt_list.iter_s 
      (fun text -> Telegram_bot_client.send_message telegram_client ~chat_id:i ~text) [m1;m2]
  ) (Telegram_bot_chats_store.to_list())  

let rec run checker = 
  let* pings = Lwt_list.map_s(Telegram_bot_check_url.ping) checker in
  let* () = Lwt_list.iter_s(fun i -> match i with
    | Timeout(t) -> send_all_timeout t
    | Fail(f) -> send_all_fail f
    | _ -> Lwt.return_unit
  ) pings in
  let* () = Lwt_unix.sleep !sleep in
  run checker