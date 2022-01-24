open Base
open Telegram_bot_check_url_response

type t = (string, fail_request_status, String.comparator_witness) Map.t

let map: t ref = ref(Map.empty (module String))

let set key data = map := Map.set !map ~key ~data

let get () = Map.to_alist !map