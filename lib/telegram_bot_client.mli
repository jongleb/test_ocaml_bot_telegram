include module type of Telegram_bot_client_response

type t

val make: string -> t

val get_updates: t -> (response, unit) result Lwt.t