include module type of Telegram_bot_check_url_response

type t

val make: float -> string -> t

val ping: t -> ping_result Lwt.t