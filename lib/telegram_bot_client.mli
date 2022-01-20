include module type of Telegram_bot_client_response

(* type t

val read_messages: unit -> t

val write_message: string -> unit *)
(* HTTP API:
5044188832:AAHE9WzQsD3eCP5T_m-WjWIkELGlMwKj1qg *)
type t

val make: string -> t

val get_updates: t -> (response, unit) result Lwt.t