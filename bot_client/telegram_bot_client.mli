include module type of Telegram_bot_client_response

type t

val make: string -> t

val get_updates: t -> offset:int -> (response, unit) result Lwt.t

val send_message: t -> chat_id:int -> text:string -> unit Lwt.t