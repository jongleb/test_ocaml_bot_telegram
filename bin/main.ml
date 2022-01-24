open Daemons
open Lwt.Syntax

let list = [
  "https://mock.codes/420";
  "https://mock.codes/200"
]

let check_timeout = 3.

let request_timeout = 2.
let run_tasks () = 
  let daemon =
     Telegram_bot_check_urls_daemon.init
      ~check_timeout
      ~timeout:request_timeout list in
  let* _ = Lwt.all[
    Telegram_bot_check_urls_daemon.run daemon;
    Telegram_bot_updates_daemon.handle_pings()
  ] in
  Lwt.return_unit

let () = Lwt_main.run(run_tasks())