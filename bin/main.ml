open Daemons
open Lwt.Syntax

let list = [
  "https://mock.codes/420";
  "https://mock.codes/200"
]

let check_timeout = 3.

let request_timeout = 2.

let key = "5044188832:AAHE9WzQsD3eCP5T_m-WjWIkELGlMwKj1qg"
let run_tasks () = 

  let daemon_check_urls =
     Telegram_bot_check_urls_daemon.init
      ~check_timeout
      ~timeout:request_timeout list in

  let daemon_telegram_bot =
    Telegram_bot_updates_daemon.make 
      ~urls:list 
      ~telegram_bot_key:key
      ~timeout: check_timeout in

  let* _ = Lwt.all[
    Telegram_bot_check_urls_daemon.run daemon_check_urls;
    Telegram_bot_updates_daemon.handle_pings daemon_telegram_bot
  ] in
  Lwt.return_unit

let () = Lwt_main.run(run_tasks())