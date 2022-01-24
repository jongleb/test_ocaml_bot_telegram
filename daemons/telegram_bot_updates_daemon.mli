type t

val make: urls: string list -> telegram_bot_key: string -> timeout: float -> t

val handle_pings: t -> unit Lwt.t