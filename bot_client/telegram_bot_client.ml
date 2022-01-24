open Lwt.Syntax

open Cohttp_lwt_unix

include Telegram_bot_client_response
include Telegram_bot_client_request

type t = { token: string }

let base_telegram_uri = "https://api.telegram.org"

let make token = { token }

let get_updates { token } ~offset  = 

  let query = [("offset", Int.to_string offset)] in

  let with_query = base_telegram_uri ^ "/bot" ^ token ^ "/getUpdates"
    |> Uri.of_string 
    |> Uri.with_query' in  

  let* (_ , b) = Client.get (with_query query) in
  let+ json_str = b |> Cohttp_lwt.Body.to_string in

  json_str 
    |> Yojson.Safe.from_string 
    |> response_of_yojson 
    |> Result.map_error (Fun.const ())

let send_message { token } ~chat_id ~text =

  let url = base_telegram_uri ^ "/bot" ^ token ^ "/sendMessage" |> Uri.of_string in

  let body = { chat_id; text; } 
    |> request_to_yojson 
    |> Yojson.Safe.to_string 
    |> Cohttp_lwt.Body.of_string in

  let* (_, b) = Client.post ~body url in

  Lwt.return_unit