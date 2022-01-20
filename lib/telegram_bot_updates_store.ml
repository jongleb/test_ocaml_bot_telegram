open Telegram_bot_client_response

let offset: int ref = ref(0)
let save_offset int = offset := int
let get_offset () = !offset