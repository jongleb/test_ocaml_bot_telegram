open Telegram_bot_check_url_response

val set: string -> fail_request_status -> unit

val get: unit -> (string * fail_request_status) list