open Check_url

open Lwt.Syntax

open Telegram_bot_check_url_response

type t = Telegram_bot_check_url.t list

let sleep = ref(15.)

let init ~check_timeout ~timeout = 
  let () = sleep := check_timeout in
  List.map (Telegram_bot_check_url.make timeout)

let rec run checker = 
  let* pings = Lwt_list.map_s(Telegram_bot_check_url.ping) checker in
  let* () = Lwt_list.iter_s(fun i -> match i with
    | Timeout(_) -> Lwt_io.print "timeout"
    | Fail(_) -> Lwt_io.print "fail"
    | _ -> Lwt_io.print "success"
  ) pings in
  let* () = Lwt_unix.sleep !sleep in
  run checker