open Lwt.Syntax

open Cohttp_lwt_unix

include Telegram_bot_client_response

type t = { token: string }

let base_telegram_uri = "https://api.telegram.org"

let make token = { token }

let get_updates { token } = 
  let uri = base_telegram_uri ^ "/" ^ token |> Uri.of_string in
  let* (_ , b) = Client.get uri in
  let* json_str = b |> Cohttp_lwt.Body.to_string in
  json_str 
    |> Yojson.Safe.from_string 
    |> response_of_yojson 
    |> Result.map_error (Fun.const ())
    |> Lwt.return